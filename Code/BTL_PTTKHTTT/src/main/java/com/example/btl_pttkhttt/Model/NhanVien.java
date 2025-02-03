package com.example.btl_pttkhttt.Model;

import java.sql.Date;

public class NhanVien {
    private int id;
    private String name;
    private String username;
    private String password;
    private Date birth;
    private String phone;
    private String email;

    public NhanVien() {
    }

    public NhanVien(int id, String name, String username, String password, Date birth, String phone, String email) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.birth = birth;
        this.phone = phone;
        this.email = email;
    }

    public NhanVien(String name, String username, String password, Date birth, String phone, String email) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.birth = birth;
        this.phone = phone;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public enum Role {
        QUANLY, KHO
    }

    @Override
    public String toString() {
        return "NhanVien{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", birth=" + birth +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
