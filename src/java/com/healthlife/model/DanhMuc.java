/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.model;

import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
public class DanhMuc {
    private int id;
    private String tenDanhMuc;
    private Integer idDanhMucCha;
    private String hinhAnh;
    private String moTa;
    private List<DanhMuc> danhMucCon;
    
    public DanhMuc() {
    }

    public DanhMuc(int id, String tenDanhMuc, int idDanhMucCha, String hinhAnh, String moTa) {
        this.id = id;
        this.tenDanhMuc = tenDanhMuc;
        this.idDanhMucCha = idDanhMucCha;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
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

    public Integer getIdDanhMucCha() {
        return idDanhMucCha;
    }

    public void setIdDanhMucCha(int idDanhMucCha) {
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
    
    public List<DanhMuc> getDanhMucCon() {
        return danhMucCon;
    }

    public void setDanhMucCon(List<DanhMuc> danhMucCon) {
        this.danhMucCon = danhMucCon;
    }
}
