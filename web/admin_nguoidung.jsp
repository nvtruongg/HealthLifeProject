<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng</title>
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
            <c:set var="pageTitle" value="Quản lý Người dùng" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                <!-- Thông báo -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-4 bg-blue-100 text-blue-700 rounded-lg">${sessionScope.message}</div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <!-- Form Thêm Người dùng -->
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Thêm Người dùng mới</h3>
                    <form action="admin_nguoidung" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="add">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Họ tên</label>
                                <input type="text" name="fullname" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Email</label>
                                <input type="email" name="email" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Mật khẩu</label>
                                <input type="password" name="password" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                                <input type="text" name="sdt" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Vai trò</label>
                                <select name="role" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                    <option value="khach_hang">Khách hàng</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="text-right">
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Thêm mới</button>
                        </div>
                    </form>
                </div>

                <!-- Bảng Danh sách -->
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Danh sách Người dùng</h3>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Họ tên</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Vai trò</th>
                                    <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Hành động</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="u" items="${userList}">
                                    <tr class="hover:bg-gray-50">
                                        <td class="px-6 py-4 text-sm text-gray-900">${u.id}</td>
                                        <td class="px-6 py-4 text-sm font-bold text-gray-700">${u.fullname}</td>
                                        <td class="px-6 py-4 text-sm text-gray-500">${u.email}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${u.role == 'admin' ? 'bg-purple-100 text-purple-800' : 'bg-gray-100 text-gray-800'}">
                                                ${u.role}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-right text-sm font-medium space-x-2">
                                            <a href="admin_nguoidung?action=edit&id=${u.id}" class="text-blue-600 hover:text-blue-900"><i class="fas fa-edit"></i></a>
                                            <a href="admin_nguoidung?action=delete&id=${u.id}" class="text-red-600 hover:text-red-900" onclick="return confirm('Xóa người dùng này?');"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="admin_footer.jsp" />
</body>
</html>