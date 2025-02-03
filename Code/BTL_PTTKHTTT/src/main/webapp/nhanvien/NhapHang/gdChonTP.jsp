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
                    session.setAttribute("nccName", request.getParameter("ncc"));
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

            <%-- Form --%>
            <!-- Search Bar -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <button class="btn btn-secondary" id="back-button" onclick="window.history.back()">
                    <i class="fas fa-arrow-left me-2"></i>Trở về
                </button>
                <div class="search-container flex-grow-1 d-flex justify-content-center align-items-center">
                    <input
                            type="text"
                            id="search-input"
                            class="form-control w-75"
                            placeholder="Tìm kiếm nhà cung cấp..."
                    >
                </div>
                <button class="btn btn-primary search-btn ms-2">
                    <i class="fas fa-search"></i> Tìm kiếm
                </button>
            </div>

            <form method="post" action="gdNhapHang.jsp" onsubmit="return submitForm(this)">
                <!-- Action Buttons -->
                <div class="row">
                    <div class="col-md-6">
                        <label for="input-tp">Trang phục đã chọn</label>
                        <input id="input-tp" name="listTP" readonly required>
                    </div>

                    <div class="col-md-6">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-save me-2"></i>Lưu
                        </button>
                    </div>
                </div>
            </form>

                <!-- Import Items Table -->
                <div class="table-container">
                    <table class="table table-dark table-striped table-hover text-center" id="supplier-table">
                        <thead>
                            <tr>
                                <th>Mã TP</th>
                                <th>Tên</th>
                                <th>Ảnh</th>
                                <th>Đơn giá</th>
                                <th>Mô Tả</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                TrangPhucDAO tpDAO = new TrangPhucDAO();
                                List<TrangPhuc> tpList = tpDAO.getAllTP();
                                for (TrangPhuc tp : tpList) {
                            %>
                            <tr>
                                <td>TP<%= tp.getId() %></td>
                                <td><%= tp.getName() %></td>
                                <td>
                                    <img src="../../assets/images/TrangPhuc/<%= tp.getPicture() %>.png"
                                         class="order-product-img">
                                </td>
                                <td><%= tp.getPriceString() %> VND</td>
                                <td><%= tp.getDes() %></td>
                                <td>
                                    <button class="btn btn-sm btn-primary select-clothes"
                                    data-id="<%= tp.getId() %>">
                                        Chọn
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    function submitForm(form) {
        const inputTp = document.getElementById('input-tp');
        if (inputTp.value === '') {
            alert('Vui lòng chọn ít nhất một trang phục!');
            return false;
        }
        form.action = 'gdNhapHang.jsp';
        return true;
    }

    document.getElementById("search-input").addEventListener("keyup", function () {
        const input = this.value.toLowerCase(); // Lấy giá trị nhập vào và chuyển về chữ thường
        const rows = document.querySelectorAll("#supplier-table tbody tr"); // Các hàng trong bảng

        rows.forEach(row => {
            const cells = row.querySelectorAll("td"); // Các cột trong hàng
            const match = Array.from(cells).some(cell =>
                cell.textContent.toLowerCase().includes(input) // Kiểm tra nội dung từng ô
            );

            row.style.display = match ? "" : "none"; // Hiển thị hoặc ẩn hàng
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        const selectButtons = document.querySelectorAll('.select-clothes');
        const inputTp = document.getElementById('input-tp');

        selectButtons.forEach(button => {
            button.addEventListener('click', function() {
                const dataId = this.getAttribute('data-id');
                const value = "TP-" + dataId;

                if (this.classList.contains('btn-primary')) {
                    // Change button color to green
                    this.classList.remove('btn-primary');
                    this.classList.add('btn-success');

                    // Add value to the input
                    inputTp.value += value + ",";
                } else {
                    // Change button color back to blue
                    this.classList.remove('btn-success');
                    this.classList.add('btn-primary');

                    // Remove value from the input
                    const values = inputTp.value.split(',').filter(v => v !== value);
                    inputTp.value = values.join(',');
                }
            });
        });
    });
</script>
</body>
</html>