<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tổng quan Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .sidebar-link.active { background-color: #3b82f6; color: white; }
    </style>
</head>
<body class="bg-slate-50">

    <div class="flex h-screen overflow-hidden">
        
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="home" /></jsp:include>

        <div class="flex-1 flex flex-col overflow-hidden">
            
            <c:set var="pageTitle" value="Tổng quan" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                
                <!-- Header phụ: Tiêu đề + Nút Xuất Excel -->
                <div class="flex justify-between items-end mb-6">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-800">Thống kê kinh doanh</h2>
                        <p class="text-sm text-gray-500">Cập nhật lần cuối: Hôm nay</p>
                    </div>
                    
                    <!-- NÚT XUẤT EXCEL -->
                    <a href="${pageContext.request.contextPath}/export_excel" 
                       class="flex items-center space-x-2 bg-green-600 text-white px-4 py-2 rounded-lg shadow hover:bg-green-700 transition-colors">
                        <i class="fas fa-file-excel"></i>
                        <span>Xuất báo cáo (.csv)</span>
                    </a>
                </div>

                <!-- 1. Cards Thống kê (Giữ nguyên) -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500">Tổng doanh thu</p>
                            <h3 class="text-2xl font-bold text-gray-900 mt-1">
                                <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                            </h3>
                        </div>
                        <div class="p-3 bg-blue-50 rounded-full text-blue-600"><i class="fas fa-dollar-sign fa-2x"></i></div>
                    </div>
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500">Tổng đơn hàng</p>
                            <h3 class="text-2xl font-bold text-gray-900 mt-1">${totalOrders}</h3>
                        </div>
                        <div class="p-3 bg-green-50 rounded-full text-green-600"><i class="fas fa-shopping-cart fa-2x"></i></div>
                    </div>
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500">Khách hàng</p>
                            <h3 class="text-2xl font-bold text-gray-900 mt-1">${totalCustomers}</h3>
                        </div>
                        <div class="p-3 bg-yellow-50 rounded-full text-yellow-600"><i class="fas fa-users fa-2x"></i></div>
                    </div>
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500">Sản phẩm</p>
                            <h3 class="text-2xl font-bold text-gray-900 mt-1">${totalProducts}</h3>
                        </div>
                        <div class="p-3 bg-purple-50 rounded-full text-purple-600"><i class="fas fa-box-open fa-2x"></i></div>
                    </div>
                </div>

                <!-- 2. Hàng Biểu đồ (Giữ nguyên) -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 lg:col-span-2">
                        <h3 class="text-lg font-bold text-gray-800 mb-4">Doanh thu 6 tháng gần nhất</h3>
                        <div class="h-72 w-full">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <h3 class="text-lg font-bold text-gray-800 mb-4">Trạng thái đơn hàng</h3>
                        <div class="h-64 w-full flex justify-center">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- 3. Danh sách -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <!-- Đơn hàng mới nhất -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 lg:col-span-2">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-bold text-gray-800">Đơn hàng mới nhất</h3>
                            <a href="${pageContext.request.contextPath}/admin_donhang" class="text-sm text-blue-600 hover:underline">Xem tất cả</a>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead>
                                    <tr>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Mã đơn</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Khách hàng</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Tổng tiền</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach var="o" items="${recentOrders}">
                                        
                                        <!-- 
                                            CẬP NHẬT: Thêm onclick để chuyển trang và class hover 
                                        -->
                                        <tr onclick="window.location.href='${pageContext.request.contextPath}/admin_donhang?action=detail&id=${o.id}'" 
                                            class="hover:bg-blue-50 cursor-pointer transition-colors duration-150">
                                            
                                            <td class="px-4 py-3 text-sm font-medium text-blue-600">#${o.maDonHang}</td>
                                            <td class="px-4 py-3 text-sm text-gray-700">${o.tenNguoiNhan}</td>
                                            <td class="px-4 py-3 text-sm text-gray-900 font-bold">
                                                <fmt:formatNumber value="${o.tongThanhToan}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                            <td class="px-4 py-3 text-sm">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                    ${o.trangThaiDonHang == 'hoan_thanh' ? 'bg-green-100 text-green-800' : 
                                                      o.trangThaiDonHang == 'da_huy' ? 'bg-red-100 text-red-800' : 
                                                      o.trangThaiDonHang == 'da_giao' ? 'bg-green-100 text-green-800' :
                                                      'bg-yellow-100 text-yellow-800'}">
                                                    ${o.trangThaiDonHang == 'da_giao' || o.trangThaiDonHang == 'hoan_thanh' ? 'Hoàn tất' : o.trangThaiDonHang}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Top Sản phẩm -->
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <h3 class="text-lg font-bold text-gray-800 mb-4">Top bán chạy</h3>
                        <c:if test="${empty topProducts}">
                            <div class="text-center text-gray-500 py-8">
                                <i class="fas fa-box-open fa-2x mb-2 text-gray-300"></i>
                                <p>Chưa có dữ liệu</p>
                            </div>
                        </c:if>
                        <ul class="space-y-4">
                            <c:forEach var="top" items="${topProducts}" varStatus="loop">
                                <li class="flex items-center">
                                    <div class="flex-shrink-0 h-8 w-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-600 font-bold text-sm">
                                        ${loop.index + 1}
                                    </div>
                                    <div class="ml-3 flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900 truncate" title="${top.tenSanPham}">${top.tenSanPham}</p>
                                        <p class="text-xs text-gray-500">${top.soLuongBan} đã bán</p>
                                    </div>
                                    <div class="text-xs font-bold text-gray-900">
                                        <fmt:formatNumber value="${top.doanhThu}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
            </main>
        </div>
    </div>
    
    <jsp:include page="admin_footer.jsp" />

    <!-- SCRIPT VẼ BIỂU ĐỒ -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            
            const labelsRevenue = ${revenueLabels != null ? revenueLabels : '[]'};
            const dataRevenue = ${revenueData != null ? revenueData : '[]'};
            const labelsStatus = ${statusLabels != null ? statusLabels : '[]'};
            const dataStatus = ${statusData != null ? statusData : '[]'};

            // 1. Biểu đồ Doanh thu
            const ctxRevenue = document.getElementById('revenueChart');
            if (ctxRevenue && labelsRevenue.length > 0) {
                new Chart(ctxRevenue, {
                    type: 'line',
                    data: {
                        labels: labelsRevenue,
                        datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: dataRevenue,
                            borderColor: '#3b82f6',
                            backgroundColor: 'rgba(59, 130, 246, 0.1)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.3
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: { y: { beginAtZero: true } }
                    }
                });
            } else if (ctxRevenue) {
                ctxRevenue.parentElement.innerHTML = '<div class="flex items-center justify-center h-full text-gray-400">Chưa có dữ liệu doanh thu</div>';
            }

            // 2. Biểu đồ Trạng thái
            const ctxStatus = document.getElementById('statusChart');
            if (ctxStatus && labelsStatus.length > 0) {
                const backgroundColors = labelsStatus.map(status => {
                    if(status.includes('Hoàn tất') || status.includes('thành')) return '#22c55e'; 
                    if(status.includes('Đã hủy')) return '#ef4444'; 
                    if(status.includes('Chờ') || status.includes('xác nhận')) return '#eab308'; 
                    return '#3b82f6'; 
                });

                new Chart(ctxStatus, {
                    type: 'doughnut',
                    data: {
                        labels: labelsStatus,
                        datasets: [{
                            data: dataStatus,
                            backgroundColor: backgroundColors,
                            borderWidth: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { position: 'bottom' } }
                    }
                });
            } else if (ctxStatus) {
                ctxStatus.parentElement.innerHTML = '<div class="flex items-center justify-center h-full text-gray-400">Chưa có đơn hàng</div>';
            }
        });
    </script>
</body>
</html>