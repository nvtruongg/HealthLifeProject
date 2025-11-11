<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<section class="banner bg-light py-5 text-center" style="background: url('Images/banner.jpg') no-repeat center/cover;">
    <div class="container">
        <h1 class="display-4 text-white">Chào Mừng Đến Với HealthLife</h1>
        <p class="lead text-white">Sản phẩm sức khỏe chất lượng cao, giá tốt nhất!</p>
        <a href="home" class="btn btn-primary btn-lg">Khám Phá Ngay</a>
    </div>
</section>
<style>
    .banner { min-height: 300px; position: relative; }
    .banner::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); } /* Overlay tối để text nổi bật */
    .banner .container { position: relative; z-index: 1; }
</style>