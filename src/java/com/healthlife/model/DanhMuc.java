package com.healthlife.model;

import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 * Cập nhật để sử dụng Integer cho idDanhMucCha (hỗ trợ NULL)
 */
public class DanhMuc {
    private int id;
    private String tenDanhMuc;
    private Integer idDanhMucCha; // SỬ DỤNG INTEGER ĐỂ HỖ TRỢ NULL TỪ CSDL
    private String hinhAnh;
    private String moTa;
    
    // Trường cho danh mục con (như bạn đã thêm)
    private List<DanhMuc> danhMucCon;

    public DanhMuc() {
    }

    // Constructor đã cập nhật để chấp nhận Integer
    public DanhMuc(int id, String tenDanhMuc, Integer idDanhMucCha, String hinhAnh, String moTa) {
        this.id = id;
        this.tenDanhMuc = tenDanhMuc;
        this.idDanhMucCha = idDanhMucCha;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    // --- Getters and Setters ---
    
    public List<DanhMuc> getDanhMucCon() {
        return danhMucCon;
    }

    public void setDanhMucCon(List<DanhMuc> danhMucCon) {
        this.danhMucCon = danhMucCon;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    // Getter/Setter đã cập nhật cho Integer
    public Integer getIdDanhMucCha() {
        return idDanhMucCha;
    }

    public void setIdDanhMucCha(Integer idDanhMucCha) {
        this.idDanhMucCha = idDanhMucCha;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
}
