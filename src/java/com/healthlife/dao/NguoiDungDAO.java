package com.healthlife.dao;

import com.healthlife.dao.interfaces.INguoiDungDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.NguoiDung;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class NguoiDungDAO implements INguoiDungDAO {

    @Override
    public boolean addUser(NguoiDung user) {
        String sql = "INSERT INTO nguoi_dung(ho_ten, email, so_dien_thoai, mat_khau, vai_tro) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getSdt());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkUsernameExists(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public NguoiDung checkLogin(String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT * FROM nguoi_dung WHERE email=? AND mat_khau=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                NguoiDung u = new NguoiDung();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("mat_khau"));
                u.setRole(rs.getString("vai_tro"));
                u.setFullname(rs.getString("ho_ten"));
                u.setSdt(rs.getString("so_dien_thoai"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
