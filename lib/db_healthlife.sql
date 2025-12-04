-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 07, 2025 lúc 03:41 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `db_healthlife`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bai_viet`
--

CREATE TABLE `bai_viet` (
  `id` int(11) NOT NULL,
  `tieu_de` varchar(255) NOT NULL,
  `tom_tat` text DEFAULT NULL,
  `noi_dung` longtext NOT NULL,
  `hinh_anh_tieu_de` varchar(255) DEFAULT NULL,
  `id_nguoi_tao` int(11) NOT NULL,
  `ngay_dang` datetime DEFAULT current_timestamp(),
  `trang_thai` enum('nhap','xuat_ban') NOT NULL DEFAULT 'nhap'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `bai_viet`
--

INSERT INTO `bai_viet` (`id`, `tieu_de`, `tom_tat`, `noi_dung`, `hinh_anh_tieu_de`, `id_nguoi_tao`, `ngay_dang`, `trang_thai`) VALUES
(1, '5 Lợi ích bất ngờ của Vitamin C', 'Vitamin C không chỉ tăng đề kháng...', 'Nội dung chi tiết của bài viết... (HTML)', NULL, 1, '2025-10-25 17:34:57', 'xuat_ban');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `id` int(11) NOT NULL,
  `id_don_hang` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL CHECK (`so_luong` > 0),
  `gia_luc_mua` decimal(15,2) NOT NULL,
  `thanh_tien` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`id`, `id_don_hang`, `id_san_pham`, `so_luong`, `gia_luc_mua`, `thanh_tien`) VALUES
(1, 1, 1, 1, 390000.00, 390000.00),
(2, 1, 2, 1, 290000.00, 290000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danh_gia`
--

CREATE TABLE `danh_gia` (
  `id` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `so_sao` tinyint(4) NOT NULL CHECK (`so_sao` >= 1 and `so_sao` <= 5),
  `binh_luan` text DEFAULT NULL,
  `ngay_danh_gia` datetime DEFAULT current_timestamp(),
  `trang_thai` enum('cho_duyet','da_duyet') NOT NULL DEFAULT 'cho_duyet'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danh_gia`
--

INSERT INTO `danh_gia` (`id`, `id_san_pham`, `id_nguoi_dung`, `so_sao`, `binh_luan`, `ngay_danh_gia`, `trang_thai`) VALUES
(1, 1, 2, 5, 'Sản phẩm tốt, giao hàng nhanh. Sẽ ủng hộ shop lâu dài!', '2025-10-25 17:34:57', 'da_duyet'),
(2, 1, 2, 5, 'Sản phẩm rất tốt, giao hàng nhanh.', '2025-11-07 08:19:34', 'da_duyet'),
(3, 2, 3, 4, 'Dầu cá uống dễ, hiệu quả ổn.', '2025-11-07 08:19:34', 'da_duyet'),
(4, 3, 4, 5, 'Da căng bóng sau 2 tuần sử dụng.', '2025-11-07 08:19:34', 'da_duyet'),
(5, 4, 5, 4, 'Giá hợp lý, đóng gói cẩn thận.', '2025-11-07 08:19:34', 'da_duyet'),
(6, 5, 6, 5, 'Serum siêu tốt, dùng rất thích.', '2025-11-07 08:19:34', 'da_duyet'),
(7, 6, 7, 3, 'Khá ổn, mùi hơi hắc.', '2025-11-07 08:19:34', 'da_duyet'),
(8, 7, 8, 5, 'Bổ sung canxi hiệu quả.', '2025-11-07 08:19:34', 'da_duyet'),
(9, 8, 9, 4, 'Uống đều đặn thấy cải thiện.', '2025-11-07 08:19:34', 'da_duyet'),
(10, 9, 10, 5, 'Vitamin tổng hợp tốt cho nữ.', '2025-11-07 08:19:34', 'da_duyet'),
(11, 10, 11, 4, 'Phù hợp với người lớn tuổi.', '2025-11-07 08:19:34', 'da_duyet'),
(12, 11, 12, 5, 'Sản phẩm chính hãng, giao đúng hẹn.', '2025-11-07 08:19:34', 'da_duyet'),
(13, 12, 13, 4, 'Viên uống dễ nuốt, hiệu quả tốt.', '2025-11-07 08:19:34', 'da_duyet'),
(14, 13, 14, 5, 'Rất ưng ý, sẽ mua lại.', '2025-11-07 08:19:34', 'da_duyet'),
(15, 14, 15, 4, 'Giá tốt so với chất lượng.', '2025-11-07 08:19:34', 'da_duyet'),
(16, 15, 16, 5, 'Uống thấy người khỏe hơn.', '2025-11-07 08:19:34', 'da_duyet');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danh_muc`
--

CREATE TABLE `danh_muc` (
  `id` int(11) NOT NULL,
  `ten_danh_muc` varchar(255) NOT NULL,
  `id_danh_muc_cha` int(11) DEFAULT NULL,
  `hinh_anh` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danh_muc`
--

INSERT INTO `danh_muc` (`id`, `ten_danh_muc`, `id_danh_muc_cha`, `hinh_anh`, `mo_ta`) VALUES
(1, 'Thực phẩm chức năng', NULL, NULL, 'Các sản phẩm bổ sung dinh dưỡng'),
(2, 'Chăm sóc cá nhân', NULL, NULL, 'Các sản phẩm làm đẹp và vệ sinh'),
(3, 'Vitamin & Khoáng chất', 1, NULL, 'Bổ sung Vitamin A, B, C, D...'),
(4, 'Hỗ trợ Tiêu hóa', 1, NULL, 'Men vi sinh, hỗ trợ dạ dày'),
(5, 'Chăm sóc da mặt', 2, NULL, 'Sữa rửa mặt, kem dưỡng ẩm'),
(6, 'Tăng sức đề kháng', 1, NULL, 'Các loại sản phẩm tăng đề kháng'),
(7, 'Giảm cân - Dinh dưỡng', 1, NULL, 'Thực phẩm kiểm soát cân nặng'),
(8, 'Dưỡng da mặt', 2, NULL, 'Sữa rửa mặt, serum, kem dưỡng'),
(9, 'Chống nắng', 2, NULL, 'Kem chống nắng, xịt chống nắng'),
(10, 'Chăm sóc tóc', 2, NULL, 'Dầu gội, dưỡng tóc, serum'),
(11, 'Chăm sóc răng miệng', 2, NULL, 'Kem đánh răng, nước súc miệng'),
(12, 'Thực phẩm bổ mắt', 1, NULL, 'Dành cho mắt và thị lực'),
(13, 'Hỗ trợ tim mạch', 1, NULL, 'Omega 3, dầu cá...'),
(14, 'Sữa dinh dưỡng', 1, NULL, 'Sản phẩm sữa bột dinh dưỡng'),
(15, 'Dưỡng thể', 2, NULL, 'Kem dưỡng toàn thân'),
(16, 'Trang điểm', 2, NULL, 'Mỹ phẩm trang điểm cơ bản');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `don_hang`
--

CREATE TABLE `don_hang` (
  `id` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `ma_don_hang` varchar(20) NOT NULL,
  `ten_nguoi_nhan` varchar(100) NOT NULL,
  `so_dien_thoai_nhan` varchar(15) NOT NULL,
  `dia_chi_giao_hang` text NOT NULL,
  `email_nguoi_nhan` varchar(100) DEFAULT NULL,
  `ngay_dat` datetime DEFAULT current_timestamp(),
  `tong_tien_san_pham` decimal(15,2) NOT NULL,
  `phi_van_chuyen` decimal(15,2) NOT NULL DEFAULT 0.00,
  `tong_thanh_toan` decimal(15,2) NOT NULL,
  `phuong_thuc_thanh_toan` enum('cod','chuyen_khoan','vnpay') NOT NULL DEFAULT 'cod',
  `trang_thai_thanh_toan` enum('chua_thanh_toan','da_thanh_toan') NOT NULL DEFAULT 'chua_thanh_toan',
  `trang_thai_don_hang` enum('cho_xac_nhan','da_xac_nhan','dang_giao','hoan_thanh','da_huy') NOT NULL DEFAULT 'cho_xac_nhan',
  `ghi_chu_khach_hang` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `don_hang`
--

INSERT INTO `don_hang` (`id`, `id_nguoi_dung`, `ma_don_hang`, `ten_nguoi_nhan`, `so_dien_thoai_nhan`, `dia_chi_giao_hang`, `email_nguoi_nhan`, `ngay_dat`, `tong_tien_san_pham`, `phi_van_chuyen`, `tong_thanh_toan`, `phuong_thuc_thanh_toan`, `trang_thai_thanh_toan`, `trang_thai_don_hang`, `ghi_chu_khach_hang`) VALUES
(1, 2, 'HLF20251025001', 'Trần Văn An', '0900000002', 'Số 123, đường ABC, Phường Cống Vị, Quận Ba Đình, Thành phố Hà Nội', 'user.an@gmail.com', '2025-10-25 17:34:57', 680000.00, 15000.00, 695000.00, 'cod', 'chua_thanh_toan', 'dang_giao', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hinh_anh_san_pham`
--

CREATE TABLE `hinh_anh_san_pham` (
  `id` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `url_hinh_anh` varchar(255) NOT NULL,
  `sap_xep` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(15) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `vai_tro` enum('khach_hang','admin') NOT NULL DEFAULT 'khach_hang',
  `trang_thai` enum('hoat_dong','bi_khoa') NOT NULL DEFAULT 'hoat_dong',
  `ngay_tao` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`id`, `ho_ten`, `email`, `so_dien_thoai`, `mat_khau`, `vai_tro`, `trang_thai`, `ngay_tao`) VALUES
(1, 'Quản Trị Viên', 'admin@healthlife.com', '0900000001', '$2a$10$E.qfSIV.NqNW.R.0y1k6DeH.3wT9.w.Q.8U1LzL5jUqg.aL1m5qIe', 'admin', 'hoat_dong', '2025-10-25 17:34:57'),
(2, 'Trần Văn An', 'user.an@gmail.com', '0900000002', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-10-25 17:34:57'),
(3, 'Nguyễn Thị Bình', 'user.binh@gmail.com', '0900000003', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-10-25 17:34:57'),
(4, 'Lê Thị Hoa', 'hoa@gmail.com', '0901000004', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(5, 'Phạm Văn Cường', 'cuong@gmail.com', '0901000005', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(6, 'Nguyễn Thanh Hương', 'huong@gmail.com', '0901000006', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(7, 'Đỗ Văn Hải', 'hai@gmail.com', '0901000007', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(8, 'Trần Thị Mai', 'mai@gmail.com', '0901000008', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(9, 'Nguyễn Văn Long', 'long@gmail.com', '0901000009', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(10, 'Vũ Hồng Phúc', 'phuc@gmail.com', '0901000010', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(11, 'Lưu Thị Trang', 'trang@gmail.com', '0901000011', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(12, 'Hoàng Văn Lâm', 'lam@gmail.com', '0901000012', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(13, 'Nguyễn Thị Ngọc', 'ngoc@gmail.com', '0901000013', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(14, 'Phạm Văn Toàn', 'toan@gmail.com', '0901000014', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(15, 'Lý Thị Nhung', 'nhung@gmail.com', '0901000015', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(16, 'Trần Đức Hạnh', 'hanh@gmail.com', '0901000016', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(17, 'Nguyễn Thu Yến', 'yen@gmail.com', '0901000017', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(18, 'Đặng Văn Minh', 'minh@gmail.com', '0901000018', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(19, 'Phan Thị Quyên', 'quyen@gmail.com', '0901000019', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(20, 'Nguyễn Hữu Phong', 'phong@gmail.com', '0901000020', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(21, 'Trần Thu Hiền', 'hien@gmail.com', '0901000021', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(22, 'Đỗ Văn Thành', 'thanh@gmail.com', '0901000022', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04'),
(23, 'Lê Thị Oanh', 'oanh@gmail.com', '0901000023', '$2a$10$bJ/T.X.67S.N8/Cj3jF9r.KMnJgE6x0mZ.7J.8XQ.3qJmO1s.A/pW', 'khach_hang', 'hoat_dong', '2025-11-01 14:30:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `san_pham`
--

CREATE TABLE `san_pham` (
  `id` int(11) NOT NULL,
  `ma_san_pham` varchar(50) NOT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `id_danh_muc` int(11) NOT NULL,
  `id_thuong_hieu` int(11) NOT NULL,
  `mo_ta_ngan` text DEFAULT NULL,
  `mo_ta_chi_tiet` longtext DEFAULT NULL,
  `gia_goc` decimal(15,2) NOT NULL DEFAULT 0.00,
  `gia_ban` decimal(15,2) NOT NULL DEFAULT 0.00,
  `so_luong_ton` int(11) NOT NULL DEFAULT 0,
  `don_vi_tinh` varchar(50) DEFAULT 'Hộp',
  `hinh_anh_dai_dien` varchar(255) DEFAULT NULL,
  `thanh_phan` longtext DEFAULT NULL,
  `cong_dung` longtext DEFAULT NULL,
  `lieu_dung_cach_dung` longtext DEFAULT NULL,
  `bao_quan` longtext DEFAULT NULL,
  `trang_thai` enum('dang_kinh_doanh','ngung_kinh_doanh') NOT NULL DEFAULT 'dang_kinh_doanh',
  `ngay_tao` datetime DEFAULT current_timestamp(),
  `ngay_cap_nhat` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `san_pham`
--

INSERT INTO `san_pham` (`id`, `ma_san_pham`, `ten_san_pham`, `id_danh_muc`, `id_thuong_hieu`, `mo_ta_ngan`, `mo_ta_chi_tiet`, `gia_goc`, `gia_ban`, `so_luong_ton`, `don_vi_tinh`, `hinh_anh_dai_dien`, `thanh_phan`, `cong_dung`, `lieu_dung_cach_dung`, `bao_quan`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'BM_VITC_500', 'Viên uống Blackmores Bio C 1000mg', 3, 1, NULL, NULL, 450000.00, 390000.00, 100, 'Hộp 62 viên', 'Images/blackmores.webp', NULL, 'Bổ sung Vitamin C, tăng cường đề kháng.', 'Người lớn: 1 viên/ngày sau bữa ăn.', NULL, 'dang_kinh_doanh', '2025-10-01 08:01:00', '2025-10-01 08:01:00'),
(2, 'DHC_COLLAGEN_60', 'Viên uống DHC Collagen 60 ngày', 5, 2, NULL, NULL, 350000.00, 290000.00, 150, 'Túi 360 viên', 'Images/dhccollagen.webp', NULL, 'Bổ sung collagen, làm đẹp da, móng, tóc.', 'Uống 6 viên/ngày, có thể chia 2 lần. Uống sau bữa ăn.', NULL, 'dang_kinh_doanh', '2025-10-01 08:02:00', '2025-10-01 08:02:00'),
(3, 'LRP_B5_SERUM', 'Serum La Roche-Posay Hyalu B5', 5, 3, NULL, NULL, 950000.00, 950000.00, 50, 'Chai 30ml', 'Images/lrp_b5.webp', NULL, 'Phục hồi da, cấp ẩm chuyên sâu.', 'Sử dụng sáng và tối, sau bước làm sạch.', NULL, 'dang_kinh_doanh', '2025-10-01 08:03:00', '2025-10-01 08:03:00'),
(4, 'BM_FISHOIL_1000', 'Viên dầu cá Blackmores Fish Oil 1000mg', 12, 1, NULL, NULL, 520000.00, 460000.00, 80, 'Lọ 200 viên', 'images/sp02.jpg', NULL, 'Tốt cho tim mạch, não bộ và thị lực', '2 viên/ngày sau ăn', NULL, 'dang_kinh_doanh', '2025-10-01 08:04:00', '2025-10-01 08:04:00'),
(5, 'DHC_VITB', 'Viên uống DHC Vitamin B Mix', 3, 2, NULL, NULL, 250000.00, 210000.00, 200, 'Túi 60 viên', 'images/sp04.jpg', NULL, 'Hỗ trợ giảm stress, sáng da', '2 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:05:00', '2025-10-01 08:05:00'),
(6, 'LRP_CICAPLAST', 'Kem phục hồi da La Roche-Posay Cicaplast Baume B5', 7, 3, NULL, NULL, 400000.00, 370000.00, 90, 'Tuýp 40ml', 'images/sp06.jpg', NULL, 'Phục hồi, làm dịu da kích ứng', 'Bôi 2 lần/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:06:00', '2025-10-01 08:06:00'),
(7, 'NM_CALCIUM', 'Nature Made Calcium + D3', 3, 4, NULL, NULL, 420000.00, 370000.00, 120, 'Lọ 100 viên', 'images/sp07.jpg', NULL, 'Bổ sung canxi và vitamin D', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:07:00', '2025-10-01 08:07:00'),
(8, 'NM_VITD', 'Nature Made Vitamin D3 2000IU', 3, 4, NULL, NULL, 390000.00, 340000.00, 150, 'Lọ 90 viên', 'images/sp08.jpg', NULL, 'Hỗ trợ hấp thụ canxi, xương chắc khỏe', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:08:00', '2025-10-01 08:08:00'),
(9, 'SWISSE_WOMEN', 'Swisse Women’s Ultivite Multivitamin', 3, 5, NULL, NULL, 600000.00, 520000.00, 70, 'Hộp 60 viên', 'images/sp09.jpg', NULL, 'Bổ sung vitamin tổng hợp cho nữ', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:09:00', '2025-10-01 08:09:00'),
(10, 'SWISSE_MEN', 'Swisse Men’s Ultivite Multivitamin', 3, 5, NULL, NULL, 600000.00, 520000.00, 80, 'Hộp 60 viên', 'images/sp10.jpg', NULL, 'Vitamin tổng hợp cho nam giới', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:10:00', '2025-10-01 08:10:00'),
(11, 'CENTRUM_ADULT', 'Centrum Adult Multivitamin', 3, 6, NULL, NULL, 550000.00, 480000.00, 100, 'Lọ 100 viên', 'images/sp11.jpg', NULL, 'Vitamin tổng hợp cho người lớn', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:11:00', '2025-10-01 08:11:00'),
(12, 'CENTRUM_SILVER', 'Centrum Silver 50+ Multivitamin', 3, 6, NULL, NULL, 580000.00, 500000.00, 90, 'Lọ 100 viên', 'images/sp12.jpg', NULL, 'Vitamin cho người trên 50 tuổi', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:12:00', '2025-10-01 08:12:00'),
(13, 'PURITAN_ZINC', 'Puritan’s Pride Zinc 50mg', 3, 7, NULL, NULL, 350000.00, 300000.00, 120, 'Lọ 100 viên', 'images/sp13.jpg', NULL, 'Bổ sung kẽm tăng miễn dịch', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:13:00', '2025-10-01 08:13:00'),
(14, 'PURITAN_VITE', 'Puritan’s Pride Vitamin E 400IU', 3, 7, NULL, NULL, 370000.00, 320000.00, 110, 'Lọ 100 viên', 'images/sp14.jpg', NULL, 'Tốt cho da và tim mạch', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:14:00', '2025-10-01 08:14:00'),
(15, 'HEALTHY_CARE_OMEGA', 'Healthy Care Fish Oil 1000mg', 12, 8, NULL, NULL, 420000.00, 370000.00, 140, 'Lọ 400 viên', 'images/sp15.jpg', NULL, 'Cải thiện trí nhớ và tim mạch', '2 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:15:00', '2025-10-01 08:15:00'),
(16, 'HEALTHY_CARE_VITC', 'Healthy Care Vitamin C 500mg', 3, 8, NULL, NULL, 300000.00, 260000.00, 180, 'Lọ 150 viên', 'images/sp16.jpg', NULL, 'Tăng sức đề kháng', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:16:00', '2025-10-01 08:16:00'),
(17, 'INNISFREE_CREAM', 'Innisfree Green Tea Seed Cream', 7, 9, NULL, NULL, 450000.00, 410000.00, 100, 'Hũ 50ml', 'images/sp17.jpg', NULL, 'Cấp ẩm và làm dịu da', 'Bôi 2 lần/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:17:00', '2025-10-01 08:17:00'),
(18, 'INNISFREE_MASK', 'Mặt nạ Innisfree My Real Squeeze', 7, 9, NULL, NULL, 30000.00, 25000.00, 300, 'Miếng', 'images/sp18.jpg', NULL, 'Dưỡng ẩm, thư giãn da mặt', 'Đắp 15-20 phút', NULL, 'dang_kinh_doanh', '2025-10-01 08:18:00', '2025-10-01 08:18:00'),
(19, 'ORDINARY_SERUM', 'The Ordinary Niacinamide 10% + Zinc 1%', 7, 10, NULL, NULL, 350000.00, 320000.00, 200, 'Chai 30ml', 'images/sp19.jpg', NULL, 'Giảm mụn, kiểm soát dầu', 'Dùng sáng/tối', NULL, 'dang_kinh_doanh', '2025-10-01 08:19:00', '2025-10-01 08:19:00'),
(20, 'ORDINARY_ACID', 'The Ordinary AHA 30% + BHA 2%', 7, 10, NULL, NULL, 400000.00, 370000.00, 150, 'Chai 30ml', 'images/sp20.jpg', NULL, 'Tẩy tế bào chết hóa học', '2 lần/tuần', NULL, 'dang_kinh_doanh', '2025-10-01 08:20:00', '2025-10-01 08:20:00'),
(21, 'BLACKMORES_GLUCO', 'Blackmores Glucosamine 1500mg', 12, 1, NULL, NULL, 700000.00, 620000.00, 60, 'Lọ 180 viên', 'images/sp21.jpg', NULL, 'Hỗ trợ xương khớp', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:21:00', '2025-10-01 08:21:00'),
(22, 'BLACKMORES_VITAMINB', 'Blackmores B Complex', 3, 1, NULL, NULL, 420000.00, 370000.00, 120, 'Lọ 100 viên', 'images/sp22.jpg', NULL, 'Giảm mệt mỏi, tăng năng lượng', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:22:00', '2025-10-01 08:22:00'),
(23, 'DHC_MELATONIN', 'DHC Melatonin 3mg', 5, 2, NULL, NULL, 320000.00, 270000.00, 100, 'Túi 60 viên', 'images/sp23.jpg', NULL, 'Hỗ trợ giấc ngủ sâu', '1 viên trước ngủ', NULL, 'dang_kinh_doanh', '2025-10-01 08:23:00', '2025-10-01 08:23:00'),
(24, 'CENTRUM_KIDS', 'Centrum Kids Orange Chewables', 3, 6, NULL, NULL, 400000.00, 360000.00, 120, 'Hộp 60 viên', 'images/sp24.jpg', NULL, 'Vitamin tổng hợp cho trẻ em', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:24:00', '2025-10-01 08:24:00'),
(25, 'PURITAN_OMEGA3', 'Puritan’s Pride Omega-3 Fish Oil', 12, 7, NULL, NULL, 500000.00, 440000.00, 100, 'Lọ 200 viên', 'images/sp25.jpg', NULL, 'Tốt cho tim mạch', '2 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:25:00', '2025-10-01 08:25:00'),
(26, 'HEALTHY_CARE_PROPOLIS', 'Healthy Care Propolis 2000mg', 5, 8, NULL, NULL, 600000.00, 520000.00, 90, 'Lọ 200 viên', 'images/sp26.jpg', NULL, 'Tăng sức đề kháng, chống oxy hóa', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:26:00', '2025-10-01 08:26:00'),
(27, 'INNISFREE_CLEANSER', 'Sữa rửa mặt Innisfree Jeju Volcanic', 7, 9, NULL, NULL, 280000.00, 250000.00, 180, 'Tuýp 150ml', 'images/sp27.jpg', NULL, 'Làm sạch sâu, giảm mụn đầu đen', 'Dùng sáng và tối', NULL, 'dang_kinh_doanh', '2025-10-01 08:27:00', '2025-10-01 08:27:00'),
(28, 'ORDINARY_HYALU', 'The Ordinary Hyaluronic Acid 2% + B5', 7, 10, NULL, NULL, 320000.00, 290000.00, 130, 'Chai 30ml', 'images/sp28.jpg', NULL, 'Cấp ẩm cho da', 'Dùng sáng và tối', NULL, 'dang_kinh_doanh', '2025-10-01 08:28:00', '2025-10-01 08:28:00'),
(29, 'SWISSE_VITC', 'Swisse Vitamin C Effervescent 1000mg', 3, 5, NULL, NULL, 400000.00, 350000.00, 200, 'Ống 60 viên sủi', 'images/sp29.jpg', NULL, 'Tăng đề kháng, chống mệt mỏi', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:29:00', '2025-10-01 08:29:00'),
(30, 'CENTRUM_MEN', 'Centrum Men Multivitamin', 3, 6, NULL, NULL, 550000.00, 480000.00, 100, 'Lọ 100 viên', 'images/sp30.jpg', NULL, 'Vitamin tổng hợp cho nam giới', '1 viên/ngày', NULL, 'dang_kinh_doanh', '2025-10-01 08:30:00', '2025-10-01 08:30:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `so_dia_chi`
--

CREATE TABLE `so_dia_chi` (
  `id` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `ten_nguoi_nhan` varchar(100) NOT NULL,
  `so_dien_thoai_nhan` varchar(15) NOT NULL,
  `dia_chi_chi_tiet` varchar(255) NOT NULL,
  `phuong_xa` varchar(100) NOT NULL,
  `quan_huyen` varchar(100) NOT NULL,
  `tinh_thanh` varchar(100) NOT NULL,
  `la_mac_dinh` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `so_dia_chi`
--

INSERT INTO `so_dia_chi` (`id`, `id_nguoi_dung`, `ten_nguoi_nhan`, `so_dien_thoai_nhan`, `dia_chi_chi_tiet`, `phuong_xa`, `quan_huyen`, `tinh_thanh`, `la_mac_dinh`) VALUES
(1, 2, 'Trần Văn An', '0900000002', 'Số 123, đường ABC', 'Phường Cống Vị', 'Quận Ba Đình', 'Thành phố Hà Nội', 1),
(2, 3, 'Nguyễn Thị Bình', '0900000003', '45 Lý Thường Kiệt', 'Phường 7', 'Quận 10', 'TP.HCM', 1),
(3, 4, 'Lê Thị Hoa', '0901000004', '12 Nguyễn Huệ', 'Phường 1', 'Quận 1', 'TP.HCM', 1),
(4, 5, 'Phạm Văn Cường', '0901000005', '88 Đinh Tiên Hoàng', 'Phường Trúc Bạch', 'Ba Đình', 'Hà Nội', 1),
(5, 6, 'Nguyễn Thanh Hương', '0901000006', 'Số 9, Nguyễn Văn Cừ', 'Phường Bồ Đề', 'Long Biên', 'Hà Nội', 1),
(6, 7, 'Đỗ Văn Hải', '0901000007', '456 Nguyễn Trãi', 'Phường Thượng Đình', 'Thanh Xuân', 'Hà Nội', 1),
(7, 8, 'Trần Thị Mai', '0901000008', '22 Nguyễn Văn Linh', 'Phường Hòa Minh', 'Liên Chiểu', 'Đà Nẵng', 1),
(8, 9, 'Nguyễn Văn Long', '0901000009', '15 Phan Chu Trinh', 'Phường Điện Biên', 'Ba Đình', 'Hà Nội', 1),
(9, 10, 'Vũ Hồng Phúc', '0901000010', '80 Trần Hưng Đạo', 'Phường 6', 'Quận 5', 'TP.HCM', 1),
(10, 11, 'Lưu Thị Trang', '0901000011', '71 Hai Bà Trưng', 'Phường Bến Nghé', 'Quận 1', 'TP.HCM', 1),
(11, 12, 'Hoàng Văn Lâm', '0901000012', '123 Nguyễn Lương Bằng', 'Phường Nam Đồng', 'Đống Đa', 'Hà Nội', 1),
(12, 13, 'Nguyễn Thị Ngọc', '0901000013', '56 Nguyễn Văn Cừ', 'Phường An Bình', 'Ninh Kiều', 'Cần Thơ', 1),
(13, 14, 'Phạm Văn Toàn', '0901000014', '7 Nguyễn Trãi', 'Phường Tân Định', 'Quận 1', 'TP.HCM', 1),
(14, 15, 'Lý Thị Nhung', '0901000015', '45 Võ Văn Tần', 'Phường 6', 'Quận 3', 'TP.HCM', 1),
(15, 16, 'Trần Đức Hạnh', '0901000016', '99 Phạm Văn Đồng', 'Phường Linh Tây', 'Thủ Đức', 'TP.HCM', 1),
(16, 17, 'Nguyễn Thu Yến', '0901000017', '21 Nguyễn Văn Linh', 'Phường Tân Phong', 'Quận 7', 'TP.HCM', 1),
(17, 18, 'Đặng Văn Minh', '0901000018', '10 Lý Tự Trọng', 'Phường Bến Nghé', 'Quận 1', 'TP.HCM', 1),
(18, 19, 'Phan Thị Quyên', '0901000019', '12B Lê Lợi', 'Phường Hòa Cường', 'Hải Châu', 'Đà Nẵng', 1),
(19, 20, 'Nguyễn Hữu Phong', '0901000020', '42 Nguyễn Văn Thoại', 'Phường Mỹ An', 'Ngũ Hành Sơn', 'Đà Nẵng', 1),
(20, 21, 'Trần Thu Hiền', '0901000021', '78 Nguyễn Văn Linh', 'Phường Phú Nhuận', 'Quận 1', 'TP.HCM', 1),
(21, 22, 'Đỗ Văn Thành', '0901000022', '19B Lê Duẩn', 'Phường Hòa Thuận', 'Hải Châu', 'Đà Nẵng', 1),
(22, 23, 'Lê Thị Oanh', '0901000023', '66 Hoàng Hoa Thám', 'Phường 2', 'Tân Bình', 'TP.HCM', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thuong_hieu`
--

CREATE TABLE `thuong_hieu` (
  `id` int(11) NOT NULL,
  `ten_thuong_hieu` varchar(255) NOT NULL,
  `xuat_xu` varchar(100) DEFAULT NULL,
  `hinh_anh_logo` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `thuong_hieu`
--

INSERT INTO `thuong_hieu` (`id`, `ten_thuong_hieu`, `xuat_xu`, `hinh_anh_logo`, `mo_ta`) VALUES
(1, 'Blackmores', 'Úc', NULL, NULL),
(2, 'DHC', 'Nhật Bản', NULL, NULL),
(3, 'La Roche-Posay', 'Pháp', NULL, NULL),
(4, 'Nature Made', 'Mỹ', NULL, 'Thực phẩm chức năng phổ biến tại Mỹ'),
(5, 'Swisse', 'Úc', NULL, 'Thực phẩm bổ sung vitamin và khoáng chất'),
(6, 'Centrum', 'Canada', NULL, 'Vitamin tổng hợp dành cho nhiều độ tuổi'),
(7, 'Puritan’s Pride', 'Mỹ', NULL, 'Nhà sản xuất thực phẩm chức năng uy tín'),
(8, 'Healthy Care', 'Úc', NULL, 'Chuyên các sản phẩm chăm sóc sức khỏe'),
(9, 'Innisfree', 'Hàn Quốc', NULL, 'Mỹ phẩm thiên nhiên nổi tiếng của Hàn Quốc'),
(10, 'The Ordinary', 'Anh', NULL, 'Mỹ phẩm chăm sóc da nổi tiếng thế giới');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bai_viet`
--
ALTER TABLE `bai_viet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nguoi_tao` (`id_nguoi_tao`);

--
-- Chỉ mục cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_donhang_sanpham` (`id_don_hang`,`id_san_pham`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_san_pham` (`id_san_pham`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_danh_muc_cha` (`id_danh_muc_cha`);

--
-- Chỉ mục cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_don_hang` (`ma_don_hang`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `so_dien_thoai` (`so_dien_thoai`);

--
-- Chỉ mục cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_san_pham` (`ma_san_pham`),
  ADD KEY `id_danh_muc` (`id_danh_muc`),
  ADD KEY `id_thuong_hieu` (`id_thuong_hieu`);

--
-- Chỉ mục cho bảng `so_dia_chi`
--
ALTER TABLE `so_dia_chi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `thuong_hieu`
--
ALTER TABLE `thuong_hieu`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bai_viet`
--
ALTER TABLE `bai_viet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `danh_muc`
--
ALTER TABLE `danh_muc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `so_dia_chi`
--
ALTER TABLE `so_dia_chi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `thuong_hieu`
--
ALTER TABLE `thuong_hieu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bai_viet`
--
ALTER TABLE `bai_viet`
  ADD CONSTRAINT `bai_viet_ibfk_1` FOREIGN KEY (`id_nguoi_tao`) REFERENCES `nguoi_dung` (`id`);

--
-- Các ràng buộc cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`id_don_hang`) REFERENCES `don_hang` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`);

--
-- Các ràng buộc cho bảng `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD CONSTRAINT `danh_muc_ibfk_1` FOREIGN KEY (`id_danh_muc_cha`) REFERENCES `danh_muc` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`);

--
-- Các ràng buộc cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  ADD CONSTRAINT `hinh_anh_san_pham_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`id_danh_muc`) REFERENCES `danh_muc` (`id`),
  ADD CONSTRAINT `san_pham_ibfk_2` FOREIGN KEY (`id_thuong_hieu`) REFERENCES `thuong_hieu` (`id`);

--
-- Các ràng buộc cho bảng `so_dia_chi`
--
ALTER TABLE `so_dia_chi`
  ADD CONSTRAINT `so_dia_chi_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
