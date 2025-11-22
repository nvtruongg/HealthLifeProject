<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đơn hàng #${order.maDonHang}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .sidebar-link.active { background-color: #3b82f6; color: white; }
    </style>
</head>
<body class="bg-slate-50">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="donhang" /></jsp:include>
        
        <div class="flex-1 flex flex-col overflow-hidden">
            <c:set var="pageTitle" value="Chi tiết Đơn hàng" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                
                <div class="mb-6 flex justify-between items-center">
                    <a href="admin_donhang" class="text-gray-600 hover:text-blue-600 flex items-center">
                        <i class="fas fa-arrow-left mr-2"></i> Quay lại danh sách
                    </a>
                    <span class="text-sm text-gray-500">Mã đơn: <span class="font-mono font-bold text-gray-800">${order.maDonHang}</span></span>
                </div>

                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-4 bg-green-100 text-green-700 rounded-lg">${sessionScope.message}</div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    
                    <!-- Cột Trái: Thông tin và Sản phẩm -->
                    <div class="lg:col-span-2 space-y-6">
                        <!-- Sản phẩm trong đơn -->
                        <div class="bg-white rounded-xl shadow-lg p-6">
                            <h4 class="text-lg font-bold text-gray-800 mb-4">Sản phẩm đã đặt</h4>
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead>
                                        <tr>
                                            <th class="text-left text-xs font-medium text-gray-500 uppercase py-2">Sản phẩm</th>
                                            <th class="text-center text-xs font-medium text-gray-500 uppercase py-2">SL</th>
                                            <th class="text-right text-xs font-medium text-gray-500 uppercase py-2">Đơn giá</th>
                                            <th class="text-right text-xs font-medium text-gray-500 uppercase py-2">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-200">
                                        <c:forEach var="d" items="${orderDetails}">
                                            <tr>
                                                <td class="py-4 text-sm">
                                                    <div class="flex items-center">
                                                        <div class="ml-2">
                                                            <div class="font-medium text-gray-900">${d.tenSanPham}</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="py-4 text-sm text-center">${d.soLuong}</td>
                                                <td class="py-4 text-sm text-right">
                                                    <fmt:formatNumber value="${d.giaLucMua}" type="currency" currencySymbol="₫" />
                                                </td>
                                                <td class="py-4 text-sm text-right font-bold">
                                                    <fmt:formatNumber value="${d.thanhTien}" type="currency" currencySymbol="₫" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="border-t mt-4 pt-4 flex justify-end space-x-10 text-sm">
                                <div class="text-gray-500">Tổng tiền hàng:</div>
                                <div class="font-bold"><fmt:formatNumber value="${order.tongTienSanPham}" type="currency" currencySymbol="₫" /></div>
                            </div>
                            <div class="flex justify-end space-x-10 text-sm mt-2">
                                <div class="text-gray-500">Phí vận chuyển:</div>
                                <div class="font-bold"><fmt:formatNumber value="${order.phiVanChuyen}" type="currency" currencySymbol="₫" /></div>
                            </div>
                            <div class="flex justify-end space-x-10 text-lg mt-2 pt-2 border-t text-blue-600 font-bold">
                                <div>Tổng thanh toán:</div>
                                <div><fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫" /></div>
                            </div>
                        </div>
                    </div>

                    <!-- Cột Phải: Thông tin khách hàng và Cập nhật trạng thái -->
                    <div class="space-y-6">
                        
                        <!-- Cập nhật Trạng thái (Form) -->
                        <div class="bg-white rounded-xl shadow-lg p-6">
                            <h4 class="text-lg font-bold text-gray-800 mb-4">Cập nhật Trạng thái</h4>
                            <form id="updateStatusForm" action="admin_donhang" method="POST">
                                <input type="hidden" name="action" value="update_status">
                                <input type="hidden" name="id" value="${order.id}">
                                
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái Đơn hàng</label>
                                    <select name="status" id="orderStatusSelect" class="w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 p-2 border">
                                        <option value="cho_xac_nhan" ${order.trangThaiDonHang == 'cho_xac_nhan' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="da_xac_nhan" ${order.trangThaiDonHang == 'da_xac_nhan' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="dang_giao" ${order.trangThaiDonHang == 'dang_giao' ? 'selected' : ''}>Đang giao hàng</option>
                                        <option value="da_giao" ${order.trangThaiDonHang == 'da_giao' ? 'selected' : ''}>Đã giao thành công</option>
                                        <option value="da_huy" ${order.trangThaiDonHang == 'da_huy' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái Thanh toán</label>
                                    <select name="paymentStatus" id="paymentStatusSelect" class="w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 p-2 border">
                                        <option value="chua_thanh_toan" ${order.trangThaiThanhToan == 'chua_thanh_toan' ? 'selected' : ''}>Chưa thanh toán</option>
                                        <option value="da_thanh_toan" ${order.trangThaiThanhToan == 'da_thanh_toan' ? 'selected' : ''}>Đã thanh toán</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 font-medium transition">
                                    Cập nhật thay đổi
                                </button>
                            </form>
                        </div>

                        <!-- Thông tin khách hàng -->
                        <div class="bg-white rounded-xl shadow-lg p-6">
                            <h4 class="text-lg font-bold text-gray-800 mb-4">Thông tin Giao hàng</h4>
                            <div class="space-y-3 text-sm">
                                <div>
                                    <span class="text-gray-500 block">Người nhận:</span>
                                    <span class="font-medium text-gray-900">${order.tenNguoiNhan}</span>
                                </div>
                                <div>
                                    <span class="text-gray-500 block">Số điện thoại:</span>
                                    <span class="font-medium text-gray-900">${order.sdtNhan}</span>
                                </div>
                                <div>
                                    <span class="text-gray-500 block">Địa chỉ:</span>
                                    <span class="font-medium text-gray-900">${order.diaChiGiaoHang}</span>
                                </div>
                                <div>
                                    <span class="text-gray-500 block">Ghi chú:</span>
                                    <span class="font-medium text-gray-900 italic">"${order.ghiChu != null ? order.ghiChu : 'Không có'}"</span>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="admin_footer.jsp" />

    <!-- Script xử lý logic trạng thái -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const orderSelect = document.getElementById('orderStatusSelect');
            const paymentSelect = document.getElementById('paymentStatusSelect');
            const form = document.getElementById('updateStatusForm');

            function checkStatus() {
                if (orderSelect.value === 'da_giao') {
                    paymentSelect.value = 'da_thanh_toan';
                    paymentSelect.disabled = true; // Vô hiệu hóa ô chọn
                    
                    // Thêm input hidden để vẫn gửi giá trị về server khi submit (vì disabled input không được gửi)
                    let hiddenInput = document.getElementById('hiddenPaymentStatus');
                    if (!hiddenInput) {
                        hiddenInput = document.createElement('input');
                        hiddenInput.type = 'hidden';
                        hiddenInput.name = 'paymentStatus';
                        hiddenInput.id = 'hiddenPaymentStatus';
                        form.appendChild(hiddenInput);
                    }
                    hiddenInput.value = 'da_thanh_toan';
                } else {
                    paymentSelect.disabled = false;
                    // Xóa input hidden nếu có
                    const hiddenInput = document.getElementById('hiddenPaymentStatus');
                    if (hiddenInput) hiddenInput.remove();
                }
            }

            // Kiểm tra ngay khi load trang (để xử lý trường hợp đơn hàng đã giao rồi)
            if (orderSelect && paymentSelect) {
                checkStatus();
                // Lắng nghe sự kiện thay đổi
                orderSelect.addEventListener('change', checkStatus);
            }
        });
    </script>
</body>
</html>