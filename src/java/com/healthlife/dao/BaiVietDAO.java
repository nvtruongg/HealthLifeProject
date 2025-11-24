package com.healthlife.dao;

import com.healthlife.dao.interfaces.IBaiVietDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.BaiViet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BaiVietDAO implements IBaiVietDAO {

    @Override
    public List<BaiViet> getAll() {
        List<BaiViet> list = new ArrayList<>();
        // JOIN bảng nguoi_dung để lấy ho_ten người tạo
        String query = "SELECT bv.*, nd.ho_ten " +
                       "FROM bai_viet bv " +
                       "LEFT JOIN nguoi_dung nd ON bv.id_nguoi_tao = nd.id " +
                       "ORDER BY bv.ngay_dang DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BaiViet bv = mapResultSetToBaiViet(rs);
                bv.setTenNguoiTao(rs.getString("ho_ten"));
                list.add(bv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BaiViet getById(int id) {
        String query = "SELECT * FROM bai_viet WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBaiViet(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean add(BaiViet bv) {
        String query = "INSERT INTO bai_viet (tieu_de, tom_tat, noi_dung, hinh_anh_tieu_de, id_nguoi_tao, trang_thai) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, bv.getTieuDe());
            ps.setString(2, bv.getTomTat());
            ps.setString(3, bv.getNoiDung());
            ps.setString(4, bv.getHinhAnhTieuDe());
            ps.setInt(5, bv.getIdNguoiTao());
            ps.setString(6, bv.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(BaiViet bv) {
        String query = "UPDATE bai_viet SET tieu_de=?, tom_tat=?, noi_dung=?, hinh_anh_tieu_de=?, trang_thai=? WHERE id=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, bv.getTieuDe());
            ps.setString(2, bv.getTomTat());
            ps.setString(3, bv.getNoiDung());
            ps.setString(4, bv.getHinhAnhTieuDe());
            ps.setString(5, bv.getTrangThai());
            ps.setInt(6, bv.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String query = "DELETE FROM bai_viet WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private BaiViet mapResultSetToBaiViet(ResultSet rs) throws SQLException {
        BaiViet bv = new BaiViet();
        bv.setId(rs.getInt("id"));
        bv.setTieuDe(rs.getString("tieu_de"));
        bv.setTomTat(rs.getString("tom_tat"));
        bv.setNoiDung(rs.getString("noi_dung"));
        bv.setHinhAnhTieuDe(rs.getString("hinh_anh_tieu_de"));
        bv.setIdNguoiTao(rs.getInt("id_nguoi_tao"));
        bv.setNgayDang(rs.getTimestamp("ngay_dang"));
        bv.setTrangThai(rs.getString("trang_thai"));
        return bv;
    }
}