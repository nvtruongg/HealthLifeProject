package com.healthlife.model;

public class NguoiDung {
    private int id;
    private String email;
    private String password;
    private String role;
    private String fullname;
    private String sdt;

    public NguoiDung() {
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public NguoiDung( String email, String password, String role, String fullname,String sdt) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.fullname = fullname;
        this.sdt = sdt;
    }
    public NguoiDung( String email, String password, String role) {
        
        this.email = email;
        this.password = password;
        this.role = role; 
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    
    
    }
    

