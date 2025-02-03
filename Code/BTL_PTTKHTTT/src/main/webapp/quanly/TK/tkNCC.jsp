<%@ page import="java.sql.Date" %>
<%@ page import="com.example.btl_pttkhttt.DAO.ThongKeNhaCungCapDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.btl_pttkhttt.Model.ThongKeNhaCungCap" %><%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 12/3/2024
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ThongKeNhaCungCapDAO thongKeNhaCungCapDAO = new ThongKeNhaCungCapDAO();
    Date startDate = Date.valueOf(request.getParameter("startDate"));
    Date endDate = Date.valueOf(request.getParameter("endDate"));

    ArrayList<ThongKeNhaCungCap> tkList = thongKeNhaCungCapDAO.getTKNCCByDate(startDate, endDate);
    session.setAttribute("tkChi", tkList);
    response.sendRedirect("gdTKChi.jsp?startDate=" + startDate +"&endDate=" + endDate);
%>