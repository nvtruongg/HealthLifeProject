package com.healthlife.model;

import java.math.BigDecimal;

public class ChiTietDonHang {
    private int id;
    private int idDonHang;
    private int idSanPham;
    private int soLuong;
    private BigDecimal giaLucMua;
    private BigDecimal thanhTien;
    
    // Thuộc tính bổ sung để hiển thị tên sản phẩm và ảnh (khi JOIN bảng san_pham)
    private String tenSanPham;
    private String hinhAnhSanPham;

    public ChiTietDonHang() {
    }

    public ChiTietDonHang(int id, int idDonHang, int idSanPham, int soLuong, BigDecimal giaLucMua, BigDecimal thanhTien) {
        this.id = id;
        this.idDonHang = idDonHang;
        this.idSanPham = idSanPham;
        this.soLuong = soLuong;
        this.giaLucMua = giaLucMua;
        this.thanhTien = thanhTien;
    }

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdDonHang() { return idDonHang; }
    public void setIdDonHang(int idDonHang) { this.idDonHang = idDonHang; }

    public int getIdSanPham() { return idSanPham; }
    public void setIdSanPham(int idSanPham) { this.idSanPham = idSanPham; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public BigDecimal getGiaLucMua() { return giaLucMua; }
    public void setGiaLucMua(BigDecimal giaLucMua) { this.giaLucMua = giaLucMua; }

    public BigDecimal getThanhTien() { return thanhTien; }
    public void setThanhTien(BigDecimal thanhTien) { this.thanhTien = thanhTien; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public String getHinhAnhSanPham() { return hinhAnhSanPham; }
    public void setHinhAnhSanPham(String hinhAnhSanPham) { this.hinhAnhSanPham = hinhAnhSanPham; }
}