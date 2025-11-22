package com.healthlife.service;

import com.healthlife.dao.BaiVietDAO;
import com.healthlife.dao.interfaces.IBaiVietDAO;
import com.healthlife.model.BaiViet;
import java.util.List;

public class BaiVietService implements IBaiVietService {
    
    private IBaiVietDAO baiVietDAO;

    public BaiVietService() {
        this.baiVietDAO = new BaiVietDAO();
    }

    @Override
    public List<BaiViet> getAll() {
        return baiVietDAO.getAll();
    }

    @Override
    public BaiViet getById(int id) {
        return baiVietDAO.getById(id);
    }

    @Override
    public boolean add(BaiViet bv) {
        return baiVietDAO.add(bv);
    }

    @Override
    public boolean update(BaiViet bv) {
        return baiVietDAO.update(bv);
    }

    @Override
    public boolean delete(int id) {
        return baiVietDAO.delete(id);
    }
}