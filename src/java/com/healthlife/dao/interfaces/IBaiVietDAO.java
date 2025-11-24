package com.healthlife.dao.interfaces;

import com.healthlife.model.BaiViet;
import java.util.List;

public interface IBaiVietDAO {
    List<BaiViet> getAll();
    BaiViet getById(int id);
    boolean add(BaiViet bv);
    boolean update(BaiViet bv);
    boolean delete(int id);
}