package com.example.btl_pttkhttt.Model;

import java.text.DecimalFormat;

public class TrangPhucNhap {
    private int id;
    private int quantity;
    private float price;
    private String note = "";
    private TrangPhuc trangPhuc;

    public TrangPhucNhap() {
    }

    public TrangPhucNhap(int id, int quantity, float price, String note, TrangPhuc trangPhuc) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.note = note;
        this.trangPhuc = trangPhuc;
    }

    public TrangPhucNhap(int quantity, float price,TrangPhuc trangPhuc) {
        this.quantity = quantity;
        this.price = price;
        this.trangPhuc = trangPhuc;
    }

    public String getAmountString() {
        DecimalFormat df2 = new DecimalFormat( "###,###,###.##" );
        return df2.format(getAmount());
    }

    public float getAmount() {
        return price * quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float amount) {
        this.price = amount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public TrangPhuc getTrangPhuc() {
        return trangPhuc;
    }

    public void setTrangPhuc(TrangPhuc trangPhuc) {
        this.trangPhuc = trangPhuc;
    }
}
