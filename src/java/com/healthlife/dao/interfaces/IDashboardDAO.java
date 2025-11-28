package com.healthlife.dao.interfaces;

import com.healthlife.dto.ThongKe;
import com.healthlife.dto.TopSanPham;
import com.healthlife.model.DonHang;
import java.util.List;

public interface IDashboardDAO {
    // 1. Tổng doanh thu
    double getTotalRevenue();
    
    // 2. Tổng số đơn hàng
    int getTotalOrders();
    
    // 3. Tổng số sản phẩm
    int getTotalProducts();
    
    // 4. Tổng số khách hàng
    int getTotalCustomers();
    
    // 5. Doanh thu theo 6 tháng gần nhất (để vẽ biểu đồ đường)
    List<ThongKe> getRevenueLast6Months();
    
    // 6. Thống kê trạng thái đơn hàng (để vẽ biểu đồ tròn)
    List<ThongKe> getOrderStatusStats();
    
    // 7. Top 5 sản phẩm bán chạy nhất
    List<TopSanPham> getTopSellingProducts();
    
    // 8. 5 Đơn hàng mới nhất
    List<DonHang> getRecentOrders();
}