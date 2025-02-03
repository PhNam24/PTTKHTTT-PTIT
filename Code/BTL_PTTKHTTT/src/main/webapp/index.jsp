<%@page language="java" contentType="text/html" pageEncoding="UTF-8"
        import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Cửa hàng quần áo ABC</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="assets/styles/loginStyle.css">
</head>
<body>
<%
    if(request.getParameter("err") !=null && request.getParameter("err").equalsIgnoreCase("fail")){
%>
<div class="notification-container" id="notification">
    <div class="notification-header">
        <h3 class="notification-title">Đăng nhập thất bại</h3>
        <button class="close-button" onclick="hideNotification()">&times;</button>
    </div>
    <p class="notification-message">
        Tên đăng nhập hoặc mật khẩu không chính xác. Vui lòng thử lại!
    </p>
</div><%
    } else if (request.getParameter("err") != null && request.getParameter("err").equalsIgnoreCase("logout")) {
        session.removeAttribute("nhanvien");
    }
%>

<div class="container">
    <header>Đăng nhập</header>
    <form action="doLogin.jsp" method="post">
        <div class="input-field">
            <input type="text" name="username" required>
            <label>Tên đăng nhập</label>
        </div>
        <div class="input-field">
            <input class="password" type="password" name ="password" required>
            <span class="show">SHOW</span>
            <label>Mật khẩu</label>
        </div>
        <div class="button">
            <div class="inner"></div>
            <button>LOGIN</button>
        </div>
    </form>
    <div class="signup">
        Chưa có tài khoản? <a href="#">Đăng ký ngay!</a>
    </div>
</div>
<script>
    var input = document.querySelector('.password');
    var show = document.querySelector('.show');
    show.addEventListener('click', active);
    function active(){
        if(input.type === "password"){
            input.type = "text";
            show.style.color = "#1DA1F2";
            show.textContent = "HIDE";
        }else{
            input.type = "password";
            show.textContent = "SHOW";
            show.style.color = "#111";
        }
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

    window.onload = function() {
        <% if(request.getParameter("err") != null && request.getParameter("err").equalsIgnoreCase("fail")) { %>
        showLoginError();
        <% } %>
    }
</script>
</body>
</html>