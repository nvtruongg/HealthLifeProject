package com.healthlife.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class SanPham {
    private int id;
    private String maSanPham;
    private String tenSanPham;
    private int idDanhMuc;
    private int idThuongHieu;
    private String moTaNgan;
    private String moTaChiTiet;
    private BigDecimal giaGoc;
    private BigDecimal giaBan;
    private int soLuongTon;
    private String donViTinh;
    private String hinhAnhDaiDien;
    private String thanhPhan;
    private String congDung;
    private String lieuDungCachDung;
    private String baoQuan;
    private String trangThai; // 'dang_kinh_doanh', 'ngung_kinh_doanh'
    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Thuộc tính bổ sung để hiển thị tên (JOIN bảng)
    private String tenDanhMuc;
    private String tenThuongHieu;

    public SanPham() {
    }

    // Constructor đầy đủ
    public SanPham(int id, String maSanPham, String tenSanPham, int idDanhMuc, int idThuongHieu, String moTaNgan, String moTaChiTiet, BigDecimal giaGoc, BigDecimal giaBan, int soLuongTon, String donViTinh, String hinhAnhDaiDien, String thanhPhan, String congDung, String lieuDungCachDung, String baoQuan, String trangThai, Timestamp ngayTao, Timestamp ngayCapNhat) {
        this.id = id;
        this.maSanPham = maSanPham;
        this.tenSanPham = tenSanPham;
        this.idDanhMuc = idDanhMuc;
        this.idThuongHieu = idThuongHieu;
        this.moTaNgan = moTaNgan;
        this.moTaChiTiet = moTaChiTiet;
        this.giaGoc = giaGoc;
        this.giaBan = giaBan;
        this.soLuongTon = soLuongTon;
        this.donViTinh = donViTinh;
        this.hinhAnhDaiDien = hinhAnhDaiDien;
        this.thanhPhan = thanhPhan;
        this.congDung = congDung;
        this.lieuDungCachDung = lieuDungCachDung;
        this.baoQuan = baoQuan;
        this.trangThai = trangThai;
        this.ngayTao = ngayTao;
        this.ngayCapNhat = ngayCapNhat;
    }

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMaSanPham() { return maSanPham; }
    public void setMaSanPham(String maSanPham) { this.maSanPham = maSanPham; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public int getIdDanhMuc() { return idDanhMuc; }
    public void setIdDanhMuc(int idDanhMuc) { this.idDanhMuc = idDanhMuc; }

    public int getIdThuongHieu() { return idThuongHieu; }
    public void setIdThuongHieu(int idThuongHieu) { this.idThuongHieu = idThuongHieu; }

    public String getMoTaNgan() { return moTaNgan; }
    public void setMoTaNgan(String moTaNgan) { this.moTaNgan = moTaNgan; }

    public String getMoTaChiTiet() { return moTaChiTiet; }
    public void setMoTaChiTiet(String moTaChiTiet) { this.moTaChiTiet = moTaChiTiet; }

    public BigDecimal getGiaGoc() { return giaGoc; }
    public void setGiaGoc(BigDecimal giaGoc) { this.giaGoc = giaGoc; }

    public BigDecimal getGiaBan() { return giaBan; }
    public void setGiaBan(BigDecimal giaBan) { this.giaBan = giaBan; }

    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }

    public String getDonViTinh() { return donViTinh; }
    public void setDonViTinh(String donViTinh) { this.donViTinh = donViTinh; }

    public String getHinhAnhDaiDien() { return hinhAnhDaiDien; }
    public void setHinhAnhDaiDien(String hinhAnhDaiDien) { this.hinhAnhDaiDien = hinhAnhDaiDien; }

    public String getThanhPhan() { return thanhPhan; }
    public void setThanhPhan(String thanhPhan) { this.thanhPhan = thanhPhan; }

    public String getCongDung() { return congDung; }
    public void setCongDung(String congDung) { this.congDung = congDung; }

    public String getLieuDungCachDung() { return lieuDungCachDung; }
    public void setLieuDungCachDung(String lieuDungCachDung) { this.lieuDungCachDung = lieuDungCachDung; }

    public String getBaoQuan() { return baoQuan; }
    public void setBaoQuan(String baoQuan) { this.baoQuan = baoQuan; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public String getTenDanhMuc() { return tenDanhMuc; }
    public void setTenDanhMuc(String tenDanhMuc) { this.tenDanhMuc = tenDanhMuc; }

    public String getTenThuongHieu() { return tenThuongHieu; }
    public void setTenThuongHieu(String tenThuongHieu) { this.tenThuongHieu = tenThuongHieu; }
}