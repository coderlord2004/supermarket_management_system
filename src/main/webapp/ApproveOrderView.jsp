<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.WarehouseStaff, model.Order" %>
<%
    WarehouseStaff warehouseStaff = (WarehouseStaff) session.getAttribute("warehouseStaff");
    if (warehouseStaff == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<html>
<head>
    <title>Duyệt đơn hàng</title>
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
    <div>
        <h2>Duyệt đơn hàng</h2>

        <% if (orders == null || orders.isEmpty()) { %>
            <p>Không có đơn hàng nào cần duyệt.</p>
        <% } else { %>
            <table border="1" cellpadding="10" cellspacing="0" style="margin: 0 auto; background: white; color: black; border-radius: 8px;">
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Tên khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                <% for (Order order : orders) { %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= order.getCustomer().getName() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getStatus() %></td>
                        <td>
                            <form action="ApproveOrderServlet" method="post" style="display:inline;">
                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                <button type="submit" style="padding: 5px 10px; border-radius: 5px; border: none; background: #4a90e2; color: white; cursor: pointer;">Duyệt</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>


        <a href="WarehouseStaffView.jsp">Quay lại</a>
    </div>
</div>
</body>
</html>
