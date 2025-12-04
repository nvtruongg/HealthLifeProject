<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Bài viết</title>
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
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="baiviet" /></jsp:include>
        
        <div class="flex-1 flex flex-col overflow-hidden">
            <c:set var="pageTitle" value="Thêm Bài viết" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-6">Viết bài mới</h3>
                    
                    <form action="admin_baiviet" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="add">
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Tiêu đề bài viết</label>
                            <input type="text" name="tieuDe" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Hình ảnh tiêu đề (URL)</label>
                            <input type="text" name="hinhAnhTieuDe" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Tóm tắt</label>
                            <textarea name="tomTat" rows="3" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Nội dung</label>
                            <textarea name="noiDung" rows="15" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"></textarea>
                        </div>

                        <div class="w-1/3">
                            <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                            <select name="trangThai" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md bg-white">
                                <option value="nhap">Bản nháp</option>
                                <option value="xuat_ban">Xuất bản ngay</option>
                            </select>
                        </div>
                        
                        <div class="text-right">
                            <a href="admin_baiviet" class="px-6 py-2 bg-gray-200 rounded-lg hover:bg-gray-300 mr-2">Hủy</a>
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Lưu bài viết</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="admin_footer.jsp" />
</body>
</html>