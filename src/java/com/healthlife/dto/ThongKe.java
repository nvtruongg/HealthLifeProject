package com.healthlife.dto;

public class ThongKe {
    private String nhan; // Ví dụ: "Tháng 1", "Đã giao"
    private double giaTri; // Ví dụ: 10000000, 5

    public ThongKe(String nhan, double giaTri) {
        this.nhan = nhan;
        this.giaTri = giaTri;
    }

    public String getNhan() { return nhan; }
    public void setNhan(String nhan) { this.nhan = nhan; }
    public double getGiaTri() { return giaTri; }
    public void setGiaTri(double giaTri) { this.giaTri = giaTri; }
}