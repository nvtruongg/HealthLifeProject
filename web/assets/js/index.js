document.addEventListener("DOMContentLoaded", function () {

    // --- 1. HERO SLIDER LOGIC ---
    let currentSlide = 0;
    const slides = document.querySelectorAll('.hero-slide');

    // Hàm hiển thị slide theo index
    function showSlide(index) {
        if (!slides.length)
            return; // Kiểm tra nếu không có slide

        slides.forEach(slide => slide.classList.remove('active'));
        slides[index].classList.add('active');
    }

    // Hàm chuyển slide (kế tiếp/lùi lại)
    // Cần gán vào window để có thể gọi từ onclick trong HTML
    window.changeSlide = function (n) {
        if (!slides.length)
            return;
        currentSlide = (currentSlide + n + slides.length) % slides.length;
        showSlide(currentSlide);
    }

    // Tự động chạy slider sau mỗi 5 giây
    let slideInterval = setInterval(() => {
        if (typeof changeSlide === 'function') {
            changeSlide(1);
        }
    }, 5000);

    // Tạm dừng slider khi hover (tùy chọn)
    const heroSection = document.querySelector('.hero-section');
    if (heroSection) {
        heroSection.addEventListener('mouseenter', () => clearInterval(slideInterval));
        heroSection.addEventListener('mouseleave', () => {
            slideInterval = setInterval(() => changeSlide(1), 5000);
        });
    }


    // --- 2. COUNTER ANIMATION (HIỆU ỨNG SỐ NHẢY) ---
    const counters = document.querySelectorAll('.counter');
    const speed = 200; // Tốc độ chạy số (càng nhỏ càng nhanh)

    const animateCounters = () => {
        counters.forEach(counter => {
            const updateCount = () => {
                const target = +counter.getAttribute('data-target'); // Lấy số đích
                const count = +counter.innerText.replace(/\D/g, ''); // Lấy số hiện tại (bỏ ký tự không phải số)

                // Tính bước nhảy
                const inc = target / speed;

                if (count < target) {
                    // Nếu chưa đến đích, cộng thêm và gọi lại hàm sau 20ms
                    counter.innerText = Math.ceil(count + inc);
                    setTimeout(updateCount, 20);
                } else {
                    // Đã đến đích, format số đẹp (ví dụ: 1,000+)
                    counter.innerText = target.toLocaleString();
                    if (target >= 1000)
                        counter.innerText += "+";
                }
            };
            updateCount();
        });
    };

    // Sử dụng Intersection Observer để kích hoạt animation khi cuộn tới
    const statsSection = document.querySelector('.stats-section');
    if (statsSection) {
        const observer = new IntersectionObserver((entries) => {
            if (entries[0].isIntersecting) {
                animateCounters();
                observer.disconnect(); // Chỉ chạy 1 lần rồi thôi
            }
        }, {threshold: 0.5}); // Kích hoạt khi 50% section hiển thị

        observer.observe(statsSection);
    }
});