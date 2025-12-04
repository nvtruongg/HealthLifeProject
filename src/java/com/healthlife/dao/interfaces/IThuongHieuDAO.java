package com.healthlife.dao.interfaces;

import com.healthlife.model.ThuongHieu;
import java.util.List;

/**
 * Interface cho ThuongHieu DAO.
 */
public interface IThuongHieuDAO {
    List<ThuongHieu> getAll();
    ThuongHieu getById(int id);
    boolean add(ThuongHieu thuongHieu);
    boolean update(ThuongHieu thuongHieu);
    boolean delete(int id);
}