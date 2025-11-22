package com.healthlife.service;



import com.healthlife.dao.ThuongHieuDAO;
import com.healthlife.dao.interfaces.IThuongHieuDAO;
import com.healthlife.model.ThuongHieu;
import java.util.List;

/**
 * Triển khai logic nghiệp vụ cho Thương hiệu.
 */
public class ThuongHieuService implements IThuongHieuService {
    
    private IThuongHieuDAO thuongHieuDAO;

    public ThuongHieuService() {
        this.thuongHieuDAO = (IThuongHieuDAO) new ThuongHieuDAO();
    }

    @Override
    public List<ThuongHieu> getAll() {
        return thuongHieuDAO.getAll();
    }

    @Override
    public ThuongHieu getById(int id) {
        return thuongHieuDAO.getById(id);
    }

    @Override
    public boolean add(ThuongHieu th) {
        // Logic nghiệp vụ: Tên và xuất xứ không được trống
        if (th.getTenThuongHieu() == null || th.getTenThuongHieu().trim().isEmpty() ||
            th.getXuatXu() == null || th.getXuatXu().trim().isEmpty()) {
            System.out.println("SERVICE: Tên hoặc Xuất xứ không được để trống.");
            return false;
        }
        return thuongHieuDAO.add(th);
    }

    @Override
    public boolean update(ThuongHieu th) {
        // Logic nghiệp vụ: Tên và xuất xứ không được trống
        if (th.getTenThuongHieu() == null || th.getTenThuongHieu().trim().isEmpty() ||
            th.getXuatXu() == null || th.getXuatXu().trim().isEmpty()) {
            System.out.println("SERVICE: Tên hoặc Xuất xứ không được để trống.");
            return false;
        }
        return thuongHieuDAO.update(th);
    }

    @Override
    public boolean delete(int id) {
        // (Có thể kiểm tra ràng buộc sản phẩm tại đây)
        return thuongHieuDAO.delete(id);
    }
}