<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tiêu đề riêng của trang -->
    <title>Bảng điều khiển Admin</title>
    
    <!-- CSS chung (Tailwind, Font Awesome, Font) -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Tải Chart.js (chỉ trang này mới cần) -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        .sidebar-link.active {
            background-color: #3b82f6; color: white;
            box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.3), 0 2px 4px -2px rgba(59, 130, 246, 0.2);
        }
        .sidebar-link:not(.active):hover { background-color: #f1f5f9; color: #3b82f6; }
    </style>
</head>
<body class="bg-slate-50">

    <div class="flex h-screen overflow-hidden">
        
        <!-- Gọi Sidebar vào -->
        <!-- Đặt 'activePage' là 'home' -->
        <!-- SỬA LỖI 500: Xóa dòng trống giữa <include> và <param> -->
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="home" /></jsp:include>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Gọi Header vào -->
            <!-- Chúng ta truyền 'pageTitle' cho header để nó hiển thị "Bảng điều khiển" -->
            <c:set var="pageTitle" value="Bảng điều khiển" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <!-- Main content (Nội dung chính của trang này) -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                
                <!-- Hàng Thống kê nhanh -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <!-- Widget 1: Doanh thu -->
                    <div class="bg-white rounded-xl shadow-lg p-6 flex items-center justify-between">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Tổng doanh thu</span>
                            <h3 class="text-3xl font-bold text-gray-900 mt-1">1.5T VNĐ</h3>
                        </div>
                        <div class="w-14 h-14 bg-blue-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-dollar-sign fa-2x text-blue-600"></i>
                        </div>
                    </div>
                    <!-- Widget 2: Đơn hàng -->
                    <div class="bg-white rounded-xl shadow-lg p-6 flex items-center justify-between">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Đơn hàng mới</span>
                            <h3 class="text-3xl font-bold text-gray-900 mt-1">128</h3>
                        </div>
                        <div class="w-14 h-14 bg-green-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-shopping-cart fa-2x text-green-600"></i>
                        </div>
                    </div>
                    <!-- Widget 3: Người dùng -->
                    <div class="bg-white rounded-xl shadow-lg p-6 flex items-center justify-between">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Khách hàng</span>
                            <h3 class="text-3xl font-bold text-gray-900 mt-1">5,209</h3>
                        </div>
                        <div class="w-14 h-14 bg-yellow-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-users fa-2x text-yellow-600"></i>
                        </div>
                    </div>
                    <!-- Widget 4: Sản phẩm -->
                    <div class="bg-white rounded-xl shadow-lg p-6 flex items-center justify-between">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Sản phẩm</span>
                            <h3 class="text-3xl font-bold text-gray-900 mt-1">754</h3>
                        </div>
                        <div class="w-14 h-14 bg-indigo-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-box-open fa-2x text-indigo-600"></i>
                        </div>
                    </div>
                </div>

                <!-- Hàng Biểu đồ và Truy cập nhanh -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    
                    <!-- Cột Biểu đồ doanh thu (chiếm 2/3) -->
                    <div class="lg:col-span-2 bg-white rounded-xl shadow-lg p-6">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Biểu đồ Doanh thu (6 tháng)</h3>
                        <div class="h-80">
                            <!-- Chart.js sẽ vẽ vào đây -->
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>

                    <!-- Cột Truy cập nhanh (chiếm 1/3) -->
                    <div class="bg-white rounded-xl shadow-lg p-6">
                        <h3 class="text-xl font-bold text-gray-800 mb-6">Truy cập nhanh</h3>
                        <div class="space-y-4">
                            <a href="admin_danhmuc" class="w-full flex items-center justify-center p-4 bg-blue-500 text-white rounded-lg font-bold text-lg hover:bg-blue-600 transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-sitemap mr-3"></i> Quản lý Danh mục
                            </a>
                            <a href="admin_thuonghieu" class="w-full flex items-center justify-center p-4 bg-indigo-500 text-white rounded-lg font-bold text-lg hover:bg-indigo-600 transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-tags mr-3"></i> Quản lý Thương hiệu
                            </a>
                            <a href="#" class="w-full flex items-center justify-center p-4 bg-green-500 text-white rounded-lg font-bold text-lg hover:bg-green-600 transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-box-open mr-3"></i> Quản lý Sản phẩm
                            </a>
                            <a href="#" class="w-full flex items-center justify-center p-4 bg-yellow-500 text-white rounded-lg font-bold text-lg hover:bg-yellow-600 transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-users mr-3"></i> Quản lý Người dùng
                            </a>
                        </div>
                    </div>
                </div>
                
            </main>
            <!-- Hết Main content -->
            
        </div>
        <!-- Hết Main Content Area -->
        
    </div>
    
    <!-- 
      Gọi Footer (chứa JS chung, Popup và JS cho Chart) vào.
      Tệp admin_footer.jsp đã chứa code cho Chart.js
    -->
    <jsp:include page="admin_footer.jsp" />

</body>
</html>