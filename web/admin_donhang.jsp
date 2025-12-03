<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Đơn hàng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
            body {
                font-family: 'Inter', sans-serif;
            }
            .sidebar-link.active {
                background-color: #3b82f6;
                color: white;
            }
        </style>
    </head>
    <body class="bg-slate-50">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="admin_sidebar.jsp"><jsp:param name="activePage" value="donhang" /></jsp:include>

                <div class="flex-1 flex flex-col overflow-hidden">
                <c:set var="pageTitle" value="Quản lý Đơn hàng" scope="request" />
                <jsp:include page="admin_header.jsp" />

                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-slate-50 p-8">
                    <div class="bg-white rounded-xl shadow-lg p-6">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Danh sách Đơn hàng</h3>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase cursor-pointer hover:bg-gray-100 transition-colors select-none">
                                            <a href="admin_donhang?action=list&sortBy=id&sortOrder=${currentSortBy == 'id' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
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
                                            <a href="admin_donhang?action=list&sortBy=code&sortOrder=${currentSortBy == 'code' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                                                Mã Đơn
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
                                            <a href="admin_donhang?action=list&sortBy=customer&sortOrder=${currentSortBy == 'customer' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                                                Khách hàng
                                                <span class="ml-1 inline-block w-4">
                                                    <c:choose>
                                                        <c:when test="${currentSortBy == 'customer'}">
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
                                            <a href="admin_donhang?action=list&sortBy=date&sortOrder=${currentSortBy == 'date' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                                                Ngày đặt
                                                <span class="ml-1 inline-block w-4">
                                                    <c:choose>
                                                        <c:when test="${currentSortBy == 'date'}">
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
                                            <a href="admin_donhang?action=list&sortBy=total&sortOrder=${currentSortBy == 'total' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
                                                Tổng tiền
                                                <span class="ml-1 inline-block w-4">
                                                    <c:choose>
                                                        <c:when test="${currentSortBy == 'total'}">
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
                                            <a href="admin_donhang?action=list&sortBy=status&sortOrder=${currentSortBy == 'status' && currentSortOrder == 'asc' ? 'desc' : 'asc'}" class="flex items-center group w-full h-full">
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
                                    <c:forEach var="o" items="${orderList}">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 text-sm text-gray-900">#${o.id}</td>
                                            <td class="px-6 py-4 text-sm font-bold text-blue-600">${o.maDonHang}</td>
                                            <td class="px-6 py-4 text-sm text-gray-700">
                                                ${o.tenNguoiNhan}<br>
                                                <span class="text-xs text-gray-500">${o.sdtNhan}</span>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-500">
                                                <fmt:formatDate value="${o.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td class="px-6 py-4 text-sm font-medium text-gray-900">
                                                <fmt:formatNumber value="${o.tongThanhToan}" type="currency" currencySymbol="₫" />
                                            </td>
                                            <td class="px-6 py-4 text-sm">
                                                <!-- Badge trạng thái (màu sắc tùy trạng thái) -->
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                      ${o.trangThaiDonHang == 'da_giao' ? 'bg-green-100 text-green-800' : 
                                                        o.trangThaiDonHang == 'da_huy' ? 'bg-red-100 text-red-800' : 
                                                        'bg-yellow-100 text-yellow-800'}">
                                                          ${o.trangThaiDonHang}
                                                      </span>
                                                </td>
                                                <td class="px-6 py-4 text-right text-sm font-medium">
                                                    <a href="admin_donhang?action=detail&id=${o.id}" class="text-blue-600 hover:text-blue-900 font-bold">
                                                        Chi tiết <i class="fas fa-arrow-right ml-1"></i>
                                                    </a>
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