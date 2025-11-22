package com.healthlife.model;

import java.sql.Timestamp;

public class BaiViet {
    private int id;
    private String tieuDe;
    private String tomTat;
    private String noiDung;
    private String hinhAnhTieuDe;
    private int idNguoiTao;
    private Timestamp ngayDang;
    private String trangThai; // 'nhap', 'xuat_ban'

    // Thuộc tính bổ sung để hiển thị tên người tạo (JOIN bảng nguoi_dung)
    private String tenNguoiTao;

    public BaiViet() {
    }

    public BaiViet(int id, String tieuDe, String tomTat, String noiDung, String hinhAnhTieuDe, int idNguoiTao, Timestamp ngayDang, String trangThai) {
        this.id = id;
        this.tieuDe = tieuDe;
        this.tomTat = tomTat;
        this.noiDung = noiDung;
        this.hinhAnhTieuDe = hinhAnhTieuDe;
        this.idNguoiTao = idNguoiTao;
        this.ngayDang = ngayDang;
        this.trangThai = trangThai;
    }

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }

    public String getTomTat() { return tomTat; }
    public void setTomTat(String tomTat) { this.tomTat = tomTat; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public String getHinhAnhTieuDe() { return hinhAnhTieuDe; }
    public void setHinhAnhTieuDe(String hinhAnhTieuDe) { this.hinhAnhTieuDe = hinhAnhTieuDe; }

    public int getIdNguoiTao() { return idNguoiTao; }
    public void setIdNguoiTao(int idNguoiTao) { this.idNguoiTao = idNguoiTao; }

    public Timestamp getNgayDang() { return ngayDang; }
    public void setNgayDang(Timestamp ngayDang) { this.ngayDang = ngayDang; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public String getTenNguoiTao() { return tenNguoiTao; }
    public void setTenNguoiTao(String tenNguoiTao) { this.tenNguoiTao = tenNguoiTao; }
}