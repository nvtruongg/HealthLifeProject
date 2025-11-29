package com.healthlife.controller;

import com.healthlife.dao.DashboardDAO;
import com.healthlife.dto.ThongKeDTO;
import com.healthlife.dto.TopSanPhamDTO;
import com.healthlife.model.DonHang;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminHomeServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    private DashboardDAO dashboardDAO;

    @Override
    public void init() throws ServletException {
        this.dashboardDAO = new DashboardDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy số liệu tổng quan (Cards)
        request.setAttribute("totalRevenue", dashboardDAO.getTotalRevenue());
        request.setAttribute("totalOrders", dashboardDAO.getTotalOrders());
        request.setAttribute("totalCustomers", dashboardDAO.getTotalCustomers());
        request.setAttribute("totalProducts", dashboardDAO.getTotalProducts());
        
        // 2. Dữ liệu biểu đồ doanh thu (Line Chart)
        List<ThongKeDTO> revenueStats = dashboardDAO.getRevenueLast6Months();
        // Chuyển đổi sang chuỗi JSON thủ công cho Chart.js
        StringBuilder revLabels = new StringBuilder("[");
        StringBuilder revData = new StringBuilder("[");
        for (int i = 0; i < revenueStats.size(); i++) {
            revLabels.append("'").append(revenueStats.get(i).getNhan()).append("'");
            revData.append(revenueStats.get(i).getGiaTri());
            if (i < revenueStats.size() - 1) {
                revLabels.append(",");
                revData.append(",");
            }
        }
        revLabels.append("]");
        revData.append("]");
        
        request.setAttribute("revenueLabels", revLabels.toString());
        request.setAttribute("revenueData", revData.toString());
        
        // 3. Dữ liệu biểu đồ trạng thái (Doughnut Chart)
        List<ThongKeDTO> statusStats = dashboardDAO.getOrderStatusStats();
        StringBuilder statusLabels = new StringBuilder("[");
        StringBuilder statusData = new StringBuilder("[");
        for (int i = 0; i < statusStats.size(); i++) {
            // Map trạng thái sang tiếng Việt cho đẹp
            String statusName = statusStats.get(i).getNhan();
            if("cho_xac_nhan".equals(statusName)) statusName = "Chờ xác nhận";
            else if("da_xac_nhan".equals(statusName)) statusName = "Đã xác nhận";
            else if("dang_giao".equals(statusName)) statusName = "Đang giao";
            else if("hoan_thanh".equals(statusName)) statusName = "Hoàn tất";
            else if("da_huy".equals(statusName)) statusName = "Đã hủy";

            statusLabels.append("'").append(statusName).append("'");
            statusData.append(statusStats.get(i).getGiaTri());
            if (i < statusStats.size() - 1) {
                statusLabels.append(",");
                statusData.append(",");
            }
        }
        statusLabels.append("]");
        statusData.append("]");
        
        request.setAttribute("statusLabels", statusLabels.toString());
        request.setAttribute("statusData", statusData.toString());

        // 4. Top sản phẩm & Đơn hàng mới
        List<TopSanPhamDTO> topProducts = dashboardDAO.getTopSellingProducts();
        List<DonHang> recentOrders = dashboardDAO.getRecentOrders();
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("recentOrders", recentOrders);

        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("admin_home.jsp").forward(request, response);
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