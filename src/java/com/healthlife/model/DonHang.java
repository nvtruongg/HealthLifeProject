package com.healthlife.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DonHang {
    private int id;
    private int idNguoiDung; // Cột: id_nguoi_dung
    private String maDonHang; // Cột: ma_don_hang
    private String tenNguoiNhan; // Cột: ten_nguoi_nhan
    private String sdtNhan; // Cột: so_dien_thoai_nhan
    private String diaChiGiaoHang; // Cột: dia_chi_giao_hang
    private String emailNguoiNhan; // Cột: email_nguoi_nhan
    private Timestamp ngayDat; // Cột: ngay_dat
    private BigDecimal tongTienSanPham; // Cột: tong_tien_san_pham
    private BigDecimal phiVanChuyen; // Cột: phi_van_chuyen
    private BigDecimal tongThanhToan; // Cột: tong_thanh_toan
    private String phuongThucThanhToan; // Cột: phuong_thuc_thanh_toan (enum: 'cod', 'chuyen_khoan', 'vnpay')
    private String trangThaiThanhToan; // Cột: trang_thai_thanh_toan (enum: 'chua_thanh_toan', 'da_thanh_toan')
    private String trangThaiDonHang;   // Cột: trang_thai_don_hang (enum: 'cho_xac_nhan', 'da_xac_nhan', 'dang_giao', ...)
    private String ghiChu; // Cột: ghi_chu_khach_hang

    public DonHang() {
    }

    public DonHang(int id, int idNguoiDung, String maDonHang, String tenNguoiNhan, String sdtNhan, String diaChiGiaoHang, String emailNguoiNhan, Timestamp ngayDat, BigDecimal tongTienSanPham, BigDecimal phiVanChuyen, BigDecimal tongThanhToan, String phuongThucThanhToan, String trangThaiThanhToan, String trangThaiDonHang, String ghiChu) {
        this.id = id;
        this.idNguoiDung = idNguoiDung;
        this.maDonHang = maDonHang;
        this.tenNguoiNhan = tenNguoiNhan;
        this.sdtNhan = sdtNhan;
        this.diaChiGiaoHang = diaChiGiaoHang;
        this.emailNguoiNhan = emailNguoiNhan;
        this.ngayDat = ngayDat;
        this.tongTienSanPham = tongTienSanPham;
        this.phiVanChuyen = phiVanChuyen;
        this.tongThanhToan = tongThanhToan;
        this.phuongThucThanhToan = phuongThucThanhToan;
        this.trangThaiThanhToan = trangThaiThanhToan;
        this.trangThaiDonHang = trangThaiDonHang;
        this.ghiChu = ghiChu;
    }

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }

    public String getMaDonHang() { return maDonHang; }
    public void setMaDonHang(String maDonHang) { this.maDonHang = maDonHang; }

    public String getTenNguoiNhan() { return tenNguoiNhan; }
    public void setTenNguoiNhan(String tenNguoiNhan) { this.tenNguoiNhan = tenNguoiNhan; }

    public String getSdtNhan() { return sdtNhan; }
    public void setSdtNhan(String sdtNhan) { this.sdtNhan = sdtNhan; }

    public String getDiaChiGiaoHang() { return diaChiGiaoHang; }
    public void setDiaChiGiaoHang(String diaChiGiaoHang) { this.diaChiGiaoHang = diaChiGiaoHang; }

    public String getEmailNguoiNhan() { return emailNguoiNhan; }
    public void setEmailNguoiNhan(String emailNguoiNhan) { this.emailNguoiNhan = emailNguoiNhan; }

    public Timestamp getNgayDat() { return ngayDat; }
    public void setNgayDat(Timestamp ngayDat) { this.ngayDat = ngayDat; }

    public BigDecimal getTongTienSanPham() { return tongTienSanPham; }
    public void setTongTienSanPham(BigDecimal tongTienSanPham) { this.tongTienSanPham = tongTienSanPham; }

    public BigDecimal getPhiVanChuyen() { return phiVanChuyen; }
    public void setPhiVanChuyen(BigDecimal phiVanChuyen) { this.phiVanChuyen = phiVanChuyen; }

    public BigDecimal getTongThanhToan() { return tongThanhToan; }
    public void setTongThanhToan(BigDecimal tongThanhToan) { this.tongThanhToan = tongThanhToan; }

    public String getPhuongThucThanhToan() { return phuongThucThanhToan; }
    public void setPhuongThucThanhToan(String phuongThucThanhToan) { this.phuongThucThanhToan = phuongThucThanhToan; }

    public String getTrangThaiThanhToan() { return trangThaiThanhToan; }
    public void setTrangThaiThanhToan(String trangThaiThanhToan) { this.trangThaiThanhToan = trangThaiThanhToan; }

    public String getTrangThaiDonHang() { return trangThaiDonHang; }
    public void setTrangThaiDonHang(String trangThaiDonHang) { this.trangThaiDonHang = trangThaiDonHang; }

    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }
}
