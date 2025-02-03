package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.DonHang;
import com.example.btl_pttkhttt.Model.NhaCungCap;
import com.example.btl_pttkhttt.Model.ThongKeNhaCungCap;
import com.example.btl_pttkhttt.Model.TrangPhucNhap;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;

public class ThongKeNhaCungCapDAO extends DAO {
    private static NhaCungCapDAO nhaCungCapDAO;
    private static DonHangDAO donHangDAO;
    private static TrangPhucNhapDAO trangPhucNhapDAO;
    public ThongKeNhaCungCapDAO() {
        super();
        nhaCungCapDAO = new NhaCungCapDAO();
        donHangDAO = new DonHangDAO();
        trangPhucNhapDAO = new TrangPhucNhapDAO();
    }

    public ArrayList<ThongKeNhaCungCap> getTKNCC() {
        ArrayList<ThongKeNhaCungCap> list = new ArrayList<>();
        try {
            ArrayList<NhaCungCap> listNcc = nhaCungCapDAO.getAllNCC();
            for (NhaCungCap ncc : listNcc) {
                ArrayList<DonHang> listDh = donHangDAO.getDonHangByNCC(ncc.getId());
                float tongChi = 0;
                for (DonHang dh : listDh) {
                    tongChi += dh.getTotalAmount();
                }
                list.add(new ThongKeNhaCungCap(ncc, tongChi));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<ThongKeNhaCungCap> getTKNCCByDate(Date startDate, Date endDate) {
        ArrayList<ThongKeNhaCungCap> list = new ArrayList<>();
        try {
            String query = "SELECT ncc.id AS nhaCungCapId, \n" +
                    "       COALESCE(SUM(tpNhap.quantity * tpNhap.price), 0) AS tongDoanhChi\n" +
                    "FROM tblNhaCungCap AS ncc\n" +
                    "LEFT JOIN tblDonHang AS dh ON ncc.id = dh.tblNhaCungCapId AND dh.importDate BETWEEN ? AND ?\n" +
                    "LEFT JOIN tblTrangPhucNhap AS tpNhap ON dh.id = tpNhap.tblDonHangId\n" +
                    "GROUP BY ncc.id\n" +
                    "ORDER BY tongDoanhChi DESC;\n";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new ThongKeNhaCungCap(nhaCungCapDAO.getNCCById(rs.getInt("nhaCungCapId")), rs.getFloat("tongDoanhChi")));
            }
        }  catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
