<%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 11/12/2024
  Time: 6:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>
<%
    NhaCungCapDAO nhaCungCapDAO = new NhaCungCapDAO();
    HopDongDAO hopDongDAO = new HopDongDAO();
    TaiKhoanNganHangDAO taiKhoanNganHangDAO = new TaiKhoanNganHangDAO();

    NhaCungCap ncc = (NhaCungCap) session.getAttribute("nhaCungCap");
    HopDong hd = (HopDong) session.getAttribute("hopDong");
    ArrayList<TaiKhoanNganHang> listTK = (ArrayList<TaiKhoanNganHang>) session.getAttribute("listTK");

    if (nhaCungCapDAO.checkDuplicateNCC(ncc)) {
        response.sendRedirect("gdQLTTNCC.jsp?err=4");
        return;
    }
    long nccId = nhaCungCapDAO.saveNCC(ncc);
    if (nccId != -1) {
        ncc.setId((int)nccId);
        hd.setNhaCungCap(ncc);
        System.out.println(hd.getNhaCungCap().getId());
        boolean hdResult = hopDongDAO.saveHopDong(hd);
        if (hdResult) {
            for (TaiKhoanNganHang tk : listTK) {
                if (taiKhoanNganHangDAO.checkDuplicateTK(tk.getBankAccount())) {
                    response.sendRedirect("gdQLTTNCC.jsp?err=5");
                    return;
                }
                boolean tkResult = taiKhoanNganHangDAO.saveTK(tk, nccId);
                if (!tkResult) {
                    response.sendRedirect("gdQLTTNCC.jsp?err=3");
                    return;
                }
            }
        }
        else {
            response.sendRedirect("gdQLTTNCC.jsp?err=2");
            return;
        }
    }
    else {
        response.sendRedirect("gdQLTTNCC.jsp?err=1");
        return;
    }
    response.sendRedirect("gdQLTTNCC.jsp?success=1");
%>