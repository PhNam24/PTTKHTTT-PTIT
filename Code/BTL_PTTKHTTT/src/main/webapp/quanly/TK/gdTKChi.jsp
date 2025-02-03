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

      <form action="tkNCC.jsp" method="post">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="startDate" class="form-label">Ngày bắt đầu</label>
            <input type="date" class="form-control" id="startDate" name="startDate">
          </div>
          <div class="col-md-6 mb-3">
            <label for="endDate" class="form-label">Ngày kết thúc</label>
            <input type="date" class="form-control" id="endDate" name="endDate">
          </div>
          <div class="col-md-6 mb-3">
            <button type="submit" class="btn btn-primary"> Lọc </button>
          </div>
        </div>
      </form>

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
      <!-- Table -->
      <%
        if (request.getParameter("startDate") == null && request.getParameter("endDate") == null) {
      %>
        <h2>Thống kê toàn bộ</h2>
      <%
        } else { %>
      <h2>Thống kê từ <%= request.getParameter("startDate") %> đến  <%= request.getParameter("endDate") %></h2>
      <%
        }
      %>
      <div class="table-container">
        <table class="table table-dark table-striped table-hover text-center" id="supplier-table">
          <thead>
          <tr>
            <th scope="col">Số thứ tự</th>
            <th scope="col">Mã nhà cung cấp</th>
            <th scope="col">Tên nhà cung cấp</th>
            <th scope="col">Tổng chi</th>
          </tr>
          </thead>
          <tbody>
          <%
            ThongKeNhaCungCapDAO tknccDAO = new ThongKeNhaCungCapDAO();
            ArrayList<ThongKeNhaCungCap> listTKNCC = new ArrayList<>();
            if (session.getAttribute("tkChi") == null) {
              listTKNCC = tknccDAO.getTKNCC();
            }
            else {
              listTKNCC = (ArrayList<ThongKeNhaCungCap>) session.getAttribute("tkChi");
            }
            int index = 1;
            for (ThongKeNhaCungCap tkncc : listTKNCC) {
          %>
          <tr data-href="gdChiTietNCC.jsp?idNcc=<%= tkncc.getNcc().getId() %>">
            <td><%= index++ %></td>
            <td><%= "NCC" + tkncc.getNcc().getId() %></td>
            <td><%= tkncc.getNcc().getName() %></td>
            <td><%= tkncc.getTongChi() + " vnđ" %></td>
          </tr>
          <%}%>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
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

  document.addEventListener("DOMContentLoaded", function () {
    const rows = document.querySelectorAll("#supplier-table tbody tr");

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