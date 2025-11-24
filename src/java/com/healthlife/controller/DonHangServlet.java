package com.healthlife.controller;

import com.healthlife.model.ChiTietDonHang;
import com.healthlife.model.DonHang;
import com.healthlife.service.DonHangService;
import com.healthlife.service.IDonHangService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DonHangServlet", urlPatterns = {"/admin_donhang"})
public class DonHangServlet extends HttpServlet {

    private IDonHangService donHangService;

    @Override
    public void init() throws ServletException {
        this.donHangService = new DonHangService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                viewDetail(request, response);
                break;
            case "update_status":
                updateStatus(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<DonHang> list = donHangService.getAllOrders();
        request.setAttribute("orderList", list);
        request.getRequestDispatcher("admin_donhang.jsp").forward(request, response);
    }

    private void viewDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DonHang order = donHangService.getOrderById(id);
            
            if (order != null) {
                List<ChiTietDonHang> details = donHangService.getOrderDetails(id);
                request.setAttribute("order", order);
                request.setAttribute("orderDetails", details);
                request.getRequestDispatcher("detail_donhang.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin_donhang");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin_donhang");
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status"); // Trạng thái đơn hàng
            String paymentStatus = request.getParameter("paymentStatus"); // Trạng thái thanh toán

            // --- LOGIC MỚI: Ràng buộc trạng thái ---
            // Nếu đơn hàng là "Đã giao" (da_giao) -> Bắt buộc thanh toán là "Đã thanh toán" (da_thanh_toan)
            if ("da_giao".equals(status)) {
                paymentStatus = "da_thanh_toan";
            }

            boolean updated = false;
            if (status != null && !status.isEmpty()) {
                updated = donHangService.updateOrderStatus(id, status);
            }
            
            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                donHangService.updatePaymentStatus(id, paymentStatus);
                updated = true;
            }

            if (updated) {
                request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật thất bại.");
            }
            
            response.sendRedirect("admin_donhang?action=detail&id=" + id);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_donhang");
        }
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