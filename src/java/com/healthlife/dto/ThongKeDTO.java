package com.healthlife.dto;

public class ThongKeDTO {
    private String nhan;   // Ví dụ: "Tháng 1", "Đang giao"
    private double giaTri; // Ví dụ: 15000000, 12

    public ThongKeDTO(String nhan, double giaTri) {
        this.nhan = nhan;
        this.giaTri = giaTri;
    }

    public String getNhan() { return nhan; }
    public void setNhan(String nhan) { this.nhan = nhan; }
    public double getGiaTri() { return giaTri; }
    public void setGiaTri(double giaTri) { this.giaTri = giaTri; }
}