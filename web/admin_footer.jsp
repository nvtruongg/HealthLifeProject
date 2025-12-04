<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Mobile Sidebar Overlay -->
<div id="sidebar-overlay" class="fixed inset-0 bg-black opacity-50 z-20 hidden md:hidden"></div>

<!-- Popup Đăng xuất -->
<div id="logout-modal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50 hidden">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-xl bg-white">
        <div class="mt-3 text-center">
            <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-yellow-100">
                <i class="fas fa-exclamation-triangle fa-lg text-yellow-600"></i>
            </div>
            <h3 class="text-xl leading-6 font-bold text-gray-900 mt-4">Xác nhận Đăng xuất</h3>
            <div class="mt-2 px-7 py-3">
                <p class="text-base text-gray-600">Bạn có chắc chắn muốn đăng xuất?</p>
            </div>
            <div class="items-center px-4 py-3 space-x-4">
                <button id="modal-cancel-btn" class="px-6 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300">Hủy</button>
                <button id="modal-confirm-btn" class="px-6 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700">Đăng xuất</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Toggle Sidebar
        const menuToggle = document.getElementById('menu-toggle');
        const sidebar = document.getElementById('sidebar');
        const sidebarOverlay = document.getElementById('sidebar-overlay');
        function toggleSidebar() {
            sidebar.classList.toggle('-translate-x-full');
            sidebarOverlay.classList.toggle('hidden');
        }
        if(menuToggle) menuToggle.addEventListener('click', toggleSidebar);
        if(sidebarOverlay) sidebarOverlay.addEventListener('click', toggleSidebar);

        // Popup Logout Logic
        const logoutLink = document.getElementById('logout-link');
        const logoutModal = document.getElementById('logout-modal');
        const cancelBtn = document.getElementById('modal-cancel-btn');
        const confirmBtn = document.getElementById('modal-confirm-btn');
        
        if(logoutLink && logoutModal) {
            logoutLink.addEventListener('click', function(e) { e.preventDefault(); logoutModal.classList.remove('hidden'); });
            cancelBtn.addEventListener('click', function() { logoutModal.classList.add('hidden'); });
            confirmBtn.addEventListener('click', function() { window.location.href = logoutLink.href; });
            
            // Đóng khi click ra ngoài
            logoutModal.addEventListener('click', function(e) {
                if (e.target === logoutModal) logoutModal.classList.add('hidden');
            });
        }
        
        // Auto hide toast message
        const toast = document.getElementById('message-toast');
        if(toast) setTimeout(() => { toast.style.display = 'none'; }, 5000);
    });
</script>