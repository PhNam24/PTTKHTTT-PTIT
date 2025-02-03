package com.example.btl_pttkhttt.Model;

import java.sql.Date;

public class HopDong {
    private int id;
    private Date startDate;
    private Date endDate;
    private NhaCungCap nhaCungCap;

    public HopDong(int id, Date startDate, Date endDate, NhaCungCap nhaCungCap) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.nhaCungCap = nhaCungCap;
    }

    public HopDong(Date startDate, Date endDate, NhaCungCap nhaCungCap) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.nhaCungCap = nhaCungCap;
    }

    public HopDong(Date startDate, Date endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public NhaCungCap getNhaCungCap() {
        return nhaCungCap;
    }

    public void setNhaCungCap(NhaCungCap nhaCungCap) {
        this.nhaCungCap = nhaCungCap;
    }

    @Override
    public String toString() {
        return "HopDong{" +
                "id=" + id +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", nhaCungCap=" + nhaCungCap +
                '}';
    }
}
