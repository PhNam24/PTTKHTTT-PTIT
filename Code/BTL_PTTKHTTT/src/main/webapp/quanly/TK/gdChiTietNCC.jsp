<%@page language="java" contentType="text/html" pageEncoding="UTF-8"
        import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng quần áo ABC</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/styles/gdChinhStyle.css">
</head>
<body>
<div class="page-container">
    <!-- Left Panel -->
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
            <!-- Supplier Information Section -->
            <div class="supplier-section">
                <h2 class="section-title">Thông Tin Nhà Cung Cấp</h2>
                <div class="supplier-details">
                    <%
                        NhaCungCapDAO nhaCungCapDAO = new NhaCungCapDAO();
                        NhaCungCap ncc = nhaCungCapDAO.getNCCById(Integer.parseInt(request.getParameter("idNcc")));
                        if (ncc != null) {
                            TaiKhoanNganHangDAO taiKhoanNganHangDAO = new TaiKhoanNganHangDAO();
                            ncc.setListTaiKhoanNganHang(taiKhoanNganHangDAO.getTKByNCCId(ncc.getId()));

                            // Prepare bank account information
                            StringBuilder bankAccounts = new StringBuilder();
                            int cnt = 1;
                            for(TaiKhoanNganHang tk : ncc.getListTaiKhoanNganHang()) {
                                bankAccounts.append(tk.getBankName())
                                        .append(": ")
                                        .append(tk.getBankAccount());
                                if (cnt < ncc.getListTaiKhoanNganHang().size()) {
                                    bankAccounts.append(" | ");
                                }
                                cnt++;
                            }
                    %>
                    <div class="info-grid">
                        <div class="info-row">
                            <span class="info-label">Mã NCC: </span>
                            <span class="info-value"><%= ncc.getId() %></span>
                            <span class="info-label">Tên NCC: </span>
                            <span class="info-value"><%= ncc.getName() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">Địa Chỉ: </span>
                            <span class="info-value"><%= ncc.getAddress() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">SĐT: </span>
                            <span class="info-value"><%= ncc.getPhone() %></span>
                            <span class="info-label">Email: </span>
                            <span class="info-value"><%= ncc.getEmail() %></span>
                        </div>
                        <br>
                        <div class="info-row">
                            <span class="info-label">TK Ngân Hàng:</span>
                            <span class="info-value"><%= bankAccounts.toString() %></span>
                        </div>
                        <br>
                    </div>
                    <%
                        }
                    %>
                    <button class="btn btn-secondary" id="back-button" onclick="window.history.back()">
                        <i class="fas fa-arrow-left me-2"></i>Trở về
                    </button>
                </div>
            </div>

            <!-- Sales Summary Section -->
            <div class="sales-summary-section">
                <br><br>
                <h2 class="section-title">Thống Kê Doanh Thu</h2>
                <%
                    DonHangDAO donHangDAO = new DonHangDAO();
                    List<DonHang> donHangList =  donHangDAO.getDonHangByNCC(Integer.parseInt(request.getParameter("idNcc")));
                    if (donHangList != null && !donHangList.isEmpty()) {
                        Map<String, ArrayList<DonHang>> donHangMap = new HashMap<>();
                        for (DonHang dh: donHangList) {
                            int month = dh.getMonth();
                            int year = dh.getYear();
                            String key = month + "/" + year;
                            ArrayList<DonHang> tmp = donHangMap.get(key) != null ? donHangMap.get(key) : new ArrayList<>();
                            tmp.add(dh);
                            donHangMap.put(key, tmp);
                        }
                        Map<String, ArrayList<DonHang>> sortedDonHangMap = new TreeMap<>(new Comparator<String>() {
                            @Override
                            public int compare(String o1, String o2) {
                                int month1 = Integer.parseInt(o1.split("/")[0]);
                                int year1 = Integer.parseInt(o1.split("/")[1]);
                                int month2 = Integer.parseInt(o2.split("/")[0]);
                                int year2 = Integer.parseInt(o2.split("/")[1]);
                                if (year1 != year2) {
                                    return year2 - year1;
                                }
                                return month2 - month1;
                            }
                        });
                        sortedDonHangMap.putAll(donHangMap);
                        for (Map.Entry<String, ArrayList<DonHang>> entry : sortedDonHangMap.entrySet()) {
                            String key = entry.getKey();
                            ArrayList<DonHang> donHangListThang = entry.getValue();
                %>
                            <div class="month-sales">
                                <h3 class="month-title"><%= "Tháng " + key %></h3>
                                <div class="table-container">
                                    <table class="table table-dark table-striped table-hover text-center" id="donHang-tbl">
                                        <thead>
                                        <tr>
                                            <th>Số thứ tự</th>
                                            <th>Mã Đơn Hàng</th>
                                            <th>Ngày Đặt</th>
                                            <th>Tổng Tiền</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            int cnt = 1;
                                            for (DonHang donHang : donHangListThang) {
                                        %>
                                        <tr data-href="gdTTDonHang.jsp?idDh=<%= donHang.getId() %>">
                                            <td><%= cnt++ %></td>
                                            <td><%= "DH" + donHang.getId() %></td>
                                            <td><%= donHang.getImportDate() %></td>
                                            <td><%= donHang.getTotalAmountString() %> VND</td>
                                        </tr>
                                        <% } %>
                                        </tbody>
                                    </table>
                                    <br>
                                </div>
                            </div>

                    <%
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const rows = document.querySelectorAll("#donHang-tbl tbody tr");

        rows.forEach(row => {
            row.addEventListener("click", function () {
                const href = this.getAttribute("data-href"); // Lấy URL từ data-href
                if (href) {
                    window.location.href = href; // Chuyển hướng sang trang mới
                }
            });

            // Thêm hiệu ứng con trỏ chuột để chỉ rõ hàng có thể click
            row.style.cursor = "pointer";
        });
    });
</script>
</body>
</html>