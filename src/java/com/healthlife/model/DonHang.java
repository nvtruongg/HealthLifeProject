/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author Nguyen Viet Truong
 */
public class DonHang {
    private int id;
    private int idNguoiDung;
    private String maDonHang;
    private String tenNguoiNhan;
    private String soDienThoaiNhan;
    private String diaChiGiaoHang;
    private String emailNguoiNhan;
    private LocalDateTime ngayDat;
    private BigDecimal tongTienSanPham;
    private BigDecimal phiVanChuyen;
    private BigDecimal tongThanhToan;
    private String phuongThucThanhToan;     // cod, chuyen_khoan, vnpay
    private String trangThaiThanhToan;      // chua_thanh_toan, da_thanh_toan
    private String trangThaiDonHang;        // cho_xac_nhan, da_xac_nhan, dang_giao, hoan_thanh, da_huy
    private String ghiChuKhachHang;

    public DonHang(int id, int idNguoiDung, String maDonHang, String tenNguoiNhan, String soDienThoaiNhan, String diaChiGiaoHang, String emailNguoiNhan, LocalDateTime ngayDat, BigDecimal tongTienSanPham, BigDecimal phiVanChuyen, BigDecimal tongThanhToan, String phuongThucThanhToan, String trangThaiThanhToan, String trangThaiDonHang, String ghiChuKhachHang) {
        this.id = id;
        this.idNguoiDung = idNguoiDung;
        this.maDonHang = maDonHang;
        this.tenNguoiNhan = tenNguoiNhan;
        this.soDienThoaiNhan = soDienThoaiNhan;
        this.diaChiGiaoHang = diaChiGiaoHang;
        this.emailNguoiNhan = emailNguoiNhan;
        this.ngayDat = ngayDat;
        this.tongTienSanPham = tongTienSanPham;
        this.phiVanChuyen = phiVanChuyen;
        this.tongThanhToan = tongThanhToan;
        this.phuongThucThanhToan = phuongThucThanhToan;
        this.trangThaiThanhToan = trangThaiThanhToan;
        this.trangThaiDonHang = trangThaiDonHang;
        this.ghiChuKhachHang = ghiChuKhachHang;
    }

    public DonHang() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdNguoiDung() {
        return idNguoiDung;
    }

    public void setIdNguoiDung(int idNguoiDung) {
        this.idNguoiDung = idNguoiDung;
    }

    public String getMaDonHang() {
        return maDonHang;
    }

    public void setMaDonHang(String maDonHang) {
        this.maDonHang = maDonHang;
    }

    public String getTenNguoiNhan() {
        return tenNguoiNhan;
    }

    public void setTenNguoiNhan(String tenNguoiNhan) {
        this.tenNguoiNhan = tenNguoiNhan;
    }

    public String getSoDienThoaiNhan() {
        return soDienThoaiNhan;
    }

    public void setSoDienThoaiNhan(String soDienThoaiNhan) {
        this.soDienThoaiNhan = soDienThoaiNhan;
    }

    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }

    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    public String getEmailNguoiNhan() {
        return emailNguoiNhan;
    }

    public void setEmailNguoiNhan(String emailNguoiNhan) {
        this.emailNguoiNhan = emailNguoiNhan;
    }

    public LocalDateTime getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(LocalDateTime ngayDat) {
        this.ngayDat = ngayDat;
    }

    public BigDecimal getTongTienSanPham() {
        return tongTienSanPham;
    }

    public void setTongTienSanPham(BigDecimal tongTienSanPham) {
        this.tongTienSanPham = tongTienSanPham;
    }

    public BigDecimal getPhiVanChuyen() {
        return phiVanChuyen;
    }

    public void setPhiVanChuyen(BigDecimal phiVanChuyen) {
        this.phiVanChuyen = phiVanChuyen;
    }

    public BigDecimal getTongThanhToan() {
        return tongThanhToan;
    }

    public void setTongThanhToan(BigDecimal tongThanhToan) {
        this.tongThanhToan = tongThanhToan;
    }

    public String getPhuongThucThanhToan() {
        return phuongThucThanhToan;
    }

    public void setPhuongThucThanhToan(String phuongThucThanhToan) {
        this.phuongThucThanhToan = phuongThucThanhToan;
    }

    public String getTrangThaiThanhToan() {
        return trangThaiThanhToan;
    }

    public void setTrangThaiThanhToan(String trangThaiThanhToan) {
        this.trangThaiThanhToan = trangThaiThanhToan;
    }

    public String getTrangThaiDonHang() {
        return trangThaiDonHang;
    }

    public void setTrangThaiDonHang(String trangThaiDonHang) {
        this.trangThaiDonHang = trangThaiDonHang;
    }

    public String getGhiChuKhachHang() {
        return ghiChuKhachHang;
    }

    public void setGhiChuKhachHang(String ghiChuKhachHang) {
        this.ghiChuKhachHang = ghiChuKhachHang;
    }
    
}
