<%@ page import="com.mysql.cj.Session" %><%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 11/11/2024
  Time: 4:19 PM
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
    <form id="supplierForm" action="../QLTTNCC/confirm.jsp" method="post" onsubmit="return submitForm(this)">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="name" class="form-label">Tên</label>
          <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="phone" class="form-label">Số điện thoại</label>
          <input type="tel" class="form-control" id="phone" name="phone" required>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="address" class="form-label">Địa chỉ</label>
          <input type="text" class="form-control" id="address" name="address" required>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="startDate" class="form-label">Ngày bắt đầu hợp đồng</label>
          <input type="date" class="form-control" id="startDate" name="startDate" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="endDate" class="form-label">Ngày hết hạn hợp đồng</label>
          <input type="date" class="form-control" id="endDate" name="endDate" required>
        </div>
      </div>

      <div id="paymentAccounts">
        <!-- Payment accounts will be added here -->
      </div>

      <button type="button" class="btn btn-warning mb-4" id="addPaymentAccount">
        <i class="fas fa-plus"></i> Thêm tài khoản thanh toán
      </button>

      <div class="d-flex gap-2">
          <button type="submit" class="btn btn-success">
            <i class="fas fa-save"></i> Lưu
          </button>
        <button type="button" class="btn btn-primary" id="backButton">
          <i class="fas fa-arrow-left"></i> Trở về
        </button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
<script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('supplierForm');
    const addPaymentAccountBtn = document.getElementById('addPaymentAccount');
    const paymentAccountsContainer = document.getElementById('paymentAccounts');
    const backButton = document.getElementById('backButton');

    // Add payment account
    addPaymentAccountBtn.addEventListener('click', function () {
      const accountDiv = document.createElement('div');
      accountDiv.className = 'payment-account';
      accountDiv.innerHTML = `
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="mb-0">Tài khoản thanh toán></h5>
                        <button type="button" class="btn btn-danger btn-sm remove-account">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngân hàng</label>
                            <input type="text" class="form-control" name="bankName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số tài khoản</label>
                            <input type="text" class="form-control" name="accountNumber" required>
                        </div>
                    </div>
                `;
      paymentAccountsContainer.appendChild(accountDiv);
      // Remove account button handler
      accountDiv.querySelector('.remove-account').addEventListener('click', function () {
        accountDiv.remove();
      });
    });

    // Back button
    backButton.addEventListener('click', function () {
      // Add your back navigation logic here
      window.history.back();
    });

    // Validate end date is after start date
    const startDate = document.getElementById('startDate');
    const endDate = document.getElementById('endDate');

    endDate.addEventListener('change', function () {
      if (startDate.value && endDate.value) {
        if (new Date(endDate.value) <= new Date(startDate.value)) {
          alert('Ngày hết hạn phải sau ngày bắt đầu');
          endDate.value = '';
        }
      }
    });
  });

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
    form.action = `http://localhost:8080/BTL_PTTKHTTT_war_exploded/quanly/QLTTNCC/confirm.jsp?listName=` + listName + `&listStk=` + listStk;
    return true; // Cho phép form submit
  }

  let notificationTimeout;

  function showLoginError() {
    const notification = document.getElementById('notification');
    notification.classList.add('show');

    // Tự động ẩn thông báo sau 3 giây
    clearTimeout(notificationTimeout);
    notificationTimeout = setTimeout(() => {
    hideNotification();
  }, 3000);
  }

  function hideNotification() {
    const notification = document.getElementById('notification');
    notification.classList.remove('show');
    clearTimeout(notificationTimeout);
  }
</script>
</body>
</html>