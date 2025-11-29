package com.healthlife.dto;

public class TopSanPhamDTO {
    private String tenSanPham;
    private int soLuongBan;
    private double doanhThu;

    public TopSanPhamDTO(String tenSanPham, int soLuongBan, double doanhThu) {
        this.tenSanPham = tenSanPham;
        this.soLuongBan = soLuongBan;
        this.doanhThu = doanhThu;
    }

    public String getTenSanPham() { return tenSanPham; }
    public int getSoLuongBan() { return soLuongBan; }
    public double getDoanhThu() { return doanhThu; }
}