package com.example.btl_pttkhttt.Model;

import java.text.DecimalFormat;

public class TrangPhuc {
    private int id;
    private String name;
    private String picture;
    private String des;
    private float price;

    public TrangPhuc() {
    }

    public TrangPhuc(int id, String name, String picture, String des, float price) {
        this.id = id;
        this.name = name;
        this.picture = picture;
        this.des = des;
        this.price = price;
    }

    public TrangPhuc(String name, String picture, String des, float price) {
        this.name = name;
        this.picture = picture;
        this.des = des;
        this.price = price;
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

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public float getPrice() {
        return price;
    }

    public String getPriceString() {
        DecimalFormat df2 = new DecimalFormat( "###,###,###.##" );
        return df2.format(price);
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
