/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.model;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 *
 * @author Nguyen Viet Truong
 */
//Đối tượng này được luu trong session
public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }
    public void themSanPham(SanPham sp, int soLuong){
        int idSanPham = sp.getId();
        if(items.containsKey(idSanPham)){
            //Cập nhập số lượng
            CartItem item = items.get(idSanPham);
            item.setSoLuong(item.getSoLuong() + soLuong);
            item.setSelected(true);
        } else{
            //Sản phẩm chưa có -> thêm mới
            CartItem newItem = new CartItem(sp, soLuong);
            items.put(idSanPham, newItem);
        }
    }
    //Cập nhật số lượng
    public void capNhatSoLuong(int idSanPham, int soLuong) {
        if (items.containsKey(idSanPham) && soLuong > 0) {
            CartItem item = items.get(idSanPham);
            item.setSoLuong(soLuong);
        } else if (soLuong <= 0) {
            xoaSanPham(idSanPham);
        }
    }
    
    //Xóa sản phẩm khỏi giỏ
    public void xoaSanPham(int idSanPham) {
        items.remove(idSanPham);
    }
    
    /**
     * Bật/Tắt trạng thái "chọn" của 1 sản phẩm
     */
    public void toggleItemSelected(int idSanPham) {
        if (items.containsKey(idSanPham)) {
            CartItem item = items.get(idSanPham);
            item.setSelected(!item.isSelected());
        }
    }
    
    /**
     * Lấy TẤT CẢ sản phẩm trong giỏ (dùng cho /cart-view)
     */
    public Map<Integer, CartItem> getAllItems() {
        return items;
    }
    
    /**
     * Lấy CHỈ CÁC sản phẩm ĐÃ CHỌN (dùng cho /checkout)
     */
    public Map<Integer, CartItem> getSelectedItems() {
        return items.entrySet().stream()
                .filter(entry -> entry.getValue().isSelected())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
    
    /**
     * Lấy tổng số lượng các món hàng ĐÃ CHỌN
     */
    public int getTongSoLuongItemsDaChon() {
        return items.values().stream()
                .filter(CartItem::isSelected)
                .mapToInt(CartItem::getSoLuong)
                .sum();
    }
    
    /**
     * Tính tổng tiền của các món hàng ĐÃ CHỌN
     */
    public BigDecimal getTongTienHangDaChon() {
        return items.values().stream()
                .filter(CartItem::isSelected)
                .map(CartItem::getTongTien)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    /**
     * Lấy tổng số lượng tất cả món hàng (dùng cho icon navbar)
     */
    public int getTongSoLuongTatCaItems() {
        return items.values().stream().mapToInt(CartItem::getSoLuong).sum();
    }
    /**
     * Chọn hoặc Bỏ chọn tất cả sản phẩm
     * @param select true = chọn hết, false = bỏ chọn hết
     */
    public void setAllSelected(boolean select) {
        for (CartItem item : items.values()) {
            item.setSelected(select);
        }
    }
    
    /**
     * Kiểm tra xem có phải tất cả đang được chọn không
     */
    public boolean isAllSelected() {
        if (items.isEmpty()) return false;
        for (CartItem item : items.values()) {
            if (!item.isSelected()) return false;
        }
        return true;
    }
}
