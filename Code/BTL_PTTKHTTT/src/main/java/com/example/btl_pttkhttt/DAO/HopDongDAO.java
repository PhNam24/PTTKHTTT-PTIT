package com.example.btl_pttkhttt.DAO;

import com.example.btl_pttkhttt.Model.HopDong;

import java.sql.PreparedStatement;

public class HopDongDAO extends DAO {
    public HopDongDAO() {
        super();
    }

    public boolean saveHopDong(HopDong hopDong) {
        try {
            String query = "INSERT INTO tblHopDong(startDate, endDate, tblNhaCungCapId) VALUES (?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(query);
            stm.setDate(1, hopDong.getStartDate());
            stm.setDate(2, hopDong.getEndDate());
            stm.setInt(3, hopDong.getNhaCungCap().getId());
            if (stm.executeUpdate() > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

