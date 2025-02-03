<%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 11/10/2024
  Time: 7:07 PM
  To change this template use File | Settings | File Templates.
--%>
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
    <link rel="stylesheet" href="../assets/styles/gdChinhStyle.css">
</head>
<body>
<div class="modal" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notificationModalLabel">Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="notificationMessage">
                <!-- Message will be inserted here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<div class="page-container">
    <!-- Left Panel -->
    <div class="left-panel">
        <div class="profile-section">
            <div class="profile-card text-center">
                <div class="avatar-container mb-3">
                    <img src="../assets/images/avt.svg" alt="Avatar" class="avatar">
                </div>
                <%
                    NhanVienKho nvk = (NhanVienKho) session.getAttribute("nhanvien");
                    System.out.println(nvk);
                %>
                <h5 class="mb-2" style="font-size: 1.1rem;"><%= nvk.getName() %></h5>
                <p class="mb-3" style="font-size: 0.9rem;"><%= nvk.getRole() %></p>
                <div class="personal-info">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-phone me-2"></i>Phone
                        </div>
                        <div class="info-value"><%= nvk.getPhone() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-envelope me-2"></i>Email
                        </div>
                        <div class="info-value"><%= nvk.getEmail() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calendar me-2"></i>Date of Birth
                        </div>
                        <div class="info-value"><%= nvk.getBirth() %></div>
                    </div>
                </div>
            </div>
        </div>

        <button class="logout-btn" onclick="window.location.replace('../index.jsp?err=logout');">
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
                <a href="../nhanvien/NhapHang/gdNhapHang.jsp" class="management-btn btn-supplier">
                    <i class="fas fa-tshirt"></i>
                    Nhập hàng
                </a>
                <a href="#" class="management-btn btn-clothes">
                    <i class="fas fa-tshirt"></i>
                    Xuất hàng
                </a>
                <a href="#" class="management-btn btn-report">
                    <i class="fas fa-truck"></i>
                    Quản lý kho
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const err = urlParams.get('err');
        const success = urlParams.get('success');
        const notificationModal = new bootstrap.Modal(document.getElementById('notificationModal'));
        const notificationMessage = document.getElementById('notificationMessage');
        const notificationModalLabel = document.getElementById('notificationModalLabel');

        notificationModalLabel.setAttribute('style', 'font-size: 2rem;');
        notificationMessage.setAttribute('style', 'font-size: 1.75rem;');
        if (err) {
            notificationModalLabel.textContent = 'Lỗi';
            notificationModalLabel.setAttribute('style', 'color: red;');
            notificationMessage.textContent = getErrorMessage(err);
            notificationMessage.style.color = 'red';
            notificationModal.show();
        } else if (success) {
            notificationModalLabel.textContent = 'Thành công';
            notificationModalLabel.setAttribute('style', 'color: green;');
            notificationMessage.textContent = 'Thêm đơn hàng thành công!';
            notificationMessage.style.color = 'green';
            notificationModal.show();
        }

        function getErrorMessage(errCode) {
            switch (errCode) {
                case '1':
                    return 'Error: Lỗi khi thêm trang phục nhập!';
                case '2':
                    return 'Error: Lỗi khi thêm đơn hàng mới!';
                default:
                    return 'Lỗi không xác định!';
            }
        }
    });
</script>
</body>
</html>