package com.healthlife.controller;

import com.healthlife.model.NguoiDung;
import com.healthlife.service.INguoiDungService;
import com.healthlife.service.NguoiDungService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Comparator;

@WebServlet(name = "NguoiDungServlet", urlPatterns = {"/admin_nguoidung"})
public class NguoiDungServlet extends HttpServlet {

    private INguoiDungService nguoiDungService;

    @Override
    public void init() throws ServletException {
        this.nguoiDungService = new NguoiDungService();
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
            default:
                list(request, response);
                break;
        }
    }

    //
private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 1. Lấy danh sách gốc
    List<NguoiDung> list = nguoiDungService.getAllUsers();
    
    // 2. Lấy tham số sắp xếp từ URL
    String sortBy = request.getParameter("sortBy"); // id, fullname, email, role
    String sortOrder = request.getParameter("sortOrder"); // asc, desc

    // Mặc định
    if (sortBy == null) sortBy = "id";
    if (sortOrder == null) sortOrder = "asc";

    // 3. Xử lý sắp xếp
    if (list != null && !list.isEmpty()) {
        switch (sortBy) {
            case "fullname":
                list.sort(Comparator.comparing(NguoiDung::getFullname));
                break;
            case "email":
                list.sort(Comparator.comparing(NguoiDung::getEmail));
                break;
            case "role":
                list.sort(Comparator.comparing(NguoiDung::getRole));
                break;
            case "id":
            default:
                list.sort(Comparator.comparingInt(NguoiDung::getId));
                break;
        }

        // Đảo ngược nếu là desc
        if ("desc".equals(sortOrder)) {
            Collections.reverse(list);
        }
    }

    // 4. Gửi dữ liệu về JSP
    request.setAttribute("userList", list);
    request.setAttribute("currentSortBy", sortBy);
    request.setAttribute("currentSortOrder", sortOrder);
    
    request.getRequestDispatcher("admin_nguoidung.jsp").forward(request, response);
}

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String sdt = request.getParameter("sdt");
        String role = request.getParameter("role");
        
        // Tạo user mới (status mặc định là 'hoat_dong')
        NguoiDung u = new NguoiDung(email, password, role, fullname, sdt, "hoat_dong");

        if (nguoiDungService.addUser(u)) {
            request.getSession().setAttribute("message", "Thêm người dùng thành công!");
        } else {
            request.getSession().setAttribute("message", "Thêm thất bại (Email có thể đã tồn tại).");
        }
        response.sendRedirect("admin_nguoidung");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            NguoiDung u = nguoiDungService.getUserById(id);
            if (u != null) {
                request.setAttribute("userToEdit", u);
                request.getRequestDispatcher("edit_nguoidung.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin_nguoidung");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin_nguoidung");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String fullname = request.getParameter("fullname");
            String sdt = request.getParameter("sdt");
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            
            // --- LẤY EMAIL TỪ FORM ---
            String email = request.getParameter("email");

            NguoiDung u = new NguoiDung();
            u.setId(id);
            u.setFullname(fullname);
            u.setSdt(sdt);
            u.setRole(role);
            u.setStatus(status);
            u.setEmail(email); // Cập nhật email vào model

            if (nguoiDungService.updateUser(u)) {
                request.getSession().setAttribute("message", "Cập nhật thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin_nguoidung");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (nguoiDungService.deleteUser(id)) {
                request.getSession().setAttribute("message", "Xóa thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin_nguoidung");
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