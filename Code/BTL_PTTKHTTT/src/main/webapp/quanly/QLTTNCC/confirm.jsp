<%@ page import="java.sql.Date" %>
<%@ page import="com.example.btl_pttkhttt.Model.NhaCungCap" %>
<%@ page import="com.example.btl_pttkhttt.Model.HopDong" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.btl_pttkhttt.Model.TaiKhoanNganHang" %>
<%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 11/11/2024
  Time: 5:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm nhà cung cấp mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/styles/moduleStyle.css">
</head>
<body>
<div class="container py-5">
    <div class="card p-4">
        <h2 class="mb-4">Thêm nhà cung cấp mới</h2>
        <form id="supplierForm" action="doConfirm.jsp" method="post" onsubmit="return submitForm(this)">
            <%
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                String[] listName = request.getParameter("listName").split(",");
                String[] listStk = request.getParameter("listStk").split(",");
                NhaCungCap nhaCungCap = new NhaCungCap(name, address, phone, email);
                HopDong hopDong = new HopDong(Date.valueOf(startDate), Date.valueOf(endDate));
                ArrayList<TaiKhoanNganHang> listTK = new ArrayList<>();
                for (int i = 0; i < listName.length; i++) {
                    TaiKhoanNganHang taiKhoanNganHang = new TaiKhoanNganHang(listName[i], listStk[i]);
                    listTK.add(taiKhoanNganHang);
                }
                if (listTK.getFirst().getBankName().isEmpty()) {
                    listTK.removeFirst();
                }
                session.setAttribute("nhaCungCap", nhaCungCap);
                session.setAttribute("hopDong", hopDong);
                session.setAttribute("listTK", listTK);
            %>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="name" class="form-label">Tên</label>
                    <input readonly type="text" class="form-control" id="name" name="name" required value="<%= name %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input readonly type="tel" class="form-control" id="phone" name="phone" required value="<%= phone %>">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input readonly type="email" class="form-control" id="email" name="email" required value="<%= email %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input readonly type="text" class="form-control" id="address" name="address" required value="<%= address %>">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="startDate" class="form-label">Ngày bắt đầu hợp đồng</label>
                    <input readonly type="date" class="form-control" id="startDate" name="startDate" required value="<%= startDate %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="endDate" class="form-label">Ngày hết hạn hợp đồng</label>
                    <input readonly type="date" class="form-control" id="endDate" name="endDate" required value="<%= endDate %>">
                </div>
            </div>

            <div id="paymentAccounts">
                <!-- Payment accounts will be added here -->
                <%
                    for (int i = 0; i < listTK.size(); i++) {
                %>
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="mb-0">Tài khoản thanh toán #<%= i + 1 %></h5>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngân hàng</label>
                            <input readonly type="text" class="form-control" name="bankName" required value="<%= listTK.get(i).getBankName() %>">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số tài khoản</label>
                            <input readonly type="text" class="form-control" name="accountNumber" required value="<%= listTK.get(i).getBankAccount() %>">
                        </div>
                    </div>
                <%
                    }
                %>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Xác nhận
                </button>
                <button type="button" class="btn btn-primary" id="backButton" onclick="window.history.back()">
                    <i class="fas fa-arrow-left"></i> Trở về
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
<script>
    function submitForm(form) {
        // Lấy giá trị các trường tài khoản
        var name = document.getElementsByName("bankName");
        var stk = document.getElementsByName("accountNumber");
        var listName = "";
        var listStk = "";

        for (var i = 0; i < name.length; i++) {
            listName += name[i].value + ",";
            listStk += stk[i].value + ",";
        }

        if (listName === "" || listStk === "") {
            alert("Vui lòng nhập ít nhất một tài khoản thanh toán");
            return false; // Không cho form submit
        }
        // Submit form và chuyển hướng
        form.action = `http://localhost:8080/BTL_PTTKHTTT_war_exploded/quanly/QLTTNCC/doConfirm.jsp?listName=` + listName + `&listStk=` + listStk;
        return true; // Cho phép form submit
    }
</script>
</body>
</html>