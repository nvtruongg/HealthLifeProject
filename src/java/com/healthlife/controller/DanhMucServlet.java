package com.healthlife.controller;

import com.healthlife.service.DanhMucService;
import com.healthlife.service.IDanhMucService;
import com.healthlife.model.DanhMuc;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Comparator;

/*
 * Servlet Controller cho DanhMuc.
 * Đã đổi tên từ CategoryServlet.
 * SỬA LỖI: Cập nhật URL pattern thành "admin_danhmuc" (dấu gạch dưới)
 */
@WebServlet(name = "DanhMucServlet", urlPatterns = {"/admin_danhmuc"})
public class DanhMucServlet extends HttpServlet {
    
    private IDanhMucService danhMucService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.danhMucService = new DanhMucService();
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
                addCategory(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
                
            // --- THÊM MỚI ---
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
                
            case "list":
            default:
                listCategories(request, response);
                break;
        }
    }

    //
private void listCategories(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // 1. Lấy danh sách gốc
    List<DanhMuc> categoryList = danhMucService.getAllCategories();
    
    // 2. Lấy tham số sắp xếp từ URL
    String sortBy = request.getParameter("sortBy"); // id, name, description, parent
    String sortOrder = request.getParameter("sortOrder"); // asc, desc

    // Mặc định
    if (sortBy == null) sortBy = "id";
    if (sortOrder == null) sortOrder = "asc";

    // 3. Xử lý sắp xếp
    if (categoryList != null && !categoryList.isEmpty()) {
        switch (sortBy) {
            case "name":
                // Sắp xếp theo Tên Danh mục
                categoryList.sort(Comparator.comparing(DanhMuc::getTenDanhMuc));
                break;
            case "description":
                // Sắp xếp theo Mô tả (xử lý null để tránh lỗi)
                categoryList.sort(Comparator.comparing(dm -> dm.getMoTa() == null ? "" : dm.getMoTa()));
                break;
            case "parent":
                // Sắp xếp theo ID Cha (đưa danh mục gốc/null lên đầu)
                categoryList.sort(Comparator.comparingInt(dm -> dm.getIdDanhMucCha() == null ? 0 : dm.getIdDanhMucCha()));
                break;
            default:
                // Mặc định theo ID
                categoryList.sort(Comparator.comparingInt(DanhMuc::getId));
                break;
        }

        // Đảo ngược nếu là desc
        if ("desc".equals(sortOrder)) {
            Collections.reverse(categoryList);
        }
    }
    
    // 4. Gửi dữ liệu và trạng thái sắp xếp về JSP
    request.setAttribute("danhMucList", categoryList);
    request.setAttribute("currentSortBy", sortBy);
    request.setAttribute("currentSortOrder", sortOrder);
    
    request.getRequestDispatcher("admin_danhmuc.jsp").forward(request, response);
}
    
    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tenDanhMuc = request.getParameter("tenDanhMuc");
        String moTa = request.getParameter("moTa");
        String idChaStr = request.getParameter("idDanhMucCha");
        
        Integer idCha = null;
        if (idChaStr != null && !idChaStr.isEmpty()) {
            try {
                idCha = Integer.parseInt(idChaStr);
            } catch (NumberFormatException e) {
                idCha = 0; 
            }
        }

        boolean result = danhMucService.addCategory(tenDanhMuc, moTa, idCha);
        
        if (result) {
            request.getSession().setAttribute("message", "Thêm danh mục thành công!");
        } else {
            request.getSession().setAttribute("message", "Thêm danh mục thất bại. (Có thể tên bị trống)");
        }
        
        // SỬA LỖI: Cập nhật URL redirect (dấu gạch dưới)
        response.sendRedirect("admin_danhmuc"); // Mặc định là action=list
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean result = danhMucService.deleteCategory(id);
            
             if (result) {
                request.getSession().setAttribute("message", "Xóa danh mục thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa danh mục thất bại! (Có thể do ràng buộc sản phẩm)");
            }
            
        } catch (NumberFormatException e) {
             request.getSession().setAttribute("message", "ID danh mục không hợp lệ.");
        }
        
        // SỬA LỖI: Cập nhật URL redirect (dấu gạch dưới)
        response.sendRedirect("admin_danhmuc");
    }

    // --- PHƯƠNG THỨC HIỂN THỊ FORM SỬA ---
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // 1. Lấy danh mục cần sửa
            DanhMuc danhMucToEdit = danhMucService.getCategoryById(id);
            
            // 2. Lấy toàn bộ danh sách để làm dropdown "danh mục cha"
            List<DanhMuc> categoryList = danhMucService.getAllCategories();
            
            if (danhMucToEdit != null) {
                // Đặt cả 2 vào request
                request.setAttribute("danhMucToEdit", danhMucToEdit);
                request.setAttribute("danhMucList", categoryList);
                
                // Chuyển đến trang JSP mới để sửa
                request.getRequestDispatcher("edit_danhmuc.jsp").forward(request, response);
            } else {
                // Xử lý nếu không tìm thấy ID
                request.getSession().setAttribute("message", "Không tìm thấy danh mục để sửa.");
                // SỬA LỖI: Cập nhật URL redirect (dấu gạch dưới)
                response.sendRedirect("admin_danhmuc");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "ID danh mục không hợp lệ.");
            // SỬA LỖI: Cập nhật URL redirect (dấu gạch dưới)
            response.sendRedirect("admin_danhmuc");
        }
    }
    
    // --- THÊM MỚI: PHƯƠNG THỨC XỬ LÝ CẬP NHẬT ---
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String tenDanhMuc = request.getParameter("tenDanhMuc");
            String moTa = request.getParameter("moTa");
            String idChaStr = request.getParameter("idDanhMucCha");

            Integer idCha = null;
            if (idChaStr != null && !idChaStr.isEmpty()) {
                idCha = Integer.parseInt(idChaStr);
            }

            // Tạo đối tượng DanhMuc
            DanhMuc danhMuc = new DanhMuc(id, tenDanhMuc, idCha, null, moTa); // hinhAnh tạm thời là null

            // Gọi service để cập nhật
            boolean result = danhMucService.updateCategory(danhMuc);

            if (result) {
                request.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật danh mục thất bại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Dữ liệu cập nhật không hợp lệ.");
        }
        
        // SỬA LỖI: Cập nhật URL redirect (dấu gạch dưới)
        response.sendRedirect("admin_danhmuc");
    }


    // --- THÊM LẠI PHƯƠNG THỨC doGet BỊ THIẾU ---
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