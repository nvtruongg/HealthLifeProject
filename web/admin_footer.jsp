<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- 
  File: admin_footer.jsp
  Mô tả: Chứa tất cả JavaScript chung và HTML cho popup.
-->

<!-- Mobile Sidebar Overlay -->
<div id="sidebar-overlay" class="fixed inset-0 bg-black opacity-50 z-20 hidden md:hidden"></div>

<!-- 
  --- POPUP XÁC NHẬN ĐĂNG XUẤT ---
  HTML cho popup (modal)
-->
<div id="logout-modal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50 hidden">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-xl bg-white">
        <div class="mt-3 text-center">
            <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-yellow-100">
                <i class="fas fa-exclamation-triangle fa-lg text-yellow-600"></i>
            </div>
            <h3 class="text-xl leading-6 font-bold text-gray-900 mt-4">Xác nhận Đăng xuất</h3>
            <div class="mt-2 px-7 py-3">
                <p class="text-base text-gray-600">
                    Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?
                </p>
            </div>
            <div class="items-center px-4 py-3 space-x-4">
                <button id="modal-cancel-btn" class="px-6 py-2 bg-gray-200 text-gray-800 rounded-lg font-medium hover:bg-gray-300">
                    Hủy
                </button>
                <button id="modal-confirm-btn" class="px-6 py-2 bg-red-600 text-white rounded-lg font-medium hover:bg-red-700">
                    Đăng xuất
                </button>
            </div>
        </div>
    </div>
</div>
<!-- --- HẾT PHẦN POPUP --- -->


<!-- 
  --- TOÀN BỘ JAVASCRIPT CHUNG ---
-->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        
        // --- Script cho mobile sidebar ---
        const menuToggle = document.getElementById('menu-toggle');
        const sidebar = document.getElementById('sidebar');
        const sidebarOverlay = document.getElementById('sidebar-overlay');

        function toggleSidebar() {
            sidebar.classList.toggle('-translate-x-full');
            sidebarOverlay.classList.toggle('hidden');
        }

        if (menuToggle) {
            menuToggle.addEventListener('click', toggleSidebar);
        }
        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', toggleSidebar);
        }
        
        // --- Script cho biểu đồ (chart) ---
        // Script này chỉ chạy nếu nó tìm thấy canvas có ID 'revenueChart'
        const ctx = document.getElementById('revenueChart');
        if (ctx) {
            new Chart(ctx.getContext('2d'), {
                type: 'line',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
                    datasets: [{
                        label: 'Doanh thu (Triệu VNĐ)',
                        data: [120, 190, 300, 500, 230, 450],
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        borderColor: 'rgba(59, 130, 246, 1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        }
        
        // --- Script cho Popup Đăng xuất ---
        const logoutLink = document.getElementById('logout-link');
        const logoutModal = document.getElementById('logout-modal');
        const modalCancelBtn = document.getElementById('modal-cancel-btn');
        const modalConfirmBtn = document.getElementById('modal-confirm-btn');

        if (logoutLink && logoutModal && modalCancelBtn && modalConfirmBtn) {
            
            logoutLink.addEventListener('click', function(event) {
                event.preventDefault(); 
                logoutModal.classList.remove('hidden'); 
            });

            modalCancelBtn.addEventListener('click', function() {
                logoutModal.classList.add('hidden'); 
            });

            modalConfirmBtn.addEventListener('click', function() {
                window.location.href = logoutLink.href;
            });
            
            logoutModal.addEventListener('click', function(event) {
                if (event.target === logoutModal) {
                    logoutModal.classList.add('hidden');
                }
            });
        }
        
        // --- Script tự ẩn thông báo (nếu có) ---
        const messageToast = document.getElementById('message-toast');
        if (messageToast) {
            setTimeout(() => {
                messageToast.style.transition = 'opacity 0.5s ease';
                messageToast.style.opacity = '0';
                setTimeout(() => messageToast.style.display = 'none', 500);
            }, 5000);
        }

    });
</script>