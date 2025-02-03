package com.example.btl_pttkhttt.Model;

public class TaiKhoanNganHang {
    private int id;
    private String bankName;
    private String bankAccount;

    public TaiKhoanNganHang() {
    }

    public TaiKhoanNganHang(int id, String bankName, String bankAccount) {
        this.id = id;
        this.bankName = bankName;
        this.bankAccount = bankAccount;
    }

    public TaiKhoanNganHang(String bankName, String bankAccount) {
        this.bankName = bankName;
        this.bankAccount = bankAccount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }
}
