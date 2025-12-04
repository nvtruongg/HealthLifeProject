<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
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
            <c:set var="pageTitle" value="Quản lý Sản phẩm" scope="request" />
            <jsp:include page="admin_header.jsp" />
            
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                <!-- Nút thêm mới và Tiêu đề -->
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold text-gray-800">Danh sách Sản phẩm</h2>
                    <a href="admin_sanpham?action=view_add" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition shadow-md">
                        <i class="fas fa-plus mr-2"></i> Thêm mới
                    </a>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="mb-4 p-4 bg-blue-100 text-blue-700 rounded-lg shadow">${sessionScope.message}</div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <!-- Bảng Danh sách -->
                <div class="bg-white rounded-xl shadow-lg p-6 overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
    <tr>
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=id&sortOrder=${currentSortBy == 'id' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
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

        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=code&sortOrder=${currentSortBy == 'code' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Mã SP
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'code'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>
        
        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=name&sortOrder=${currentSortBy == 'name' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Tên Sản phẩm
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

        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=category&sortOrder=${currentSortBy == 'category' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Danh mục
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'category'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=price&sortOrder=${currentSortBy == 'price' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Giá Bán
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'price'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=stock&sortOrder=${currentSortBy == 'stock' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Tồn kho
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'stock'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>

        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
            <a href="admin_sanpham?action=list&sortBy=status&sortOrder=${currentSortBy == 'status' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                Trạng thái
                <span class="ml-1 inline-block w-4">
                    <c:choose>
                        <c:when test="${currentSortBy == 'status'}">
                            <i class="fas ${currentSortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'} text-blue-600"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-sort text-gray-300 group-hover:text-gray-400"></i>
                        </c:otherwise>
                    </c:choose>
                </span>
            </a>
        </th>
        
        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Hành động</th>
    </tr>
</thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="p" items="${productList}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 text-sm text-gray-900">${p.id}</td>
                                    <td class="px-6 py-4 text-sm text-gray-500">${p.maSanPham}</td>
                                    <td class="px-6 py-4 text-sm font-bold text-gray-700 max-w-xs truncate" title="${p.tenSanPham}">
                                        ${p.tenSanPham}
                                    </td>
                                    <td class="px-6 py-4 text-sm text-gray-500">${p.tenDanhMuc}</td>
                                    <td class="px-6 py-4 text-sm font-medium text-green-600">
                                        <fmt:formatNumber value="${p.giaBan}" type="currency" currencySymbol="₫" />
                                    </td>
                                    <td class="px-6 py-4 text-sm text-gray-900">${p.soLuongTon}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                            ${p.trangThai == 'dang_kinh_doanh' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                            ${p.trangThai == 'dang_kinh_doanh' ? 'Đang bán' : 'Ngừng bán'}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right text-sm font-medium space-x-2">
                                        <a href="admin_sanpham?action=edit&id=${p.id}" class="text-blue-600 hover:text-blue-900"><i class="fas fa-edit"></i></a>
                                        <a href="admin_sanpham?action=delete&id=${p.id}" class="text-red-600 hover:text-red-900" onclick="return confirm('Xóa sản phẩm này?');"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="admin_footer.jsp" />
</body>
</html>