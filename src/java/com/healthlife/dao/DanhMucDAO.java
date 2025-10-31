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
import java.util.List;

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
        String query = "select * from danh_muc";

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
                list.add(dm);
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
