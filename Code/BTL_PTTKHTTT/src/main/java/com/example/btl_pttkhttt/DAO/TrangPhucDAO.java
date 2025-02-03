package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.TrangPhuc;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TrangPhucDAO extends DAO {
    public TrangPhucDAO() {
        super();
    }

    public boolean saveTP(TrangPhuc trangPhuc) {
        try {
            String query = "INSERT INTO tblTrangPhuc VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, trangPhuc.getName());
            stm.setString(2, trangPhuc.getPicture());
            stm.setString(3, trangPhuc.getDes());
            stm.setFloat(4, trangPhuc.getPrice());
            if (stm.executeUpdate() > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<TrangPhuc> getAllTP() {
        ArrayList<TrangPhuc> listTP = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblTrangPhuc";
            PreparedStatement stm = con.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                TrangPhuc trangPhuc = new TrangPhuc(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("picture"),
                        rs.getString("des"),
                        rs.getFloat("price")
                );
                listTP.add(trangPhuc);
            }
            return listTP;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<TrangPhuc> searchTP(String keyword) {
        ArrayList<TrangPhuc> listTP = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblTrangPhuc WHERE id LIKE ? OR name LIKE ? OR price LIKE ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                TrangPhuc trangPhuc = new TrangPhuc(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("picture"),
                        rs.getString("des"),
                        rs.getFloat("price")
                );
                listTP.add(trangPhuc);
            }
            return listTP;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public TrangPhuc getTrangPhucById(int id) {
        try {
            String query = "SELECT * FROM tblTrangPhuc WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new TrangPhuc(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("picture"),
                        rs.getString("des"),
                        rs.getFloat("price")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
