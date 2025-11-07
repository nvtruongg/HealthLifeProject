package com.healthlife.dao.interfaces;

import com.healthlife.model.NguoiDung;

public interface INguoiDungDAO {
    boolean addUser(NguoiDung user);
    boolean checkUsernameExists(String email);
    NguoiDung checkLogin(String email, String password);
}
