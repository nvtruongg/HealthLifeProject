package com.healthlife.dao;

import com.healthlife.dao.interfaces.IDanhMucDAO;
import com.healthlife.db.DBContext;
import com.healthlife.model.DanhMuc;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * Triển khai (implements) từ IDanhMucDAO.
 * Đã đổi tên từ CategoryDAO
 */
public class DanhMucDAO implements IDanhMucDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    @Override
    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> list = new ArrayList<>();
        Map<Integer, DanhMuc> map = new HashMap<>();
        String query = "SELECT * FROM danh_muc ORDER BY id_danh_muc_cha ASC, ten_danh_muc DESC";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
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
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách danh mục: " + e.getMessage());
        } finally {
            closeResources();
        }
        return list;
    }
    
    @Override
    public boolean addCategory(String ten, String moTa, Integer idCha) {
        String query = "INSERT INTO danh_muc (ten_danh_muc, mo_ta, id_danh_muc_cha) VALUES (?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten);
            ps.setString(2, moTa);
            if (idCha != null && idCha == 0) {
                 ps.setNull(3, java.sql.Types.INTEGER);
            } else {
                 ps.setObject(3, idCha);
            }
           
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm danh mục: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    @Override
    public boolean deleteCategory(int id) {
        String query = "DELETE FROM danh_muc WHERE id = ?";
        try {
             conn = new DBContext().getConnection();
             ps = conn.prepareStatement(query);
             ps.setInt(1, id);
             int result = ps.executeUpdate();
             return result > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa danh mục: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    // --- THÊM MỚI ---

    @Override
    public DanhMuc getCategoryById(int id) {
        String query = "SELECT * FROM danh_muc WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new DanhMuc(
                        rs.getInt("id"),
                        rs.getString("ten_danh_muc"),
                        rs.getObject("id_danh_muc_cha", Integer.class),
                        rs.getString("hinh_anh"),
                        rs.getString("mo_ta")
                );
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh mục theo ID: " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    @Override
    public boolean updateCategory(DanhMuc danhMuc) {
        String query = "UPDATE danh_muc SET ten_danh_muc = ?, mo_ta = ?, id_danh_muc_cha = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, danhMuc.getTenDanhMuc());
            ps.setString(2, danhMuc.getMoTa());
            if (danhMuc.getIdDanhMucCha() != null && danhMuc.getIdDanhMucCha() == 0) {
                ps.setNull(3, java.sql.Types.INTEGER);
            } else {
                ps.setObject(3, danhMuc.getIdDanhMucCha());
            }
            ps.setInt(4, danhMuc.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật danh mục: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            System.out.println("Lỗi khi đóng tài nguyên CSDL: " + e.getMessage());
        }
    }
}