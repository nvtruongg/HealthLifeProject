<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tiêu đề riêng của trang -->
    <title>Quản lý Danh mục</title>
    
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
        <!-- SỬA LỖI 500: Xóa dòng trống giữa <include> và <param> -->
        <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="danhmuc" /></jsp:include>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Gọi Header vào -->
            <!-- Chúng ta truyền 'pageTitle' cho header để nó hiển thị đúng tên trang -->
            <c:set var="pageTitle" value="Quản lý Danh mục" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <!-- Main content (Nội dung chính của trang này) -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                
                <!-- Thông báo (nếu có) từ session -->
                <c:if test="${not empty sessionScope.message}">
                    <div id="message-toast" class="mb-4 p-4 rounded-lg 
                        ${sessionScope.message.contains('thất bại') ? 'bg-red-100 text-red-700' : 'bg-green-100 text-green-700'}"
                        role="alert">
                        ${sessionScope.message}
                        <button onclick="document.getElementById('message-toast').style.display='none'" class="float-right font-bold">&times;</button>
                    </div>
                    <%-- Xóa message sau khi hiển thị --%>
                    <c:remove var="message" scope="session" />
                </c:if>

                <!-- Form Thêm mới Danh mục -->
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Thêm Danh mục mới</h3>
                    
                    <form action="admin_danhmuc" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="tenDanhMuc" class="block text-sm font-medium text-gray-700">Tên Danh mục</label>
                                <input type="text" id="tenDanhMuc" name="tenDanhMuc" required
                                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                              focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            
                            <div>
                                <label for="idDanhMucCha" class="block text-sm font-medium text-gray-700">Danh mục cha (Tùy chọn)</label>
                                <select id="idDanhMucCha" name="idDanhMucCha"
                                        class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                               focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-white">
                                    <option value="0">-- Là danh mục gốc --</option>
                                    <c:forEach var="dm" items="${danhMucList}">
                                        <option value="${dm.id}">${dm.tenDanhMuc}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div>
                            <label for="moTa" class="block text-sm font-medium text-gray-700">Mô tả</label>
                            <textarea id="moTa" name="moTa" rows="3"
                                      class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm 
                                             focus:outline-none focus:ring-blue-500 focus:border-blue-500"></textarea>
                        </div>
                        
                        <div class="text-right">
                            <button type="submit"
                                    class="inline-flex justify-center py-2 px-6 border border-transparent shadow-sm 
                                           text-base font-medium rounded-lg text-white bg-blue-600 hover:bg-blue-700 
                                           focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-plus-circle mr-2"></i> Thêm mới
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Bảng Danh sách Danh mục -->
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Danh sách Danh mục</h3>
                    
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
    <tr>
        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_danhmuc?action=list&sortBy=id&sortOrder=${currentSortBy == 'id' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                ID
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'id'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_danhmuc?action=list&sortBy=name&sortOrder=${currentSortBy == 'name' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Tên Danh mục
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'name'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_danhmuc?action=list&sortBy=description&sortOrder=${currentSortBy == 'description' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Mô tả
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'description'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_danhmuc?action=list&sortBy=parent&sortOrder=${currentSortBy == 'parent' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                ID Cha
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'parent'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
            Hành động
        </th>
    </tr>
</thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                
                                <c:forEach var="dm" items="${danhMucList}">
                                    <tr class="hover:bg-gray-50">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${dm.id}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-700">${dm.tenDanhMuc}</td>
                                        <td class="px-6 py-4 max-w-sm text-sm text-gray-500 truncate" title="${dm.moTa}">
                                            ${dm.moTa}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${dm.idDanhMucCha != null ? dm.idDanhMucCha : "N/A"}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-2">
                                            
                                            <a href="admin_danhmuc?action=edit&id=${dm.id}" 
                                               class="text-blue-600 hover:text-blue-900" title="Sửa">
                                                <i class="fas fa-edit fa-lg"></i>
                                            </a>
                                            
                                            <a href="admin_danhmuc?action=delete&id=${dm.id}" 
                                               class="text-red-600 hover:text-red-900" title="Xóa"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                                <i class="fas fa-trash-alt fa-lg"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                            </tbody>
                        </table>
                    </div>
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