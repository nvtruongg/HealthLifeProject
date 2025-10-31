/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.model;

/**
 *
 * @author Nguyen Viet Truong
 */
public class DanhMuc {
    private int id;
    private String tenDanhMuc;
    private int idDanhMucCha;
    private String hinhAnh;
    private String moTa;

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

    public int getIdDanhMucCha() {
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
    
    
}
