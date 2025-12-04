<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

<style>
    /* Khung bao ngoài cùng: Định vị cố định góc màn hình */
    .customer-care-float {
        position: fixed;
        bottom: 30px;
        right: 30px;
        z-index: 99999; /* Luôn nổi trên cùng */
        display: flex;
        flex-direction: column-reverse; /* Để nút chính nằm dưới, nút con hiện lên trên */
        align-items: center;
        gap: 10px; /* Khoảng cách giữa các nút */
    }

    /* Nút chính (Hỗ trợ) */
    .main-float-btn {
        width: 60px;
        height: 60px;
        background: linear-gradient(45deg, #764ba2, #667eea); /* Màu tím đẹp mắt */
        color: white;
        border-radius: 50%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        animation: pulse-animation 2s infinite; /* Hiệu ứng nhịp đập của bạn */
        transition: all 0.3s ease;
        position: relative;
    }

    .main-float-btn i {
        font-size: 24px;
        margin-bottom: 2px;
    }

    .float-text {
        font-size: 10px;
        font-weight: bold;
    }

    /* Các nút con (Zalo, Phone, Mess) */
    .btn-float {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        text-decoration: none;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        transition: all 0.4s ease;
        
        /* Trạng thái ẩn ban đầu */
        opacity: 0;
        visibility: hidden;
        transform: translateY(20px) scale(0.8);
        position: absolute; /* Để chúng nằm đè lên nhau khi ẩn */
        bottom: 0; 
    }

    /* --- MÀU SẮC RIÊNG (Code của bạn) --- */
    .btn-call {
        background-color: #ed213a; /* Hotline Đỏ */
    }
    .btn-zalo {
        background-color: #0068ff; /* Zalo Xanh dương đậm */
    }
    .btn-messenger {
        background-color: #0084ff; /* Messenger Xanh */
    }
    
    .btn-float i {
        font-size: 22px;
    }

    /* --- HIỆU ỨNG HOVER (Di chuột vào thì bung ra) --- */
    
    /* Khi di chuột vào vùng chứa, nút chính to lên và ngừng đập */
    .customer-care-float:hover .main-float-btn {
        transform: scale(1.1);
        animation: none;
    }

    /* Khi di chuột vào vùng chứa, các nút con hiện ra và bay lên */
    .customer-care-float:hover .btn-float {
        opacity: 1;
        visibility: visible;
        position: relative; /* Trả về vị trí thực để xếp chồng dọc */
        transform: translateY(0) scale(1);
    }
    
    /* Hiệu ứng nhịp đập (Code của bạn) */
    @keyframes pulse-animation {
        0% { box-shadow: 0 0 0 0 rgba(118, 75, 162, 0.7); }
        70% { box-shadow: 0 0 0 15px rgba(118, 75, 162, 0); }
        100% { box-shadow: 0 0 0 0 rgba(118, 75, 162, 0); }
    }
</style>

<div class="customer-care-float">
    
    <a href="https://m.me/healthlife.vn" target="_blank" class="btn-float btn-messenger" title="Chat Messenger">
        <i class="fab fa-facebook-messenger"></i>
    </a>
    
    <a href="https://zalo.me/0357800306" target="_blank" class="btn-float btn-zalo" title="Chat Zalo">
        <i class="fas fa-comment-dots"></i>
    </a>
    
    <a href="tel:0912345678" class="btn-float btn-call" title="Gọi Hotline">
        <i class="fas fa-phone-alt"></i>
    </a>

    <div class="main-float-btn">
        <i class="fas fa-headset"></i>
        <span class="float-text">Hỗ trợ</span>
    </div>
    
</div>