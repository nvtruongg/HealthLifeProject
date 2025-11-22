package com.healthlife.model;

import java.sql.Timestamp;

public class NguoiDung {
    private int id;
    private String email;
    private String password;
    private String role;
    private String fullname;
    private String sdt;
    // --- THÊM MỚI CHO KHỚP VỚI CSDL ---
    private String status; // Cột: trang_thai
    private Timestamp createdAt; // Cột: ngay_tao

    public NguoiDung() {
    }

    // Constructor đầy đủ (dùng khi lấy từ CSDL ra)
    public NguoiDung(int id, String fullname, String email, String sdt, String password, String role, String status, Timestamp createdAt) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.sdt = sdt;
        this.password = password;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Constructor cho việc tạo mới (không có ID và ngày tạo)
    public NguoiDung(String email, String password, String role, String fullname, String sdt, String status) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.fullname = fullname;
        this.sdt = sdt;
        this.status = status;
    }

    // Constructor cũ của bạn (giữ lại để không lỗi code cũ nếu có)
    public NguoiDung(String email, String password, String role, String fullname, String sdt) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.fullname = fullname;
        this.sdt = sdt;
    }

    public NguoiDung(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role; 
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}