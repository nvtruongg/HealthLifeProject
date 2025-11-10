package com.healthlife.service;

import com.healthlife.dao.interfaces.INguoiDungDAO;
import com.healthlife.dao.NguoiDungDAO;
import com.healthlife.model.NguoiDung;
import com.healthlife.service.INguoiDungService;

public class NguoiDungService implements INguoiDungService {
    
    private final INguoiDungDAO nguoiDungDAO;

    public NguoiDungService() {
        this.nguoiDungDAO = new NguoiDungDAO();
    }

    @Override
    public boolean registerUser(NguoiDung user) {
        if (isEmailExist(user.getEmail())) {
            return false;
        }
        return nguoiDungDAO.addUser(user);
    }

    @Override
    public boolean isEmailExist(String email) {
        return nguoiDungDAO.checkUsernameExists(email);
    }

    @Override
    public NguoiDung loginUser(String email, String password) {
        return ((NguoiDungDAO) nguoiDungDAO).checkLogin(email, password); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
