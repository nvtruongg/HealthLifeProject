package com.healthlife.controller;

import com.healthlife.model.BaiViet;
import com.healthlife.model.NguoiDung;
import com.healthlife.service.BaiVietService;
import com.healthlife.service.IBaiVietService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Collections;
import java.util.Comparator;

@WebServlet(name = "BaiVietServlet", urlPatterns = {"/admin_baiviet"})
public class BaiVietServlet extends HttpServlet {

    private IBaiVietService baiVietService;

    @Override
    public void init() throws ServletException {
        this.baiVietService = new BaiVietService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                add(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "view_add":
                // Chuyển đến trang thêm mới
                request.getRequestDispatcher("add_baiviet.jsp").forward(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }

    //
private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 1. Lấy danh sách gốc
    List<BaiViet> list = baiVietService.getAll();
    
    // 2. Lấy tham số sắp xếp
    String sortBy = request.getParameter("sortBy"); // id, title, author, date, status
    String sortOrder = request.getParameter("sortOrder"); // asc, desc

    // Mặc định
    if (sortBy == null) sortBy = "id";
    if (sortOrder == null) sortOrder = "desc"; // Bài viết thường ưu tiên xem mới nhất

    // 3. Xử lý sắp xếp
    if (list != null && !list.isEmpty()) {
        switch (sortBy) {
            case "title":
                list.sort(Comparator.comparing(BaiViet::getTieuDe));
                break;
            case "author":
                // Xử lý null khi get tên người tạo
                list.sort(Comparator.comparing(bv -> bv.getTenNguoiTao() == null ? "" : bv.getTenNguoiTao()));
                break;
            case "date":
                list.sort(Comparator.comparing(BaiViet::getNgayDang));
                break;
            case "status":
                list.sort(Comparator.comparing(BaiViet::getTrangThai));
                break;
            case "id":
            default:
                list.sort(Comparator.comparingInt(BaiViet::getId));
                break;
        }

        // Đảo ngược nếu là desc
        if ("desc".equals(sortOrder)) {
            Collections.reverse(list);
        }
    }
    
    // 4. Gửi dữ liệu về JSP
    request.setAttribute("baiVietList", list);
    request.setAttribute("currentSortBy", sortBy);
    request.setAttribute("currentSortOrder", sortOrder);

    request.getRequestDispatcher("admin_baiviet.jsp").forward(request, response);
}

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String tieuDe = request.getParameter("tieuDe");
            String tomTat = request.getParameter("tomTat");
            String noiDung = request.getParameter("noiDung");
            String hinhAnh = request.getParameter("hinhAnhTieuDe"); // URL ảnh
            String trangThai = request.getParameter("trangThai");
            
            // Lấy ID người đang đăng nhập
            HttpSession session = request.getSession();
            NguoiDung admin = (NguoiDung) session.getAttribute("account");
            int idNguoiTao = (admin != null) ? admin.getId() : 1; // Mặc định 1 nếu lỗi

            BaiViet bv = new BaiViet();
            bv.setTieuDe(tieuDe);
            bv.setTomTat(tomTat);
            bv.setNoiDung(noiDung);
            bv.setHinhAnhTieuDe(hinhAnh);
            bv.setIdNguoiTao(idNguoiTao);
            bv.setTrangThai(trangThai);

            if (baiVietService.add(bv)) {
                request.getSession().setAttribute("message", "Thêm bài viết thành công!");
            } else {
                request.getSession().setAttribute("message", "Thêm thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi dữ liệu.");
        }
        response.sendRedirect("admin_baiviet");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BaiViet bv = baiVietService.getById(id);
            if (bv != null) {
                request.setAttribute("baiVietToEdit", bv);
                request.getRequestDispatcher("edit_baiviet.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin_baiviet");
            }
        } catch (Exception e) {
            response.sendRedirect("admin_baiviet");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String tieuDe = request.getParameter("tieuDe");
            String tomTat = request.getParameter("tomTat");
            String noiDung = request.getParameter("noiDung");
            String hinhAnh = request.getParameter("hinhAnhTieuDe");
            String trangThai = request.getParameter("trangThai");

            BaiViet bv = new BaiViet();
            bv.setId(id);
            bv.setTieuDe(tieuDe);
            bv.setTomTat(tomTat);
            bv.setNoiDung(noiDung);
            bv.setHinhAnhTieuDe(hinhAnh);
            bv.setTrangThai(trangThai);

            if (baiVietService.update(bv)) {
                request.getSession().setAttribute("message", "Cập nhật thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin_baiviet");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (baiVietService.delete(id)) {
                request.getSession().setAttribute("message", "Xóa thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin_baiviet");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}