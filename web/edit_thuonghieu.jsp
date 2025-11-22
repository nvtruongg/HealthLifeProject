<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tiêu đề riêng của trang -->
    <title>Sửa Thương hiệu</title>
    
    <!-- CSS chung (Tailwind, Font Awesome, Font) -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
        <!-- Đặt activePage là 'thuonghieu' -->
        <!-- SỬA LỖI 500: Xóa dòng trống giữa <include> và <param> -->
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="thuonghieu" /></jsp:include>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Gọi Header vào -->
            <!-- Truyền 'pageTitle' cho header -->
            <c:set var="pageTitle" value="Sửa Thương hiệu" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <!-- Main content (Nội dung chính của trang này) -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                
                <!-- Form Sửa Thương hiệu -->
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8 max-w-4xl mx-auto">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Chỉnh sửa Thương hiệu: ${thuongHieuToEdit.tenThuongHieu}</h3>
                    
                    <form action="admin_thuonghieu" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${thuongHieuToEdit.id}">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="tenThuongHieu" class="block text-sm font-medium text-gray-700">Tên Thương hiệu</label>
                                <input type="text" id="tenThuongHieu" name="tenThuongHieu" required
                                       value="${thuongHieuToEdit.tenThuongHieu}"
                                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                              focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            
                            <div>
                                <label for="xuatXu" class="block text-sm font-medium text-gray-700">Xuất xứ</Gia>
                                <input type="text" id="xuatXu" name="xuatXu" required
                                       value="${thuongHieuToEdit.xuatXu}"
                                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                              focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>
                        
                        <div>
                            <label for="moTa" class="block text-sm font-medium text-gray-700">Mô tả</label>
                            <textarea id="moTa" name="moTa" rows="4"
                                      class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                             focus:outline-none focus:ring-blue-500 focus:border-blue-500">${thuongHieuToEdit.moTa}</textarea>
                        </div>
                        
                        <div class="text-right space-x-3">
                            <a href="admin_thuonghieu"
                               class="inline-flex justify-center py-2 px-6 border border-gray-300 shadow-sm 
                                      text-base font-medium rounded-lg text-gray-700 bg-white hover:bg-gray-50">
                                Hủy
                            </a>
                            
                            <button type="submit"
                                    class="inline-flex justify-center py-2 px-6 border border-transparent shadow-sm 
                                           text-base font-medium rounded-lg text-white bg-blue-600 hover:bg-blue-700 
                                           focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-save mr-2"></i> Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
                
            </main>
            <!-- Hết Main content -->
            
        </div>
        <!-- Hết Main Content Area -->
        
    </div>
    
    <!-- Gọi Footer (chứa JS chung và Popup) vào -->
    <jsp:include page="admin_footer.jsp" />

</body>
</html>