<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect("products");
        return;
    }
%>

<html>
<head>
    <title>Chi tiết sản phẩm</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .container {
            background: #fff;
            width: 400px;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            animation: fadeIn 0.6s ease-in-out;
        }

        h2 {
            text-align: center;
            color: #6b21a8;
            margin-bottom: 25px;
        }

        p {
            font-size: 16px;
            margin: 10px 0;
            line-height: 1.5;
        }

        b {
            color: #4a148c;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            background: #9333ea;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-align: center;
        }

        .back-link:hover {
            background: #7e22ce;
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chi tiết sản phẩm</h2>
        <p><b>Mã sản phẩm:</b> <%= product.getId() %></p>
        <p><b>Tên:</b> <%= product.getName() %></p>
        <p><b>Giá:</b> <%= String.format("%,.0f", product.getPrice()) %> VNĐ</p>
        <p><b>Số lượng trong kho:</b> <%= product.getStock() %></p>
        <p><b>Mô tả:</b> <%= product.getDescription() %></p>

        <a href="products" class="back-link">⬅ Quay lại danh sách</a>
    </div>
</body>
</html>
