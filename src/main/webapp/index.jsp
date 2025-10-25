<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Hệ thống quản lý siêu thị</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .container {
            text-align: center;
            background: rgba(255,255,255,0.1);
            padding: 40px 60px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        a {
            display: inline-block;
            width: 120px;
            margin: 10px;
            padding: 12px 25px;
            background: white;
            color: #333;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            transition: 0.3s;
        }
        a:hover {
            background: #764ba2;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Chào mừng đến với hệ thống quản lý siêu thị!</h2>
    <a href="Register.jsp">Đăng ký</a>
    <a href="Login.jsp">Đăng nhập</a>
</div>
</body>
</html>
