package com.healthlife.service;

import com.healthlife.model.NguoiDung;

public interface INguoiDungService {
    boolean registerUser(NguoiDung user);
    boolean isEmailExist(String email);
     NguoiDung loginUser(String email, String password);
}
