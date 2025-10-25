<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Đăng nhập</title>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #f7971e, #ffd200);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-box {
            background: white;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            text-align: center;
            width: 360px;
        }
        h2 { color: #333; margin-bottom: 20px; }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
        }
        button {
            background: #f7971e;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
            transition: 0.3s;
        }
        button:hover { background: #ff9800; }
        a {
            display: inline-block;
            margin-top: 12px;
            color: blue;
            text-decoration: none;
            font-size: 14px;
        }
        p { color: red; margin-top: 5px; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>Đăng nhập</h2>
    <form action="login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <select name="role" required>
            <option value="">Chọn vai trò</option>
            <option value="customer">Khách hàng</option>
            <option value="warehouse_staff">Nhân viên kho</option>
        </select>
        <button type="submit">Đăng nhập</button>
    </form>

    <% if (error != null) { %>
        <p><%= error %></p>
    <% }%>

    <a href="Register.jsp">Chưa có tài khoản? Đăng ký</a>
</div>
</body>
</html>
