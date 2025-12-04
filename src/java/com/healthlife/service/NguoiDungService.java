package com.healthlife.service;

import com.healthlife.dao.interfaces.INguoiDungDAO;
import com.healthlife.dao.NguoiDungDAO;
import com.healthlife.model.NguoiDung;
import com.healthlife.service.INguoiDungService;
import java.util.List;

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

    @Override
    public boolean addUser(NguoiDung user) {
          // Kiểm tra email trùng lặp trước khi thêm
        if (nguoiDungDAO.checkUsernameExists(user.getEmail())) {
            return false; 
        }
        return nguoiDungDAO.addUser(user);
    }

    @Override
    public boolean updateUser(NguoiDung user) {
        return nguoiDungDAO.updateUser(user);
    }

    @Override
    public boolean deleteUser(int id) {
        return nguoiDungDAO.deleteUser(id);
    }

    @Override
    public List<NguoiDung> getAllUsers() {
        return nguoiDungDAO.getAllUsers();
    }

    @Override
    public NguoiDung getUserById(int id) {
        return nguoiDungDAO.getUserById(id);
    }

    @Override
    public boolean updatePasswordByEmail(String email, String newPassword) {
        return nguoiDungDAO.updatePasswordByEmail(email, newPassword);
    }
}
