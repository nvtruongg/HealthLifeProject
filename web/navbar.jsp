<%--
    NAVBAR (THANH ĐIỀU HƯỚNG DANH MỤC)
    Dùng Bootstrap 5
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom sticky-top shadow-sm" style="top: 0; z-index: 1020;">
    <div class="container-fluid px-3">
        <!-- Nút Toggler cho Navbar danh mục (hiển thị trên mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#categoryNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="categoryNavbar">
                <ul class="navbar-nav nav-pills justify-content-between w-100 py-2">
                    <li class="nav-item">
                        <a class="nav-link text-dark fw-bold" href="shop">Trang chủ</a>
                    </li>

                    <c:forEach items="${listC}" var="parentCat">
                        <c:if test="${not empty parentCat.danhMucCon}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-dark" href="#" id="navbarDropdown_${parentCat.id}" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${parentCat.tenDanhMuc}
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown_${parentCat.id}">
                                    <!-- Link cho chính danh mục cha -->
                                    <li>
                                        <a class="dropdown-item" href="shop?cid=${parentCat.id}">
                                            <strong>Xem tất cả "${parentCat.tenDanhMuc}"</strong>
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>                            
                                    <!-- Lặp qua các DANH MỤC CON -->
                                    <c:forEach items="${parentCat.danhMucCon}" var="childCat">
                                        <li>
                                            <a class="dropdown-item" href="shop?cid=${childCat.id}">
                                                ${childCat.tenDanhMuc}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>

                    </c:forEach>
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="contact.jsp">Liên hệ</a>
                    </li>
                </ul>

        </div>
    </div>
</nav>

<!-- CSS cho Navbar -->
<style>
    .navbar-nav .nav-link {
        transition: 0.3s;
        border-radius: 6px;
        font-weight: 500;
        padding-left: 0.5rem;
        padding-right: 0.75rem;
        white-space: nowrap;
    }
    @media(max-width: 768px){
        .navbar-nav .nav-link:hover {
            color: #003D9D !important;
            background-color: #FFD43B !important;

        }
    }

</style>