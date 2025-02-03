package com.example.btl_pttkhttt.Model;

import java.text.DecimalFormat;

public class ThongKeNhaCungCap {
    private NhaCungCap ncc;
    private float tongChi;

    public ThongKeNhaCungCap(NhaCungCap ncc, float tongChi) {
        this.ncc = ncc;
        this.tongChi = tongChi;
    }

    public NhaCungCap getNcc() {
        return ncc;
    }

    public void setNcc(NhaCungCap ncc) {
        this.ncc = ncc;
    }

    public String getTongChi() {
        DecimalFormat df2 = new DecimalFormat( "###,###,###.##" );
        return df2.format(tongChi);
    }

    public void setTongChi(float tongChi) {
        this.tongChi = tongChi;
    }
}
