<%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 12/3/2024
  Time: 7:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*" %>
<%@ page import="java.sql.Date" %>
<%
    DonHangDAO donHangDAO = new DonHangDAO();
    NhaCungCapDAO nhaCungCapDAO = new NhaCungCapDAO();
    TrangPhucNhapDAO trangPhucNhapDAO = new TrangPhucNhapDAO();

    Date importDate = Date.valueOf(request.getParameter("importDate"));
    NhanVienKho nvk = (NhanVienKho) session.getAttribute("nhanvien");
    NhaCungCap ncc = nhaCungCapDAO.getNCCById(Integer.parseInt(request.getParameter("ncc").split("-")[0]));

    ArrayList<TrangPhuc> listTP = (ArrayList<TrangPhuc>) session.getAttribute("tpList");
    ArrayList<TrangPhucNhap> listTPN = new ArrayList<>();
    for (TrangPhuc tp: listTP) {
        TrangPhucNhap tpn = new TrangPhucNhap(Integer.parseInt(request.getParameter(tp.getId() + "-quantity")), Float.parseFloat(request.getParameter(tp.getId() + "-price")),tp);
        listTPN.add(tpn);
    }

    DonHang dh = new DonHang(importDate ,ncc, nvk, listTPN);
    long dhId = donHangDAO.saveDonHang(dh, listTPN);
    if (dhId == -1) {
        response.sendRedirect("../gdChinhKho.jsp?err=2");
        return;
    }
    else if (dhId == -2) {
        response.sendRedirect("../gdChinhKho.jsp?err=1");
        return;
    }
    response.sendRedirect("../gdChinhKho.jsp?success=1");
%>