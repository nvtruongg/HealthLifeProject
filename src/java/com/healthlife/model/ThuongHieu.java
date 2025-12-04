package com.healthlife.model;

/**
 * Model (Java Bean) đại diện cho bảng 'thuong_hieu'.
 */
public class ThuongHieu {
    private int id;
    private String tenThuongHieu;
    private String xuatXu;
    private String hinhAnhLogo; // Có thể NULL
    private String moTa;        // Có thể NULL

    public ThuongHieu() {
    }

    public ThuongHieu(int id, String tenThuongHieu, String xuatXu, String hinhAnhLogo, String moTa) {
        this.id = id;
        this.tenThuongHieu = tenThuongHieu;
        this.xuatXu = xuatXu;
        this.hinhAnhLogo = hinhAnhLogo;
        this.moTa = moTa;
    }

    // --- Getters and Setters ---
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenThuongHieu() {
        return tenThuongHieu;
    }

    public void setTenThuongHieu(String tenThuongHieu) {
        this.tenThuongHieu = tenThuongHieu;
    }

    public String getXuatXu() {
        return xuatXu;
    }

    public void setXuatXu(String xuatXu) {
        this.xuatXu = xuatXu;
    }

    public String getHinhAnhLogo() {
        return hinhAnhLogo;
    }

    public void setHinhAnhLogo(String hinhAnhLogo) {
        this.hinhAnhLogo = hinhAnhLogo;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
}