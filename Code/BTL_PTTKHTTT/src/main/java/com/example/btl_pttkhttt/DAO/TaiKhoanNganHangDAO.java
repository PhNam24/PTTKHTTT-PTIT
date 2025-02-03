package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.TaiKhoanNganHang;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TaiKhoanNganHangDAO extends DAO {
    public TaiKhoanNganHangDAO() {
        super();
    }

    public boolean saveTK(TaiKhoanNganHang taiKhoanNganHang, long idNhaCungCap) {
        try {
            String query = "INSERT INTO tblTaiKhoanNganHang(bankName, bankAccount, tblNhaCungCapId) VALUES (?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, taiKhoanNganHang.getBankName());
            stm.setString(2, taiKhoanNganHang.getBankAccount());
            stm.setLong(3, idNhaCungCap);
            if (stm.executeUpdate() > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkDuplicateTK(String bankAccount) {
        try {
            String query = "SELECT * FROM tblTaiKhoanNganHang WHERE bankAccount = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, bankAccount);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<TaiKhoanNganHang> getTKByNCCId(int id) {
        ArrayList<TaiKhoanNganHang> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblTaiKhoanNganHang WHERE tblNhaCungCapId = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                TaiKhoanNganHang taiKhoanNganHang = new TaiKhoanNganHang();
                taiKhoanNganHang.setId(rs.getInt("id"));
                taiKhoanNganHang.setBankName(rs.getString("bankName"));
                taiKhoanNganHang.setBankAccount(rs.getString("bankAccount"));
                list.add(taiKhoanNganHang);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
