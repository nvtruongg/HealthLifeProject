<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
  File: admin_header.jsp
  Mô tả: Chứa phần header (bao gồm logic "Xin chào [Tên]")
  Tệp này được TẤT CẢ các trang admin khác gọi vào.
-->
<header class="h-20 bg-white shadow-sm flex items-center justify-between px-6 z-20 border-b border-gray-200">
    <!-- Nút cho mobile -->
    <button id="menu-toggle" class="md:hidden text-gray-600">
        <i class="fas fa-bars fa-2x"></i>
    </button>

    <!-- 
      Tiêu đề trang (ví dụ: "Bảng điều khiển", "Quản lý Danh mục")
      Chúng ta lấy tiêu đề từ một biến 'pageTitle' mà trang cha truyền vào.
    -->
    <h2 class="text-3xl font-bold text-gray-800">
        <c:out value="${pageTitle}" default="Bảng điều khiển" />
    </h2>

    <div class="flex items-center space-x-4">
        
        <!-- Logic "Xin chào, [Tên]" -->
        <c:choose>
            <c:when test="${not empty sessionScope.account && not empty sessionScope.account.fullname}">
                <span class="text-lg font-medium text-gray-700 hidden sm:block">Xin chào, ${fn:escapeXml(sessionScope.account.fullname)}!</span>
            </c:when>
            <c:otherwise>
                <span class="text-lg font-medium text-gray-700 hidden sm:block">Xin chào, Admin!</span>
            </c:otherwise>
        </c:choose>

        <div class="w-12 h-12 rounded-full bg-blue-100 flex items-center justify-center ring-2 ring-blue-300">
            <i class="fas fa-user fa-lg text-blue-600"></i>
        </div>
    </div>
</header>