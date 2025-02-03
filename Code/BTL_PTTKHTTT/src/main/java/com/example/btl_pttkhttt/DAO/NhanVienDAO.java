package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.NhanVien;
import com.example.btl_pttkhttt.Model.NhanVienKho;
import com.example.btl_pttkhttt.Model.QuanLy;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class NhanVienDAO extends DAO {
    public NhanVienDAO() {
        super();
    }

    public NhanVien checkLogin(String username, String password) {
        System.out.println("Checking login: " + username + " - " + password);
        try {
            String query = "SELECT * FROM tblNhanVien WHERE username = ? AND password = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                NhanVien nhanVien = new NhanVien(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDate("birth"),
                        rs.getString("phone"),
                        rs.getString("email")
                );

                String query2 = "SELECT * FROM tblQuanLy WHERE tblNhanVienId = ?";
                PreparedStatement stm2 = con.prepareStatement(query2);
                stm2.setInt(1, nhanVien.getId());
                ResultSet rs2 = stm2.executeQuery();
                if (rs2.next()) {
                    System.out.println("Quan ly Logged in");
                    return new QuanLy(nhanVien);
                }

                String query3 = "SELECT * FROM tblNhanVienKho WHERE tblNhanVienId = ?";
                PreparedStatement stm3 = con.prepareStatement(query3);
                stm3.setInt(1, nhanVien.getId());
                ResultSet rs3 = stm3.executeQuery();
                if (rs3.next()) {
                    System.out.println("Nhan vien kho Logged in");
                    return new NhanVienKho(nhanVien);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Login failed");
        return null;
    }

    public NhanVien getNhanVienById(int id) {
        try {
            String query = "SELECT * FROM tblNhanVien WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new NhanVien(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDate("birth"),
                        rs.getString("phone"),
                        rs.getString("email")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
