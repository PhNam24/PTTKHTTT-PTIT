package com.example.btl_pttkhttt;

import com.example.btl_pttkhttt.DAO.NhanVienDAO;
import com.example.btl_pttkhttt.Model.NhanVien;
import com.example.btl_pttkhttt.Model.NhanVienKho;

public class testDB {
    public static void main(String[] args) {
        NhanVienDAO nhanVienDAO = new NhanVienDAO();

        System.out.println(new NhanVienKho(nhanVienDAO.getNhanVienById(1)));
    }
}
