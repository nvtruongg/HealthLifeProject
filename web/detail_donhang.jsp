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
                    <div class="mb-4 p-4 bg-blue-100 text-blue-700 rounded-lg">${sessionScope.message}</div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    
                    <!-- Cột Trái: Sản phẩm -->
                    <div class="lg:col-span-2 space-y-6">
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
                                                    <div class="font-medium text-gray-900">${d.tenSanPham}</div>
                                                </td>
                                                <td class="py-4 text-sm text-center">${d.soLuong}</td>
                                                <td class="py-4 text-sm text-right"><fmt:formatNumber value="${d.giaLucMua}" type="currency" currencySymbol="₫" /></td>
                                                <td class="py-4 text-sm text-right font-bold"><fmt:formatNumber value="${d.thanhTien}" type="currency" currencySymbol="₫" /></td>
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

                    <!-- Cột Phải: Xử lý Đơn hàng -->
                    <div class="space-y-6">
                        <div class="bg-white rounded-xl shadow-lg p-6">
                            <h4 class="text-lg font-bold text-gray-800 mb-4">Xử lý Đơn hàng</h4>
                            
                            <!-- Hiển thị Trạng thái -->
                            <div class="mb-6">
                                <p class="text-sm text-gray-500 mb-1">Trạng thái hiện tại:</p>
                                <span class="px-3 py-1 inline-flex text-sm leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                                    <c:choose>
                                        <c:when test="${order.trangThaiDonHang == 'cho_xac_nhan'}">Chờ xác nhận</c:when>
                                        <c:when test="${order.trangThaiDonHang == 'da_xac_nhan'}">Đã xác nhận</c:when>
                                        <c:when test="${order.trangThaiDonHang == 'dang_giao'}">Đang giao hàng</c:when>
                                        <c:when test="${order.trangThaiDonHang == 'hoan_thanh'}">Giao thành công</c:when>
                                        <c:when test="${order.trangThaiDonHang == 'da_huy'}">Đã hủy</c:when>
                                    </c:choose>
                                </span>
                            </div>

                            <!-- Các Nút Hành động -->
                            <div class="space-y-3">
                                
                                <!-- 1. Chờ xác nhận -->
                                <c:if test="${order.trangThaiDonHang == 'cho_xac_nhan'}">
                                    <form action="admin_donhang" method="POST">
                                        <input type="hidden" name="action" value="next_step">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700 font-bold shadow-md transition">
                                            <i class="fas fa-check mr-2"></i> Xác nhận Đơn hàng
                                        </button>
                                    </form>
                                    <form action="admin_donhang" method="POST">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="w-full bg-white text-red-600 border border-red-200 py-2 rounded-lg hover:bg-red-50 font-medium transition" onclick="return confirm('Hủy đơn này?');">Hủy đơn hàng</button>
                                    </form>
                                </c:if>

                                <!-- 2. Đã xác nhận -->
                                <c:if test="${order.trangThaiDonHang == 'da_xac_nhan'}">
                                    <form action="admin_donhang" method="POST">
                                        <input type="hidden" name="action" value="next_step">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="w-full bg-indigo-600 text-white py-3 rounded-lg hover:bg-indigo-700 font-bold shadow-md transition">
                                            <i class="fas fa-shipping-fast mr-2"></i> Bắt đầu Giao hàng
                                        </button>
                                    </form>
                                    <!-- Nút Quay lại (Có lý do) -->
                                    <button type="button" onclick="openRevertModal()" class="w-full bg-yellow-500 text-white py-2 rounded-lg hover:bg-yellow-600 font-medium transition">
                                        <i class="fas fa-undo mr-2"></i> Quay lại "Chờ xác nhận"
                                    </button>
                                </c:if>

                                <!-- 3. Đang giao -->
                                <c:if test="${order.trangThaiDonHang == 'dang_giao'}">
                                    <form action="admin_donhang" method="POST">
                                        <input type="hidden" name="action" value="next_step">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700 font-bold shadow-md transition" onclick="return confirm('Xác nhận đã giao và thu tiền?');">
                                            <i class="fas fa-check-double mr-2"></i> Xác nhận Đã giao & Thu tiền
                                        </button>
                                    </form>
                                    <!-- Nút Quay lại (Có lý do) -->
                                    <button type="button" onclick="openRevertModal()" class="w-full bg-yellow-500 text-white py-2 rounded-lg hover:bg-yellow-600 font-medium transition">
                                        <i class="fas fa-undo mr-2"></i> Quay lại "Đã xác nhận"
                                    </button>
                                </c:if>
                                
                                <!-- 4. Đã giao -->
                                <c:if test="${order.trangThaiDonHang == 'hoan_thanh'}">
                                    <div class="text-center p-3 bg-green-50 rounded-lg border border-green-200 text-green-800 font-bold">
                                        <i class="fas fa-check-circle mr-1"></i> Đơn hàng hoàn tất
                                    </div>
                                    <!-- Nút Quay lại (Có lý do) -->
                                    <button type="button" onclick="openRevertModal()" class="w-full bg-yellow-500 text-white py-2 rounded-lg hover:bg-yellow-600 font-medium transition mt-2">
                                        <i class="fas fa-undo mr-2"></i> Quay lại "Đang giao" (Override)
                                    </button>
                                </c:if>

                            </div>
                        </div>
                        
                        <!-- Thông tin Giao hàng -->
                        <div class="bg-white rounded-xl shadow-lg p-6">
                            <h4 class="text-lg font-bold text-gray-800 mb-4">Thông tin Giao hàng</h4>
                            <div class="space-y-3 text-sm">
                                <div><span class="text-gray-500 block">Người nhận:</span> <span class="font-medium text-gray-900">${order.tenNguoiNhan}</span></div>
                                <div><span class="text-gray-500 block">SĐT:</span> <span class="font-medium text-gray-900">${order.sdtNhan}</span></div>
                                <div><span class="text-gray-500 block">Địa chỉ:</span> <span class="font-medium text-gray-900">${order.diaChiGiaoHang}</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- POPUP MODAL NHẬP LÝ DO (REVERT) -->
    <div id="revert-modal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50 hidden">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-xl bg-white">
            <div class="mt-3">
                <h3 class="text-lg leading-6 font-bold text-gray-900 text-center">Xác nhận quay lại bước trước</h3>
                <div class="mt-2 px-2">
                    <p class="text-sm text-gray-500 mb-4">Hành động này sẽ thay đổi trạng thái đơn hàng về bước trước đó. Vui lòng nhập lý do:</p>
                    <form action="admin_donhang" method="POST">
                        <input type="hidden" name="action" value="revert_status">
                        <input type="hidden" name="id" value="${order.id}">
                        <textarea name="reason" rows="3" required placeholder="Nhập lý do cụ thể..." class="w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500 text-sm"></textarea>
                        
                        <div class="flex justify-end mt-4 space-x-3">
                            <button type="button" onclick="closeRevertModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 text-sm">Hủy</button>
                            <button type="submit" class="px-4 py-2 bg-yellow-600 text-white rounded-lg hover:bg-yellow-700 text-sm font-bold">Xác nhận Override</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="admin_footer.jsp" />

    <script>
        function openRevertModal() {
            document.getElementById('revert-modal').classList.remove('hidden');
        }
        function closeRevertModal() {
            document.getElementById('revert-modal').classList.add('hidden');
        }
    </script>
</body>
</html>