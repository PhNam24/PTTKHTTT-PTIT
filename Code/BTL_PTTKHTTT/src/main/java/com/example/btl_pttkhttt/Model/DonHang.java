package com.example.btl_pttkhttt.Model;

import java.sql.Date;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class DonHang {
    private int id;
    private Date importDate;
    private String note = "";
    private NhaCungCap nhaCungCap;
    private NhanVienKho nhanVienKho;
    private ArrayList<TrangPhucNhap> listTrangPhucNhap;

    public DonHang() {
        listTrangPhucNhap = new ArrayList<>();
    }

    public DonHang(int id, Date importDate, String note, NhaCungCap nhaCungCap, NhanVienKho nhanVienKho) {
        this.id = id;
        this.importDate = importDate;
        this.note = note;
        this.nhaCungCap = nhaCungCap;
        this.nhanVienKho = nhanVienKho;
        listTrangPhucNhap = new ArrayList<>();
    }

    public DonHang(Date importDate, NhaCungCap nhaCungCap, NhanVienKho nhanVienKho) {
        this.importDate = importDate;
        this.nhaCungCap = nhaCungCap;
        this.nhanVienKho = nhanVienKho;
        listTrangPhucNhap = new ArrayList<>();
    }

    public DonHang(Date importDate, NhaCungCap nhaCungCap, NhanVienKho nhanVienKho, ArrayList<TrangPhucNhap> tpn) {
        this.importDate = importDate;
        this.nhaCungCap = nhaCungCap;
        this.nhanVienKho = nhanVienKho;
        this.listTrangPhucNhap = tpn;
    }

    public int getDay() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(importDate);
        return calendar.get(Calendar.DATE);
    }

    public int getMonth() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(importDate);
        return calendar.get(Calendar.MONTH) + 1;
    }

    public int getYear() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(importDate);
        return calendar.get(Calendar.YEAR);
    }

    public void addTrangPhucNhap(TrangPhucNhap trangPhucNhap) {
        listTrangPhucNhap.add(trangPhucNhap);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public float getTotalAmount() {
        float totalAmount = 0;
        for (TrangPhucNhap tnp: listTrangPhucNhap) {
            totalAmount += tnp.getQuantity() * tnp.getPrice();
        }
        return totalAmount;
    }

    public String getTotalAmountString() {
        DecimalFormat df2 = new DecimalFormat( "###,###,###.##" );
        return df2.format(getTotalAmount());
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public NhaCungCap getNhaCungCap() {
        return nhaCungCap;
    }

    public void setNhaCungCap(NhaCungCap nhaCungCap) {
        this.nhaCungCap = nhaCungCap;
    }

    public NhanVienKho getNhanVienKho() {
        return nhanVienKho;
    }

    public void setNhanVienKho(NhanVienKho nhanVienKho) {
        this.nhanVienKho = nhanVienKho;
    }

    public ArrayList<TrangPhucNhap> getListTrangPhucNhap() {
        return listTrangPhucNhap;
    }

    public void setListTrangPhucNhap(ArrayList<TrangPhucNhap> listTrangPhucNhap) {
        this.listTrangPhucNhap = listTrangPhucNhap;
    }
}
