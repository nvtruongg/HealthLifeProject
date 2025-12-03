package com.healthlife.controller;

import com.healthlife.model.ThuongHieu;
import com.healthlife.service.IThuongHieuService;
import com.healthlife.service.ThuongHieuService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Comparator;

/**
 * Servlet Controller cho chức năng Quản lý Thương hiệu.
 * URL: /admin_thuonghieu
 */
@WebServlet(name = "ThuongHieuServlet", urlPatterns = {"/admin_thuonghieu"})
public class ThuongHieuServlet extends HttpServlet {

    private IThuongHieuService thuongHieuService;

    @Override
    public void init() throws ServletException {
        this.thuongHieuService = new ThuongHieuService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

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
            default:
                list(request, response);
                break;
        }
    }

    //
private void list(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // 1. Lấy danh sách gốc
    List<ThuongHieu> list = thuongHieuService.getAll();

    // 2. Lấy tham số sắp xếp từ URL
    String sortBy = request.getParameter("sortBy"); // id, name, origin
    String sortOrder = request.getParameter("sortOrder"); // asc, desc

    // Mặc định
    if (sortBy == null) sortBy = "id";
    if (sortOrder == null) sortOrder = "asc";

    // 3. Xử lý sắp xếp
    if (list != null && !list.isEmpty()) {
        switch (sortBy) {
            case "name":
                // Sắp xếp theo Tên Thương hiệu (A-Z)
                list.sort(Comparator.comparing(ThuongHieu::getTenThuongHieu));
                break;
            case "origin":
                // Sắp xếp theo Xuất xứ (A-Z)
                list.sort(Comparator.comparing(ThuongHieu::getXuatXu));
                break;
            default:
                // Mặc định theo ID
                list.sort(Comparator.comparingInt(ThuongHieu::getId));
                break;
        }

        // Đảo ngược nếu là desc
        if ("desc".equals(sortOrder)) {
            Collections.reverse(list);
        }
    }

    // 4. Gửi dữ liệu về JSP
    request.setAttribute("thuongHieuList", list);
    request.setAttribute("currentSortBy", sortBy);
    request.setAttribute("currentSortOrder", sortOrder);
    
    request.getRequestDispatcher("admin_thuonghieu.jsp").forward(request, response);
}

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ten = request.getParameter("tenThuongHieu");
        String xuatXu = request.getParameter("xuatXu");
        String moTa = request.getParameter("moTa");
        // (Xử lý upload hinhAnhLogo sẽ phức tạp hơn, tạm thời để null)

        ThuongHieu th = new ThuongHieu(0, ten, xuatXu, null, moTa);
        if (thuongHieuService.add(th)) {
            request.getSession().setAttribute("message", "Thêm thương hiệu thành công!");
        } else {
            request.getSession().setAttribute("message", "Thêm thất bại! Tên và Xuất xứ là bắt buộc.");
        }
        response.sendRedirect("admin_thuonghieu");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ThuongHieu th = thuongHieuService.getById(id);
            if (th != null) {
                request.setAttribute("thuongHieuToEdit", th);
                request.getRequestDispatcher("edit_thuonghieu.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("message", "Không tìm thấy thương hiệu.");
                response.sendRedirect("admin_thuonghieu");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "ID không hợp lệ.");
            response.sendRedirect("admin_thuonghieu");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String ten = request.getParameter("tenThuongHieu");
            String xuatXu = request.getParameter("xuatXu");
            String moTa = request.getParameter("moTa");
            // (Xử lý upload hinhAnhLogo sẽ phức tạp hơn, tạm thời để null)

            ThuongHieu th = new ThuongHieu(id, ten, xuatXu, null, moTa);
            if (thuongHieuService.update(th)) {
                request.getSession().setAttribute("message", "Cập nhật thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật thất bại! Tên và Xuất xứ là bắt buộc.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Dữ liệu không hợp lệ.");
        }
        response.sendRedirect("admin_thuonghieu");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (thuongHieuService.delete(id)) {
                request.getSession().setAttribute("message", "Xóa thương hiệu thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa thất bại! (Có thể do ràng buộc sản phẩm)");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "ID không hợp lệ.");
        }
        response.sendRedirect("admin_thuonghieu");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}