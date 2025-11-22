<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Người dùng</title>
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
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="nguoidung" /></jsp:include>
        
        <div class="flex-1 flex flex-col overflow-hidden">
            <!-- Header -->
            <c:set var="pageTitle" value="Sửa Người dùng" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8 max-w-3xl mx-auto">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Chỉnh sửa: ${userToEdit.fullname}</h3>
                    
                    <form action="admin_nguoidung" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${userToEdit.id}">
                        
                        <div class="grid grid-cols-1 gap-6">
                            <div>
                                <!-- CHO PHÉP SỬA EMAIL -->
                                <label class="block text-sm font-medium text-gray-700">Email</label>
                                <input type="email" name="email" value="${userToEdit.email}" required 
                                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Họ tên</label>
                                <input type="text" name="fullname" value="${userToEdit.fullname}" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                                <input type="text" name="sdt" value="${userToEdit.sdt}" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Vai trò</label>
                                    <select name="role" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                        <option value="khach_hang" ${userToEdit.role == 'khach_hang' ? 'selected' : ''}>Khách hàng</option>
                                        <option value="admin" ${userToEdit.role == 'admin' ? 'selected' : ''}>Admin</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                                    <select name="status" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                        <option value="hoat_dong" ${userToEdit.status == 'hoat_dong' ? 'selected' : ''}>Hoạt động</option>
                                        <option value="bi_khoa" ${userToEdit.status == 'bi_khoa' ? 'selected' : ''}>Bị khóa</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-right pt-4 space-x-2">
                            <a href="admin_nguoidung" class="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300">Hủy</a>
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
    <!-- Footer -->
    <jsp:include page="admin_footer.jsp" />
</body>
</html>