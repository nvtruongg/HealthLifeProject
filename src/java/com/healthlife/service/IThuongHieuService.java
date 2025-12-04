package com.healthlife.service;

import com.healthlife.model.ThuongHieu;
import java.util.List;


public interface IThuongHieuService {
    List<ThuongHieu> getAll();
    ThuongHieu getById(int id);
    boolean add(ThuongHieu thuongHieu);
    boolean update(ThuongHieu thuongHieu);
    boolean delete(int id);
}