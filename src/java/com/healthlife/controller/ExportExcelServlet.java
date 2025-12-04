package com.healthlife.controller;

import com.healthlife.dao.DashboardDAO;
import com.healthlife.dto.ThongKeDTO;
import com.healthlife.dto.TopSanPhamDTO;
import com.healthlife.model.DonHang;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.NumberFormat;
import java.util.Locale;

@WebServlet(name = "ExportExcelServlet", urlPatterns = {"/export_excel"})
public class ExportExcelServlet extends HttpServlet {

    private DashboardDAO dashboardDAO;

    @Override
    public void init() throws ServletException {
        this.dashboardDAO = new DashboardDAO();
    }

    // Hàm xử lý dữ liệu CSV: Bao quanh bằng ngoặc kép nếu có dấu phẩy, xuống dòng...
    private String escapeCsv(String data) {
        if (data == null) {
            return "";
        }
        // Nếu dữ liệu có dấu phẩy, ngoặc kép hoặc xuống dòng -> bao quanh bằng ""
        if (data.contains(",") || data.contains("\"") || data.contains("\n")) {
            return "\"" + data.replace("\"", "\"\"") + "\"";
        }
        return data;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Thiết lập header trả về là file CSV
        response.setContentType("text/csv; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String fileName = "bao_cao_tong_quan_" + System.currentTimeMillis() + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        // 2. Lấy dữ liệu
        double totalRevenue = dashboardDAO.getTotalRevenue();
        int totalOrders = dashboardDAO.getTotalOrders();
        int totalCustomers = dashboardDAO.getTotalCustomers();
        int totalProducts = dashboardDAO.getTotalProducts();
        
        List<ThongKeDTO> revenueStats = dashboardDAO.getRevenueLast6Months();
        List<ThongKeDTO> statusStats = dashboardDAO.getOrderStatusStats();
        List<TopSanPhamDTO> topProducts = dashboardDAO.getTopSellingProducts();
        List<DonHang> recentOrders = dashboardDAO.getRecentOrders();
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

        // 3. Ghi dữ liệu
        try (PrintWriter out = response.getWriter()) {
            // Ghi BOM để Excel nhận diện UTF-8
            out.write('\ufeff');
            
            // --- QUAN TRỌNG: Dòng này giúp Excel nhận diện dấu phẩy là dấu phân cách ---
            // Tuy nhiên, dòng này sẽ hiển thị ở dòng đầu tiên trong Excel.
            // Nếu bạn thấy phiền, có thể bỏ qua, nhưng Excel một số máy sẽ cần thao tác "Data -> Text to Columns"
            // out.println("sep=,"); 
            
            // --- PHẦN 1: TỔNG QUAN ---
            out.println("BÁO CÁO TỔNG QUAN HỆ THỐNG");
            out.println("Ngày xuất:," + sdf.format(new java.util.Date()));
            out.println(); // Dòng trống
            
            out.println("THỐNG KÊ CHUNG");
            out.println("Chỉ số,Giá trị");
            // Xuất số nguyên thủy (không định dạng tiền tệ) để Excel hiểu là số
            out.println("Tổng doanh thu," + String.format("%.0f", totalRevenue)); 
            out.println("Tổng đơn hàng," + totalOrders);
            out.println("Tổng khách hàng," + totalCustomers);
            out.println("Tổng sản phẩm," + totalProducts);
            out.println();
            
            // --- PHẦN 2: DOANH THU 6 THÁNG ---
            out.println("DOANH THU 6 THÁNG GẦN NHẤT");
            out.println("Tháng,Doanh thu (VND)");
            for (ThongKeDTO stat : revenueStats) {
                out.println(escapeCsv(stat.getNhan()) + "," + String.format("%.0f", stat.getGiaTri()));
            }
            out.println();

            // --- PHẦN 3: TRẠNG THÁI ĐƠN HÀNG ---
            out.println("THỐNG KÊ TRẠNG THÁI ĐƠN HÀNG");
            out.println("Trạng thái,Số lượng");
            for (ThongKeDTO stat : statusStats) {
                String label = stat.getNhan();
                if("cho_xac_nhan".equals(label)) label = "Chờ xác nhận";
                else if("da_xac_nhan".equals(label)) label = "Đã xác nhận";
                else if("dang_giao".equals(label)) label = "Đang giao";
                else if("da_giao".equals(label) || "hoan_thanh".equals(label)) label = "Hoàn tất"; // Cập nhật cho khớp logic mới
                else if("da_huy".equals(label)) label = "Đã hủy";
                
                out.println(escapeCsv(label) + "," + (int)stat.getGiaTri());
            }
            out.println();

            // --- PHẦN 4: TOP SẢN PHẨM BÁN CHẠY ---
            out.println("TOP 5 SẢN PHẨM BÁN CHẠY");
            out.println("Tên sản phẩm,Số lượng bán,Doanh thu");
            for (TopSanPhamDTO top : topProducts) {
                out.println(escapeCsv(top.getTenSanPham()) + "," + top.getSoLuongBan() + "," + String.format("%.0f", top.getDoanhThu()));
            }
            out.println();

            // --- PHẦN 5: ĐƠN HÀNG MỚI NHẤT ---
            out.println("DANH SÁCH ĐƠN HÀNG MỚI NHẤT");
            out.println("ID,Mã Đơn,Khách Hàng,Tổng Tiền,Trạng Thái,Ngày Đặt");
            for (DonHang o : recentOrders) {
                String ten = o.getTenNguoiNhan() != null ? o.getTenNguoiNhan() : "";
                String status = o.getTrangThaiDonHang();
                if("da_giao".equals(status) || "hoan_thanh".equals(status)) status = "Hoàn thành";
                else if("da_huy".equals(status)) status = "Đã hủy";
                else if("cho_xac_nhan".equals(status)) status = "Chờ xác nhận";
                else if("da_xac_nhan".equals(status)) status = "Đã xác nhận";
                else if("dang_giao".equals(status)) status = "Đang giao";
                
                StringBuilder sb = new StringBuilder();
                sb.append(o.getId()).append(",");
                sb.append(escapeCsv(o.getMaDonHang())).append(",");
                sb.append(escapeCsv(ten)).append(",");
                sb.append(String.format("%.0f", o.getTongThanhToan())).append(",");
                sb.append(escapeCsv(status)).append(",");
                sb.append(sdf.format(o.getNgayDat()));
                
                out.println(sb.toString());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}