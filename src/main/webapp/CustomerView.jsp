<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer, model.Product" %>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f7f9fc;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 50px;
        }
        .container {
            background: white;
            width: 900px;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        h2 { color: #333; margin-bottom: 10px; }
        form {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }
        input[type="search"] {
            width: 80%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        button {
            padding: 10px 20px;
            background: #4a90e2;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }
        button:hover { background: #357ab8; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }
        th { background: #4a90e2; color: white; }
        tr:nth-child(even) { background: #f2f2f2; }
        a.action {
            text-decoration: none;
            color: #4a90e2;
            font-weight: bold;
        }
        a.logout {
            display: inline-block;
            margin-top: 15px;
            color: #e74c3c;
            text-decoration: none;
        }
        a.logout:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h2>Xin chào, <%= customer.getName() %>!</h2>

    <form action="products" method="get">
        <input type="search" name="query" placeholder="Tìm kiếm sản phẩm..." />
        <button type="submit">Tìm kiếm</button>
    </form>

    <table>
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã sản phẩm</th>
            <th>Tên sản phẩm</th>
            <th>Giá (VNĐ)</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= String.format("%,.0f", p.getPrice()) %></td>
            <td><a class="action" href="productDetail?id=<%= p.getId() %>">Xem chi tiết</a></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="5">Không có sản phẩm nào được tìm thấy.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <a class="logout" href="index.jsp">Đăng xuất</a>
</div>
</body>
</html>
