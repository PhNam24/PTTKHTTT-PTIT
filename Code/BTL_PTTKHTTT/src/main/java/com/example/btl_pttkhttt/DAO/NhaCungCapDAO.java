package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.NhaCungCap;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class NhaCungCapDAO extends DAO {
    public NhaCungCapDAO() {
        super();
    }

//    public boolean saveNCC(NhaCungCap nhaCungCap) {
//        try {
//            String query = "INSERT INTO tblNhaCungCap VALUES (?, ?, ?, ?, ?, ?)";
//            PreparedStatement stm = con.prepareStatement(query);
//            stm.setString(1, nhaCungCap.getName());
//            stm.setString(2, nhaCungCap.getAddress());
//            stm.setString(3, nhaCungCap.getPhone());
//            stm.setString(4, nhaCungCap.getEmail());
//            stm.setFloat(5, nhaCungCap.getRate());
//            stm.setString(6, nhaCungCap.getNote());
//            if (stm.executeUpdate() > 0) {
//                return true;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return false;
//    }

    public long saveNCC(NhaCungCap nhaCungCap) {
        try {
            String query = "INSERT INTO tblNhaCungCap(name, address, phone, email, rate, note) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, nhaCungCap.getName());
            stm.setString(2, nhaCungCap.getAddress());
            stm.setString(3, nhaCungCap.getPhone());
            stm.setString(4, nhaCungCap.getEmail());
            stm.setFloat(5, nhaCungCap.getRate());
            stm.setString(6, nhaCungCap.getNote());
            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getLong(1); // Cột đầu tiên của ResultSet chứa khóa tự động tạo
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean checkDuplicateNCC(NhaCungCap ncc) {
        try {
            String query = "SELECT * FROM tblNhaCungCap WHERE name = ? OR email = ? OR phone = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, ncc.getName());
            stm.setString(2, ncc.getEmail());
            stm.setString(3, ncc.getPhone());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<NhaCungCap> getAllNCC() {
        ArrayList<NhaCungCap> listNCC = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblNhaCungCap";
            PreparedStatement stm = con.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                NhaCungCap nhaCungCap = new NhaCungCap(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getFloat("rate"),
                        rs.getString("note")
                );
                listNCC.add(nhaCungCap);
            }
            return listNCC;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public NhaCungCap getNCCById(int id) {
        ArrayList<NhaCungCap> listNCC = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblNhaCungCap WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new NhaCungCap(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getFloat("rate"),
                        rs.getString("note")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<NhaCungCap> searchNCC(String keyword) {
        ArrayList<NhaCungCap> listNCC = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblNhaCungCap WHERE id LIKE ? OR name LIKE ? " +
                    "OR address LIKE ? OR phone LIKE ? OR email LIKE ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setString(4, "%" + keyword + "%");
            stm.setString(5, "%" + keyword + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                NhaCungCap nhaCungCap = new NhaCungCap(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getFloat("rate"),
                        rs.getString("note")
                );
                listNCC.add(nhaCungCap);
            }
            return listNCC;
        } catch (Exception e) {
            e.printStackTrace();
    }
        return null;
    }
}
