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
import java.util.Collections;
import java.util.Comparator;

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
            case "next_step": // Xử lý chuyển bước tiếp theo
                nextStep(request, response);
                break;
            case "revert_status": // Xử lý quay lại bước trước (có lý do)
                revertStatus(request, response);
                break;
            case "cancel": // Xử lý hủy đơn
                cancelOrder(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }

   //
private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 1. Lấy danh sách gốc
    List<DonHang> list = donHangService.getAllOrders();

    // 2. Lấy tham số sắp xếp từ URL
    String sortBy = request.getParameter("sortBy"); // id, code, customer, date, total, status
    String sortOrder = request.getParameter("sortOrder"); // asc, desc

    // Mặc định
    if (sortBy == null) sortBy = "id";
    if (sortOrder == null) sortOrder = "desc"; // Đơn hàng thường ưu tiên xem mới nhất (giảm dần) trước

    // 3. Xử lý sắp xếp
    if (list != null && !list.isEmpty()) {
        switch (sortBy) {
            case "code":
                // Sắp xếp theo Mã đơn hàng
                list.sort(Comparator.comparing(DonHang::getMaDonHang));
                break;
            case "customer":
                // Sắp xếp theo Tên người nhận (xử lý null)
                list.sort(Comparator.comparing(o -> o.getTenNguoiNhan() == null ? "" : o.getTenNguoiNhan()));
                break;
            case "date":
                // Sắp xếp theo Ngày đặt
                list.sort(Comparator.comparing(DonHang::getNgayDat));
                break;
            case "total":
                // Sắp xếp theo Tổng tiền (BigDecimal)
                list.sort(Comparator.comparing(DonHang::getTongThanhToan));
                break;
            case "status":
                // Sắp xếp theo Trạng thái
                list.sort(Comparator.comparing(DonHang::getTrangThaiDonHang));
                break;
            case "id":
            default:
                // Mặc định theo ID
                list.sort(Comparator.comparingInt(DonHang::getId));
                break;
        }

        // Đảo ngược nếu là desc
        if ("desc".equals(sortOrder)) {
            Collections.reverse(list);
        }
    }
    
    // 4. Gửi dữ liệu và trạng thái sắp xếp về JSP
    request.setAttribute("orderList", list);
    request.setAttribute("currentSortBy", sortBy);
    request.setAttribute("currentSortOrder", sortOrder);
    
    // Trỏ vào thư mục con ADMIN/QuanLyDonHang
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

    // --- LOGIC MỚI: CHUYỂN TRẠNG THÁI TUẦN TỰ (NEXT) ---
    private void nextStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DonHang order = donHangService.getOrderById(id);
            String currentStatus = order.getTrangThaiDonHang();
            String nextStatus = "";
            
            // In ra console để debug (Xem trong cửa sổ Output của Netbeans)
            System.out.println("DEBUG: Trạng thái hiện tại: " + currentStatus);

            switch (currentStatus) {
                case "cho_xac_nhan":
                    nextStatus = "da_xac_nhan";
                    break;
                case "da_xac_nhan":
                    nextStatus = "dang_giao";
                    break;
                case "dang_giao":
                    // LƯU Ý: Kiểm tra kỹ giá trị này trong CSDL của bạn
                    nextStatus = "hoan_thanh"; 
                    
                    // Cập nhật thanh toán
                    boolean payUpdated = donHangService.updatePaymentStatus(id, "da_thanh_toan");
                    if(payUpdated) {
                        System.out.println("DEBUG: Đã cập nhật thanh toán thành công.");
                    }
                    break;
                default:
                    break;
            }

            if (!nextStatus.isEmpty()) {
                // SỬA LỖI: Kiểm tra kết quả cập nhật (true/false)
                boolean isUpdated = donHangService.updateOrderStatus(id, nextStatus);
                
                if (isUpdated) {
                    request.getSession().setAttribute("message", "Đã cập nhật trạng thái đơn hàng thành: " + nextStatus);
                } else {
                    // Nếu vào đây, nghĩa là từ khóa nextStatus KHÔNG KHỚP với ENUM trong CSDL
                    request.getSession().setAttribute("message", "Lỗi: Không thể cập nhật trạng thái. Vui lòng kiểm tra log server.");
                    System.out.println("LỖI UPDATE: Có thể giá trị '" + nextStatus + "' không khớp với ENUM trong Database.");
                }
            }

            response.sendRedirect("admin_donhang?action=detail&id=" + id);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_donhang");
        }
    }

    // --- LOGIC MỚI: QUAY LẠI BƯỚC TRƯỚC (REVERT) ---
    private void revertStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String reason = request.getParameter("reason"); // Lý do
            
            DonHang order = donHangService.getOrderById(id);
            String currentStatus = order.getTrangThaiDonHang();
            String prevStatus = "";

            // Logic quay lại
            switch (currentStatus) {
                case "da_xac_nhan": prevStatus = "cho_xac_nhan"; break;
                case "dang_giao": prevStatus = "da_xac_nhan"; break;
                case "hoan_thanh": prevStatus = "dang_giao"; break;
            }

            if (!prevStatus.isEmpty()) {
                donHangService.updateOrderStatus(id, prevStatus);
                // Bạn có thể lưu lý do vào DB (ví dụ cập nhật ghi chú), ở đây tôi thông báo
                request.getSession().setAttribute("message", "Đã quay lại trạng thái trước. Lý do: " + reason);
            } else {
                request.getSession().setAttribute("message", "Không thể quay lại từ trạng thái này.");
            }
            
            response.sendRedirect("admin_donhang?action=detail&id=" + id);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_donhang");
        }
    }

    // --- LOGIC MỚI: HỦY ĐƠN HÀNG ---
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DonHang order = donHangService.getOrderById(id);
            
            // Chỉ cho phép hủy nếu chưa giao hàng
            if (!"dang_giao".equals(order.getTrangThaiDonHang()) && !"da_giao".equals(order.getTrangThaiDonHang())) {
                donHangService.updateOrderStatus(id, "da_huy");
                request.getSession().setAttribute("message", "Đã hủy đơn hàng thành công.");
            } else {
                request.getSession().setAttribute("message", "Không thể hủy đơn hàng đang giao hoặc đã giao.");
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