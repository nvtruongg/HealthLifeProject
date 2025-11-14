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
//Lớp này không phải là bảng CSDL, mà là 1 đối tượng trong giỏ hàng
public class CartItem {
    private SanPham sanPham;
    private int soLuong;
    private boolean selected;

    public SanPham getSanPham() {
        return sanPham;
    }

    public BigDecimal getTongTien(){
        return this.sanPham.getGiaBan().multiply(new BigDecimal(soLuong));
    }
    public void setSanPham(SanPham sanPham) {
        this.sanPham = sanPham;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public CartItem(SanPham sanPham, int soLuong) {
        this.sanPham = sanPham;
        this.soLuong = soLuong;
        this.selected = true;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }
}
