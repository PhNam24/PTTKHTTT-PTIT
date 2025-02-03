<%@page language="java" contentType="text/html" pageEncoding="UTF-8"
        import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/styles/gdChinhStyle.css">
</head>
<body>
<div class="page-container">
    <!-- Left Panel (Same as other pages) -->
    <div class="left-panel">
        <div class="profile-section">
            <div class="profile-card text-center">
                <div class="avatar-container mb-3">
                    <img src="../../assets/images/avt.svg" alt="Avatar" class="avatar">
                </div>
                <%
                    QuanLy ql = (QuanLy) session.getAttribute("nhanvien");
                    System.out.println(ql);
                %>
                <h5 class="mb-2" style="font-size: 1.1rem;"><%= ql.getName() %></h5>
                <p class="mb-3" style="font-size: 0.9rem;"><%= ql.getRole() %></p>
                <div class="personal-info">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-phone me-2"></i>Phone
                        </div>
                        <div class="info-value"><%= ql.getPhone() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-envelope me-2"></i>Email
                        </div>
                        <div class="info-value"><%= ql.getEmail() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calendar me-2"></i>Date of Birth
                        </div>
                        <div class="info-value"><%= ql.getBirth() %></div>
                    </div>
                </div>
            </div>
        </div>

        <button class="logout-btn" onclick="window.location.replace('../../index.jsp?err=logout');">
            <i class="fas fa-sign-out-alt me-2"></i>
            Logout
        </button>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <div class="content-wrapper">
            <!-- Order Detail Section -->
            <div class="order-details-section">
                <h2 class="section-title">Chi Tiết Đơn Hàng</h2>
                <div class="order-details">
                <%
                    DonHangDAO donHangDAO = new DonHangDAO();
                    TrangPhucNhapDAO trangPhucNhapDAO = new TrangPhucNhapDAO();
                    int idDh = Integer.parseInt(request.getParameter("idDh"));
                    DonHang donHang = donHangDAO.getDonHangById(idDh);
                    ArrayList<TrangPhucNhap> trangPhucNhapList = trangPhucNhapDAO.getTPNhapByDonHang(idDh);
                    if (donHang != null) {
                %>
                    <div class="info-grid">
                        <div class="info-row">
                            <span class="info-label">Mã Đơn Hàng</span>
                            <span class="info-value">DH<%= donHang.getId() %></span>
                            <span class="info-label">Ngày Thực Hiện</span>
                            <span class="info-value"><%= donHang.getImportDate() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">Nhà Cung Cấp</span>
                            <span class="info-value"><%= donHang.getNhaCungCap().getName() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">Nhân Viên Nhập Hàng</span>
                            <span class="info-value"><%= donHang.getNhanVienKho().getName() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">Tổng Giá Trị Đơn Hàng</span>
                            <span class="info-value"><%= donHang.getTotalAmountString() %> VND</span>
                        </div>
                        <br>
                        <button class="btn btn-secondary" id="back-button" onclick="window.history.back()">
                            <i class="fas fa-arrow-left me-2"></i>Trở về
                        </button>
                    </div>
                </div>
                <!-- Order Details Table -->
                <div class="table-container">
                    <br><br>
                    <table class="table table-dark table-striped table-hover text-center">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã Trang Phục</th>
                            <th>Tên Trang Phục</th>
                            <th>Ảnh</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            int cnt = 1;
                            for (TrangPhucNhap tpn : trangPhucNhapList) {
                        %>
                        <tr>
                            <td><%= cnt++ %></td>
                            <td><%= "TP" + tpn.getTrangPhuc().getId() %></td>
                            <td><%= tpn.getTrangPhuc().getName() %></td>
                            <td>
                                <img src="../../assets/images/TrangPhuc/<%= tpn.getTrangPhuc().getPicture() + ".png" %>"
                                     alt="<%= tpn.getTrangPhuc().getName() %>"
                                     class="order-product-img img-fluid"
                                    >
                            </td>
                            <td><%= tpn.getQuantity() %></td>
                            <td><%= tpn.getTrangPhuc().getPriceString() %> VND</td>
                            <td><%= tpn.getAmountString() %> VND</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>