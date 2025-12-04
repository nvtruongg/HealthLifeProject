<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Sản phẩm</title>
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
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="sanpham" /></jsp:include>
        
        <div class="flex-1 flex flex-col overflow-hidden">
            <c:set var="pageTitle" value="Sửa Sản phẩm" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-6">Cập nhật Sản phẩm: ${productToEdit.tenSanPham}</h3>
                    
                    <form action="admin_sanpham" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${productToEdit.id}">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Mã Sản phẩm</label>
                                <input type="text" name="maSanPham" value="${productToEdit.maSanPham}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Tên Sản phẩm</label>
                                <input type="text" name="tenSanPham" value="${productToEdit.tenSanPham}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Danh mục</label>
                                <select name="idDanhMuc" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                    <c:forEach var="dm" items="${danhMucList}">
                                        <option value="${dm.id}" ${dm.id == productToEdit.idDanhMuc ? 'selected' : ''}>${dm.tenDanhMuc}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Thương hiệu</label>
                                <select name="idThuongHieu" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                    <c:forEach var="th" items="${thuongHieuList}">
                                        <option value="${th.id}" ${th.id == productToEdit.idThuongHieu ? 'selected' : ''}>${th.tenThuongHieu}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Giá Gốc</label>
                                <input type="number" name="giaGoc" value="${productToEdit.giaGoc}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Giá Bán</label>
                                <input type="number" name="giaBan" value="${productToEdit.giaBan}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Số lượng tồn</label>
                                <input type="number" name="soLuongTon" value="${productToEdit.soLuongTon}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Đơn vị tính</label>
                                <input type="text" name="donViTinh" value="${productToEdit.donViTinh}" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                                <select name="trangThai" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                    <option value="dang_kinh_doanh" ${productToEdit.trangThai == 'dang_kinh_doanh' ? 'selected' : ''}>Đang kinh doanh</option>
                                    <option value="ngung_kinh_doanh" ${productToEdit.trangThai == 'ngung_kinh_doanh' ? 'selected' : ''}>Ngừng kinh doanh</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-6">
                            <h4 class="text-lg font-semibold text-gray-700 mb-4">Thông tin chi tiết</h4>
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Mô tả ngắn</label>
                                    <textarea name="moTaNgan" rows="2" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.moTaNgan}</textarea>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Mô tả chi tiết</label>
                                    <textarea name="moTaChiTiet" rows="4" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.moTaChiTiet}</textarea>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Thành phần</label>
                                        <textarea name="thanhPhan" rows="2" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.thanhPhan}</textarea>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Công dụng</label>
                                        <textarea name="congDung" rows="2" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.congDung}</textarea>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Liều dùng & Cách dùng</label>
                                        <textarea name="lieuDungCachDung" rows="2" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.lieuDungCachDung}</textarea>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700">Bảo quản</label>
                                        <textarea name="baoQuan" rows="2" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">${productToEdit.baoQuan}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-right">
                            <a href="admin_sanpham" class="px-6 py-2 bg-gray-200 rounded-lg hover:bg-gray-300 mr-2">Hủy</a>
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="admin_footer.jsp" />
</body>
</html>