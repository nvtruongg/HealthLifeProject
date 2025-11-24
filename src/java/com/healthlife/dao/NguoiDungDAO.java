package com.healthlife.dao;

import com.healthlife.dao.interfaces.INguoiDungDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.NguoiDung;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO implements INguoiDungDAO {

    @Override
    public NguoiDung checkLogin(String email, String password) {
        String query = "SELECT * FROM nguoi_dung WHERE email=? AND mat_khau=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean checkUsernameExists(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean addUser(NguoiDung user) {
        String sql = "INSERT INTO nguoi_dung(ho_ten, email, so_dien_thoai, mat_khau, vai_tro, trang_thai) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getSdt());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            // Mặc định là 'hoat_dong' nếu null
            ps.setString(6, user.getStatus() != null ? user.getStatus() : "hoat_dong");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // --- CÁC PHƯƠNG THỨC QUẢN LÝ ---

    @Override
    public List<NguoiDung> getAllUsers() {
        List<NguoiDung> list = new ArrayList<>();
        String query = "SELECT * FROM nguoi_dung";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public NguoiDung getUserById(int id) {
        String query = "SELECT * FROM nguoi_dung WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateUser(NguoiDung user) {
        // Cập nhật: Tên, SĐT, Vai trò, Trạng thái VÀ EMAIL
        String sql = "UPDATE nguoi_dung SET ho_ten=?, so_dien_thoai=?, vai_tro=?, trang_thai=?, email=? WHERE id=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getSdt());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getStatus());
            ps.setString(5, user.getEmail()); // Cập nhật email
            ps.setInt(6, user.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM nguoi_dung WHERE id=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm map dữ liệu từ ResultSet vào Model
    private NguoiDung mapResultSetToUser(ResultSet rs) throws SQLException {
        NguoiDung u = new NguoiDung();
        u.setId(rs.getInt("id"));
        u.setFullname(rs.getString("ho_ten")); 
        u.setEmail(rs.getString("email"));
        u.setSdt(rs.getString("so_dien_thoai")); 
        u.setPassword(rs.getString("mat_khau"));
        u.setRole(rs.getString("vai_tro"));
        
        // Map thêm 2 trường mới
        u.setStatus(rs.getString("trang_thai"));
        u.setCreatedAt(rs.getTimestamp("ngay_tao"));
        return u;
    }
}