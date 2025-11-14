/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.healthlife.dao;

import com.healthlife.dao.interfaces.IDanhMucDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.DanhMuc;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Nguyen Viet Truong
 */
public class DanhMucDAO implements IDanhMucDAO{

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = null;

    @Override
    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> list = new ArrayList<>();
        Map<Integer, DanhMuc> map = new HashMap<>();
        String query = "SELECT * FROM danh_muc ORDER BY id_danh_muc_cha ASC, ten_danh_muc DESC";

        try {
            connection = DBContext.getConnection();
            
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                DanhMuc dm = new DanhMuc();
                dm.setId(rs.getInt("id"));
                dm.setTenDanhMuc(rs.getString("ten_danh_muc"));
                dm.setIdDanhMucCha(rs.getInt("id_danh_muc_cha"));
                dm.setHinhAnh(rs.getString("hinh_anh"));
                dm.setMoTa(rs.getString("mo_ta"));
                dm.setDanhMucCon(new ArrayList<>());
                list.add(dm);
                map.put(dm.getId(), dm);
            }
            
            List<DanhMuc> dmP = new ArrayList<>();
            for(DanhMuc dm : list){
                if(dm.getIdDanhMucCha() == null){
                    dmP.add(dm);
                }else{
                    DanhMuc parent = map.get(dm.getIdDanhMucCha());
                    if(parent != null){
                        parent.getDanhMucCon().add(dm);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}
