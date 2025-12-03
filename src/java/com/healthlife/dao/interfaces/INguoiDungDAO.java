package com.healthlife.dao.interfaces;

import com.healthlife.model.NguoiDung;
import java.util.List;

public interface INguoiDungDAO {
    // Các phương thức cũ (Login/Register)
    NguoiDung checkLogin(String email, String password);
    boolean checkUsernameExists(String email);
    boolean addUser(NguoiDung user);

    List<NguoiDung> getAllUsers();
    NguoiDung getUserById(int id);
    boolean updateUser(NguoiDung user); // Dùng để sửa role, status, info
    boolean deleteUser(int id);
     boolean updatePasswordByEmail(String email, String newPassword);
}