package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.TrangPhucNhap;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TrangPhucNhapDAO extends DAO {
    private static TrangPhucDAO trangPhucDAO;
    public TrangPhucNhapDAO() {
        super();
        trangPhucDAO = new TrangPhucDAO();
    }

    public boolean saveTPNhap(TrangPhucNhap trangPhucNhap, int id) {
        try {
            String query = "INSERT INTO tblTrangPhucNhap (quantity, price, note, tblDonHangId, tblTrangPhucId) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, trangPhucNhap.getQuantity());
            stm.setFloat(2, trangPhucNhap.getPrice());
            stm.setString(3, trangPhucNhap.getNote());
            stm.setInt(4, id);
            stm.setInt(5, trangPhucNhap.getTrangPhuc().getId());
            if (stm.executeUpdate() > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<TrangPhucNhap> getTPNhapByDonHang(int id) {
        ArrayList<TrangPhucNhap> trangPhucNhaps = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblTrangPhucNhap WHERE tblDonHangId = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                TrangPhucNhap trangPhucNhap = new TrangPhucNhap();
                trangPhucNhap.setId(rs.getInt("id"));
                trangPhucNhap.setQuantity(rs.getInt("quantity"));
                trangPhucNhap.setPrice(rs.getFloat("price"));
                trangPhucNhap.setNote(rs.getString("note"));
                trangPhucNhap.setTrangPhuc(trangPhucDAO.getTrangPhucById(rs.getInt("tblTrangPhucId")));
                trangPhucNhaps.add(trangPhucNhap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trangPhucNhaps;
    }
}
