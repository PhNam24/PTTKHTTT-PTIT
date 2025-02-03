package com.example.btl_pttkhttt.Model;

import java.util.ArrayList;

public class NhaCungCap {
    private int id;
    private String name;
    private String address;
    private String phone;
    private String email;
    private float rate = 5;
    private String note = "";
    private ArrayList<TaiKhoanNganHang> listTaiKhoanNganHang;

    public NhaCungCap() {
        listTaiKhoanNganHang = new ArrayList<>();
    }

    public NhaCungCap(int id, String name, String address, String phone, String email, float rate, String note) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.rate = rate;
        this.note = note;
        listTaiKhoanNganHang = new ArrayList<>();
    }

    public NhaCungCap(String name, String address, String phone, String email, float rate, String note) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.rate = rate;
        this.note = note;
        listTaiKhoanNganHang = new ArrayList<>();
    }

    public NhaCungCap(String name, String address, String phone, String email) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        listTaiKhoanNganHang = new ArrayList<>();
    }

    public void addTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang) {
        listTaiKhoanNganHang.add(taiKhoanNganHang);
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ArrayList<TaiKhoanNganHang> getListTaiKhoanNganHang() {
        return listTaiKhoanNganHang;
    }

    public void setListTaiKhoanNganHang(ArrayList<TaiKhoanNganHang> listTaiKhoanNganHang) {
        this.listTaiKhoanNganHang = listTaiKhoanNganHang;
    }

    @Override
    public String toString() {
        return "NhaCungCap{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", rate=" + rate +
                ", note='" + note + '\'' +
                ", listTaiKhoanNganHang=" + listTaiKhoanNganHang +
                '}';
    }
}
