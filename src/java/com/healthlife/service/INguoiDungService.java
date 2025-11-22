package com.healthlife.service;

import com.healthlife.model.NguoiDung;
import java.util.List;

public interface INguoiDungService {
    boolean registerUser(NguoiDung user);
    boolean isEmailExist(String email);
     NguoiDung loginUser(String email, String password);
     List<NguoiDung> getAllUsers();
    NguoiDung getUserById(int id);
    boolean addUser(NguoiDung user);
    boolean updateUser(NguoiDung user);
    boolean deleteUser(int id);
}
