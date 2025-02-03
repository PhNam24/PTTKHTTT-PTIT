package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.*;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class DonHangDAO extends DAO {
    private TrangPhucNhapDAO trangPhucNhapDAO;
    public DonHangDAO() {
        super();
        trangPhucNhapDAO = new TrangPhucNhapDAO();
    }

//    public boolean saveDonHang(DonHang donHang) {
//        try {
//            String query = "INSERT INTO tblDonHang VALUES (?, ?, ?, ?, ?)";
//            PreparedStatement stm = con.prepareStatement(query);
//            stm.setDate(1, donHang.getImportDate());
//            stm.setFloat(2, donHang.getTotalAmount());
//            stm.setString(3, donHang.getNote());
//            stm.setInt(4, donHang.getNhaCungCap().getId());
//            stm.setInt(5, donHang.getNhanVienKho().getId());
//            if (stm.executeUpdate() > 0) {
//                return true;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return false;
//    }

    public long saveDonHang(DonHang donHang, ArrayList<TrangPhucNhap> tpnList) {
        try {
            String query = "INSERT INTO tblDonHang(importDate, note, tblNhanVienKhoId, tblNhaCungCapId) VALUES (?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stm.setDate(1, donHang.getImportDate());
            stm.setString(2, donHang.getNote());
            stm.setInt(3, donHang.getNhanVienKho().getId());
            stm.setInt(4, donHang.getNhaCungCap().getId());
            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        long dhId = rs.getLong(1);
                        for (TrangPhucNhap tnp: tpnList) {
                            if (!trangPhucNhapDAO.saveTPNhap(tnp, (int) dhId)) {
                                return -2;
                            }
                        }
                        return rs.getLong(1); // Cột đầu tiên của ResultSet chứa khóa tự động tạo
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<DonHang> getAllDonHang() {
        ArrayList<DonHang> listDonHang = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblDonHang";
            PreparedStatement stm = con.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                DonHang donHang = new DonHang(
                        rs.getInt("id"),
                        rs.getDate("importDate"),
                        rs.getString("note"),
                        new NhaCungCapDAO().getNCCById(rs.getInt("tblNhaCungCapId")),
                        new NhanVienKho(new NhanVienDAO().getNhanVienById(rs.getInt("tblNhanVienKhoId")))
                );
                ArrayList<TrangPhucNhap> listTpn = trangPhucNhapDAO.getTPNhapByDonHang(donHang.getId());
                donHang.setListTrangPhucNhap(listTpn);
                listDonHang.add(donHang);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listDonHang;
    }

    public ArrayList<DonHang> getDonHangByNCC(int id) {
        ArrayList<DonHang> listDonHang = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblDonHang WHERE tblNhaCungCapId = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                DonHang donHang = new DonHang(
                        rs.getInt("id"),
                        rs.getDate("importDate"),
                        rs.getString("note"),
                        new NhaCungCapDAO().getNCCById(rs.getInt("tblNhaCungCapId")),
                        new NhanVienKho(new NhanVienDAO().getNhanVienById(rs.getInt("tblNhanVienKhoId")))
                );
                ArrayList<TrangPhucNhap> listTpn = trangPhucNhapDAO.getTPNhapByDonHang(donHang.getId());
                donHang.setListTrangPhucNhap(listTpn);
                listDonHang.add(donHang);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listDonHang;
    }

    public ArrayList<DonHang> getDonHangByDate(NhaCungCap ncc, Date startDate, Date endDate) {
        ArrayList<DonHang> listDonHang = new ArrayList<>();
        try {
            String query = "SELECT * FROM tblDonHang WHERE tblNhaCungCapId = ? AND importDate BETWEEN ? AND ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, ncc.getId());
            stm.setDate(2, new Date(startDate.getTime()));
            stm.setDate(3, new Date(endDate.getTime()));

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                DonHang donHang = new DonHang(
                        rs.getInt("id"),
                        rs.getDate("importDate"),
                        rs.getString("note"),
                        ncc,
                        new NhanVienKho(new NhanVienDAO().getNhanVienById(rs.getInt("tblNhanVienKhoId")))
                );
                ArrayList<TrangPhucNhap> listTpn = trangPhucNhapDAO.getTPNhapByDonHang(donHang.getId());
                donHang.setListTrangPhucNhap(listTpn);
                listDonHang.add(donHang);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listDonHang;
    }


    public DonHang getDonHangById(int id) {
        try {
            String query = "SELECT * FROM tblDonHang WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                DonHang donHang = new DonHang(
                        rs.getInt("id"),
                        rs.getDate("importDate"),
                        rs.getString("note"),
                        new NhaCungCapDAO().getNCCById(rs.getInt("tblNhaCungCapId")),
                        new NhanVienKho(new NhanVienDAO().getNhanVienById(rs.getInt("tblNhanVienKhoId")))
                );
                ArrayList<TrangPhucNhap> listTpn = trangPhucNhapDAO.getTPNhapByDonHang(donHang.getId());
                donHang.setListTrangPhucNhap(listTpn);
                return donHang;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
