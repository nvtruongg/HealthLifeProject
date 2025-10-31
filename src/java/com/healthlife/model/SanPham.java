/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.model;

import java.math.BigDecimal;

/**
 *
 * @author Nguyen Viet Truong
 */
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

    public SanPham() {
    }

    public SanPham(int id, String maSanPham, String tenSanPham, int idDanhMuc, int idThuongHieu, String moTaNgan, String moTaChiTiet, BigDecimal giaGoc, BigDecimal giaBan, int soLuongTon, String donViTinh, String hinhAnhDaiDien) {
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
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaSanPham() {
        return maSanPham;
    }

    public void setMaSanPham(String maSanPham) {
        this.maSanPham = maSanPham;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public int getIdDanhMuc() {
        return idDanhMuc;
    }

    public void setIdDanhMuc(int idDanhMuc) {
        this.idDanhMuc = idDanhMuc;
    }

    public int getIdThuongHieu() {
        return idThuongHieu;
    }

    public void setIdThuongHieu(int idThuongHieu) {
        this.idThuongHieu = idThuongHieu;
    }

    public String getMoTaNgan() {
        return moTaNgan;
    }

    public void setMoTaNgan(String moTaNgan) {
        this.moTaNgan = moTaNgan;
    }

    public String getMoTaChiTiet() {
        return moTaChiTiet;
    }

    public void setMoTaChiTiet(String moTaChiTiet) {
        this.moTaChiTiet = moTaChiTiet;
    }

    public BigDecimal getGiaGoc() {
        return giaGoc;
    }

    public void setGiaGoc(BigDecimal giaGoc) {
        this.giaGoc = giaGoc;
    }

    public BigDecimal getGiaBan() {
        return giaBan;
    }

    public void setGiaBan(BigDecimal giaBan) {
        this.giaBan = giaBan;
    }

    public int getSoLuongTon() {
        return soLuongTon;
    }

    public void setSoLuongTon(int soLuongTon) {
        this.soLuongTon = soLuongTon;
    }

    public String getDonViTinh() {
        return donViTinh;
    }

    public void setDonViTinh(String donViTinh) {
        this.donViTinh = donViTinh;
    }

    public String getHinhAnhDaiDien() {
        return hinhAnhDaiDien;
    }

    public void setHinhAnhDaiDien(String hinhAnhDaiDien) {
        this.hinhAnhDaiDien = hinhAnhDaiDien;
    }
    
    @Override
    public String toString() {
        return "SanPham{" + "id=" + id + ", tenSanPham=" + tenSanPham + ", giaBan=" + giaBan + '}';
    }
}
