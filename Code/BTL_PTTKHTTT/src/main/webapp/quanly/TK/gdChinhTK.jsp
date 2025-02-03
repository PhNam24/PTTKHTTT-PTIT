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
            <!-- Store Header -->
            <div class="store-header">
                <div class="store-name">Cửa hàng quần áo ABC</div>
                <div class="store-info">Số 1, Trần Phú, Hà Đông, Hà Nội</div>
                <div class="store-info">0123 456 789</div>
            </div>

            <!-- Management Buttons -->
            <div class="management-buttons">
                <a href="#" class="management-btn btn-supplier">
                    <i class="fas fa-truck"></i>
                    Thống kê theo doanh thu
                </a>
                <a href="gdTKChi.jsp" class="management-btn btn-clothes">
                    <i class="fas fa-tshirt"></i>
                    Thống kê theo doanh chi
                </a>
                <a href="#" class="management-btn btn-return" onclick="window.history.back()" style="background-color: #ff4d4d">
                    <i class="fa fa-arrow-left" aria-hidden="true"></i>
                    Trở về
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>