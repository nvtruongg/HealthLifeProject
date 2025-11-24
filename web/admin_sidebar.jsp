<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
  File: admin_sidebar.jsp
  Mô tả: Chứa thanh điều hướng bên (sidebar).
  Chúng ta dùng 'param.activePage' để xác định link nào đang "active".
-->
<aside id="sidebar" class="w-64 bg-white text-gray-800 flex-shrink-0 transition-transform duration-300 ease-in-out z-30
                          transform -translate-x-full md:translate-x-0 border-r border-gray-200">
    <!-- Sidebar Header -->
    <div class="h-20 flex items-center justify-center shadow-sm">
        <i class="fas fa-cogs fa-2x text-blue-600 mr-3"></i>
        <h1 class="text-2xl font-bold text-gray-900">Admin Panel</h1>
    </div>

    <!-- Sidebar Navigation -->
    <nav class="mt-4 flex-1 overflow-y-auto">
        <ul class="space-y-2 px-4">
            <li>
                <!-- Kiểm tra 'activePage' = 'home' -->
                <a href="admin" class="sidebar-link ${param.activePage == 'home' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-tachometer-alt w-6 text-center mr-3"></i>
                    Bảng điều khiển
                </a>
            </li>
            <li class="pt-4">
                <span class="px-4 text-sm font-semibold text-gray-400 uppercase">Quản lý</span>
            </li>
            <li>
                <a href="admin_sanpham" class="sidebar-link ${param.activePage == 'sanpham' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-box-open w-6 text-center mr-3"></i>
                    Sản phẩm
                </a>
            </li>
            <li>
                <a href="admin_donhang" class="sidebar-link ${param.activePage == 'donhang' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-shopping-cart w-6 text-center mr-3"></i>
                    Đơn hàng
                </a>
            </li>
            <li>
                <!-- Kiểm tra 'activePage' = 'danhmuc' -->
                <a href="admin_danhmuc" class="sidebar-link ${param.activePage == 'danhmuc' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-sitemap w-6 text-center mr-3"></i>
                    Danh mục
                </a>
            </li>
            <li>
                <a href="admin_nguoidung" class="sidebar-link ${param.activePage == 'nguoidung' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-users w-6 text-center mr-3"></i>
                    Người dùng
                </a>
            </li>
            <li>
                <!-- Kiểm tra 'activePage' = 'thuonghieu' -->
                <a href="admin_thuonghieu" class="sidebar-link ${param.activePage == 'thuonghieu' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-tags w-6 text-center mr-3"></i>
                    Thương hiệu
                </a>
            </li>
            <li>
                <a href="admin_baiviet" class="sidebar-link ${param.activePage == 'baiviet' ? 'active' : ''} flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-newspaper w-6 text-center mr-3"></i>
                    Bài viết
                </a>
            </li>
            <li class="pt-4">
                <span class="px-4 text-sm font-semibold text-gray-400 uppercase">Tài khoản</span>
            </li>
            <li>
                <!-- ID "logout-link" để JS bắt sự kiện -->
                <a href="logout" id="logout-link" class="sidebar-link flex items-center px-4 py-3 rounded-lg text-lg font-medium transition-colors">
                    <i class="fas fa-sign-out-alt w-6 text-center mr-3"></i>
                    Đăng xuất
                </a>
            </li>
        </ul>
    </nav>
</aside>