<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Đăng ký</title>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #43cea2, #185a9d);
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
            width: 380px;
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
            background: #43cea2;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 10px;
            width: 100%;
            font-weight: bold;
            transition: 0.3s;
        }
        button:hover { background: #2ebf91; }
        a {
            display: inline-block;
            margin-top: 12px;
            color: blue;
            text-decoration: none;
            font-size: 14px;
        }
        p { color: red; margin: 5px 0; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>Đăng ký tài khoản</h2>
    <form action="register" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <input type="text" name="name" placeholder="Họ tên" required>
        <input type="text" name="phoneNumber" placeholder="Số điện thoại">
        <input type="text" name="address" placeholder="Địa chỉ">

        <select name="role" required>
            <option value="">Chọn vai trò</option>
            <option value="customer">Khách hàng</option>
            <option value="warehouse_staff">Nhân viên kho</option>
        </select>

        <button type="submit">Đăng ký</button>
    </form>

    <% if (error != null) { %>
        <p><%= error %></p>
    <% }%>

    <a href="index.jsp">Đã có tài khoản? Đăng nhập</a>
</div>
</body>
</html>