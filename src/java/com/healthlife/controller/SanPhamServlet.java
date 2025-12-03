package com.healthlife.controller;

import com.healthlife.model.SanPham;
import com.healthlife.service.DanhMucService;
import com.healthlife.service.SanPhamService;
import com.healthlife.service.ThuongHieuService;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Comparator;

@WebServlet(name = "SanPhamServlet", urlPatterns = {"/admin_sanpham"})
public class SanPhamServlet extends HttpServlet {

    private SanPhamService sanPhamService;
    private DanhMucService danhMucService;
    private ThuongHieuService thuongHieuService;

    @Override
    public void init() throws ServletException {
        this.sanPhamService = new SanPhamService();
        this.danhMucService = new DanhMucService();
        this.thuongHieuService = new ThuongHieuService();
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
            case "view_add": // Hiển thị form thêm mới (cần load danh mục, thương hiệu)
                showAddForm(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }

   private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy danh sách gốc từ Service
        List<SanPham> list = sanPhamService.getAllProducts();

        // 2. Lấy tham số sắp xếp từ request
        String sortBy = request.getParameter("sortBy"); // Tên cột: price, name, id...
        String sortOrder = request.getParameter("sortOrder"); // Chiều: asc, desc

        // Mặc định nếu không có tham số
        if (sortBy == null) sortBy = "id";
        if (sortOrder == null) sortOrder = "asc";

        // 3. Xử lý sắp xếp danh sách bằng Java Comparator
        if (list != null && !list.isEmpty()) {
            switch (sortBy) {
                case "price":
                    list.sort(Comparator.comparing(SanPham::getGiaBan));
                    break;
                case "name":
                    list.sort(Comparator.comparing(SanPham::getTenSanPham));
                    break;
                case "code":
                    list.sort(Comparator.comparing(SanPham::getMaSanPham));
                    break;
                case "category":
            // Sắp xếp theo tên danh mục (xử lý null để tránh lỗi)
            list.sort(Comparator.comparing(sp -> sp.getTenDanhMuc() == null ? "" : sp.getTenDanhMuc()));
            break;
        case "stock":
            // Sắp xếp theo số lượng tồn (int)
            list.sort(Comparator.comparingInt(SanPham::getSoLuongTon));
            break;
        case "status":
            // Sắp xếp theo chuỗi trạng thái (dang_kinh_doanh / ngung_kinh_doanh)
            list.sort(Comparator.comparing(SanPham::getTrangThai));
            break;
                default: // mặc định theo ID
                    list.sort(Comparator.comparingInt(SanPham::getId));
                    break;
            }

            // Nếu chiều là giảm dần (desc) thì đảo ngược danh sách
            if ("desc".equals(sortOrder)) {
                Collections.reverse(list);
            }
        }

        // 4. Gửi danh sách và trạng thái sắp xếp hiện tại về JSP để giữ trạng thái
        request.setAttribute("productList", list);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortOrder", sortOrder);
        
        request.getRequestDispatcher("admin_sanpham.jsp").forward(request, response);
    }
    
    // Hiển thị form thêm mới
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cần load danh mục và thương hiệu để hiển thị dropdown chọn
        request.setAttribute("danhMucList", danhMucService.getAllCategories());
        request.setAttribute("thuongHieuList", thuongHieuService.getAll());
        request.getRequestDispatcher("add_sanpham.jsp").forward(request, response);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            SanPham sp = new SanPham();
            // Lấy dữ liệu từ form
            sp.setMaSanPham(request.getParameter("maSanPham"));
            sp.setTenSanPham(request.getParameter("tenSanPham"));
            sp.setIdDanhMuc(Integer.parseInt(request.getParameter("idDanhMuc")));
            sp.setIdThuongHieu(Integer.parseInt(request.getParameter("idThuongHieu")));
            sp.setGiaGoc(new BigDecimal(request.getParameter("giaGoc")));
            sp.setGiaBan(new BigDecimal(request.getParameter("giaBan")));
            sp.setSoLuongTon(Integer.parseInt(request.getParameter("soLuongTon")));
            sp.setDonViTinh(request.getParameter("donViTinh"));
            sp.setTrangThai(request.getParameter("trangThai"));
            sp.setMoTaNgan(request.getParameter("moTaNgan"));
            sp.setMoTaChiTiet(request.getParameter("moTaChiTiet"));
            sp.setThanhPhan(request.getParameter("thanhPhan"));
            sp.setCongDung(request.getParameter("congDung"));
            sp.setLieuDungCachDung(request.getParameter("lieuDungCachDung"));
            sp.setBaoQuan(request.getParameter("baoQuan"));
            // Tạm thời để ảnh rỗng hoặc giá trị mặc định nếu chưa xử lý upload
            sp.setHinhAnhDaiDien(request.getParameter("hinhAnhDaiDien") != null ? request.getParameter("hinhAnhDaiDien") : "");

            if (sanPhamService.addProduct(sp)) {
                request.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("message", "Thêm thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi dữ liệu: " + e.getMessage());
        }
        response.sendRedirect("admin_sanpham");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            SanPham sp = sanPhamService.getProductById(id);
            if (sp != null) {
                request.setAttribute("productToEdit", sp);
                // Load danh sách dropdown
                request.setAttribute("danhMucList", danhMucService.getAllCategories());
                request.setAttribute("thuongHieuList", thuongHieuService.getAll());
                request.getRequestDispatcher("edit_sanpham.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin_sanpham");
            }
        } catch (Exception e) {
            response.sendRedirect("admin_sanpham");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            SanPham sp = new SanPham();
            sp.setId(id);
            // Lấy lại toàn bộ thông tin từ form (tương tự add)
            sp.setMaSanPham(request.getParameter("maSanPham"));
            sp.setTenSanPham(request.getParameter("tenSanPham"));
            sp.setIdDanhMuc(Integer.parseInt(request.getParameter("idDanhMuc")));
            sp.setIdThuongHieu(Integer.parseInt(request.getParameter("idThuongHieu")));
            sp.setGiaGoc(new BigDecimal(request.getParameter("giaGoc")));
            sp.setGiaBan(new BigDecimal(request.getParameter("giaBan")));
            sp.setSoLuongTon(Integer.parseInt(request.getParameter("soLuongTon")));
            sp.setDonViTinh(request.getParameter("donViTinh"));
            sp.setTrangThai(request.getParameter("trangThai"));
            sp.setMoTaNgan(request.getParameter("moTaNgan"));
            sp.setMoTaChiTiet(request.getParameter("moTaChiTiet"));
            sp.setThanhPhan(request.getParameter("thanhPhan"));
            sp.setCongDung(request.getParameter("congDung"));
            sp.setLieuDungCachDung(request.getParameter("lieuDungCachDung"));
            sp.setBaoQuan(request.getParameter("baoQuan"));
            // Tạm thời giữ nguyên ảnh hoặc cập nhật nếu có logic upload
            sp.setHinhAnhDaiDien(request.getParameter("hinhAnhDaiDien") != null ? request.getParameter("hinhAnhDaiDien") : "");

            if (sanPhamService.updateProduct(sp)) {
                 request.getSession().setAttribute("message", "Cập nhật thành công!");
            } else {
                 request.getSession().setAttribute("message", "Cập nhật thất bại.");
            }
        } catch (Exception e) {
             e.printStackTrace();
             request.getSession().setAttribute("message", "Lỗi cập nhật: " + e.getMessage());
        }
        response.sendRedirect("admin_sanpham");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if(sanPhamService.deleteProduct(id)) {
                request.getSession().setAttribute("message", "Xóa thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin_sanpham");
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