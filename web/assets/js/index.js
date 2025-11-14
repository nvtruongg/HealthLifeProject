// ==================== HERO SLIDER ====================
let currentSlide = 0;
const slides = document.querySelectorAll('.hero-slide');
const dots = document.querySelectorAll('.dot');
const totalSlides = slides.length;

// Auto slide every 5 seconds
let slideInterval = setInterval(() => {
    changeSlide(1);
}, 5000);

function changeSlide(direction) {
    // Remove active class from current slide and dot
    slides[currentSlide].classList.remove('active');
    dots[currentSlide].classList.remove('active');
    
    // Calculate new slide index
    currentSlide = (currentSlide + direction + totalSlides) % totalSlides;
    
    // Add active class to new slide and dot
    slides[currentSlide].classList.add('active');
    dots[currentSlide].classList.add('active');
    
    // Reset auto slide interval
    clearInterval(slideInterval);
    slideInterval = setInterval(() => {
        changeSlide(1);
    }, 5000);
}

function goToSlide(index) {
    slides[currentSlide].classList.remove('active');
    dots[currentSlide].classList.remove('active');
    
    currentSlide = index;
    
    slides[currentSlide].classList.add('active');
    dots[currentSlide].classList.add('active');
    
    clearInterval(slideInterval);
    slideInterval = setInterval(() => {
        changeSlide(1);
    }, 5000);
}

// ==================== COUNTER ANIMATION ====================
function animateCounter(element) {
    const target = parseFloat(element.getAttribute('data-target'));
    const duration = 2000; // 2 seconds
    const step = target / (duration / 16); // 60fps
    let current = 0;
    
    const timer = setInterval(() => {
        current += step;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        
        // Format number
        if (target % 1 !== 0) {
            element.textContent = current.toFixed(1);
        } else {
            element.textContent = Math.floor(current).toLocaleString();
        }
    }, 16);
}

// Intersection Observer for counter animation
const statsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const counters = entry.target.querySelectorAll('.stat-number');
            counters.forEach(counter => {
                animateCounter(counter);
            });
            statsObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

const statsSection = document.querySelector('.stats-section');
if (statsSection) {
    statsObserver.observe(statsSection);
}

// ==================== SCROLL ANIMATIONS ====================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe all cards
document.querySelectorAll('.category-card, .product-card, .feature-card, .testimonial-card').forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(30px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(card);
});

// ==================== ADD TO CART FUNCTION ====================
function addToCart(productId) {
    // Check if user is logged in
    const isLoggedIn = checkUserLogin();
    
    if (!isLoggedIn) {
        showNotification('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng', 'warning');
        setTimeout(() => {
            window.location.href = 'login.jsp';
        }, 1500);
        return;
    }
    
    // Show loading
    showLoading();
    
    // Make AJAX request to add to cart
    fetch('cart?action=add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productId=${productId}&quantity=1`
    })
    .then(response => response.json())
    .then(data => {
        hideLoading();
        if (data.success) {
            showNotification('Đã thêm sản phẩm vào giỏ hàng!', 'success');
            updateCartCount(data.cartCount);
            
            // Optional: Show mini cart preview
            showMiniCart();
        } else {
            showNotification(data.message || 'Có lỗi xảy ra!', 'error');
        }
    })
    .catch(error => {
        hideLoading();
        console.error('Error:', error);
        showNotification('Có lỗi xảy ra khi thêm vào giỏ hàng!', 'error');
    });
}

// ==================== ADD TO WISHLIST ====================
function addToWishlist(productId) {
    const isLoggedIn = checkUserLogin();
    
    if (!isLoggedIn) {
        showNotification('Vui lòng đăng nhập để thêm vào danh sách yêu thích', 'warning');
        setTimeout(() => {
            window.location.href = 'login.jsp';
        }, 1500);
        return;
    }
    
    fetch('wishlist?action=add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productId=${productId}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('Đã thêm vào danh sách yêu thích!', 'success');
            // Update heart icon
            const heartIcon = event.target.closest('button').querySelector('i');
            if (heartIcon) {
                heartIcon.classList.remove('far');
                heartIcon.classList.add('fas');
                heartIcon.style.color = '#ef4444';
            }
        } else {
            showNotification(data.message || 'Có lỗi xảy ra!', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Có lỗi xảy ra!', 'error');
    });
}

// ==================== NEWSLETTER SUBSCRIPTION ====================
function subscribeNewsletter(event) {
    event.preventDefault();
    
    const form = event.target;
    const email = form.querySelector('input[type="email"]').value;
    
    if (!validateEmail(email)) {
        showNotification('Email không hợp lệ!', 'error');
        return;
    }
    
    showLoading();
    
    fetch('newsletter?action=subscribe', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `email=${encodeURIComponent(email)}`
    })
    .then(response => response.json())
    .then(data => {
        hideLoading();
        if (data.success) {
            showNotification('Đăng ký thành công! Cảm ơn bạn đã quan tâm.', 'success');
            form.reset();
        } else {
            showNotification(data.message || 'Email đã được đăng ký trước đó!', 'warning');
        }
    })
    .catch(error => {
        hideLoading();
        console.error('Error:', error);
        showNotification('Có lỗi xảy ra khi đăng ký!', 'error');
    });
}

// ==================== UTILITY FUNCTIONS ====================

// Check if user is logged in
function checkUserLogin() {
    // This should check session or cookie
    // For now, we'll check if user info exists in sessionStorage
    return sessionStorage.getItem('userId') !== null || 
           document.cookie.includes('userId=');
}

// Validate email
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Update cart count in header
function updateCartCount(count) {
    const cartCountElement = document.querySelector('.cart-count');
    if (cartCountElement) {
        cartCountElement.textContent = count;
        cartCountElement.style.transform = 'scale(1.3)';
        setTimeout(() => {
            cartCountElement.style.transform = 'scale(1)';
        }, 300);
    }
}

// Show mini cart preview
function showMiniCart() {
    // Implementation for showing a mini cart dropdown
    // This is a placeholder - actual implementation depends on your design
    console.log('Show mini cart preview');
}

// Show loading spinner
function showLoading() {
    const loader = document.createElement('div');
    loader.id = 'page-loader';
    loader.innerHTML = `
        <div class="loader-spinner">
            <i class="fas fa-spinner fa-spin fa-3x"></i>
        </div>
    `;
    document.body.appendChild(loader);
    
    // Add CSS for loader
    const style = document.createElement('style');
    style.textContent = `
        #page-loader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        .loader-spinner {
            background: white;
            padding: 30px;
            border-radius: 15px;
            color: var(--primary-color);
        }
    `;
    document.head.appendChild(style);
}

// Hide loading spinner
function hideLoading() {
    const loader = document.getElementById('page-loader');
    if (loader) {
        loader.remove();
    }
}

// Show notification toast
function showNotification(message, type = 'info') {
    // Remove existing notification
    const existingNotification = document.querySelector('.notification-toast');
    if (existingNotification) {
        existingNotification.remove();
    }
    
    const notification = document.createElement('div');
    notification.className = `notification-toast notification-${type}`;
    
    const icons = {
        success: 'fa-check-circle',
        error: 'fa-exclamation-circle',
        warning: 'fa-exclamation-triangle',
        info: 'fa-info-circle'
    };
    
    notification.innerHTML = `
        <i class="fas ${icons[type]}"></i>
        <span>${message}</span>
    `;
    
    document.body.appendChild(notification);
    
    // Add CSS for notification
    const style = document.createElement('style');
    style.textContent = `
        .notification-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 10px;
            background: white;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 12px;
            z-index: 10000;
            animation: slideIn 0.3s ease-out;
            font-weight: 500;
        }
        
        @keyframes slideIn {
            from {
                transform: translateX(400px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(400px);
                opacity: 0;
            }
        }
        
        .notification-success { border-left: 4px solid #10b981; color: #10b981; }
        .notification-error { border-left: 4px solid #ef4444; color: #ef4444; }
        .notification-warning { border-left: 4px solid #f59e0b; color: #f59e0b; }
        .notification-info { border-left: 4px solid #3b82f6; color: #3b82f6; }
        
        .notification-toast i {
            font-size: 1.5rem;
        }
        
        .notification-toast span {
            color: #374151;
        }
    `;
    
    if (!document.querySelector('#notification-style')) {
        style.id = 'notification-style';
        document.head.appendChild(style);
    }
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 3000);
}

// ==================== SMOOTH SCROLL ====================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href !== '#' && document.querySelector(href)) {
            e.preventDefault();
            document.querySelector(href).scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// ==================== HEADER SCROLL EFFECT ====================
let lastScroll = 0;
const header = document.querySelector('header');

window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll > 100) {
        header?.classList.add('scrolled');
    } else {
        header?.classList.remove('scrolled');
    }
    
    // Hide/show header on scroll
    if (currentScroll > lastScroll && currentScroll > 500) {
        header?.classList.add('hidden');
    } else {
        header?.classList.remove('hidden');
    }
    
    lastScroll = currentScroll;
});

// ==================== LAZY LOADING IMAGES ====================
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.add('loaded');
                observer.unobserve(img);
            }
        });
    });
    
    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
}

// ==================== INITIALIZE ON PAGE LOAD ====================
document.addEventListener('DOMContentLoaded', () => {
    console.log('HealthLife Homepage loaded successfully!');
    
    // Add any initialization code here
    // For example: load featured products, check user session, etc.
});

// ==================== KEYBOARD NAVIGATION ====================
document.addEventListener('keydown', (e) => {
    // Arrow keys for slider navigation
    if (e.key === 'ArrowLeft') {
        changeSlide(-1);
    } else if (e.key === 'ArrowRight') {
        changeSlide(1);
    }
});