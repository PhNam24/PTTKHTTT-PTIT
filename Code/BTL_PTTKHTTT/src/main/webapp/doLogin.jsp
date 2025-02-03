<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>

<%
  String username = (String)request.getParameter("username");
  String password = (String)request.getParameter("password");
  NhanVienDAO nhanVienDAO = new NhanVienDAO();
  NhanVien nhanVien = nhanVienDAO.checkLogin(username, password);

  if(nhanVien instanceof QuanLy){
    session.setAttribute("nhanvien", nhanVien);
    response.sendRedirect("quanly\\gdChinhQL.jsp");
  }else if(nhanVien instanceof NhanVienKho){
    session.setAttribute("nhanvien", nhanVien);
    response.sendRedirect("nhanvien\\gdChinhKho.jsp");
  }else{
    response.sendRedirect("index.jsp?err=fail");
  }
%>