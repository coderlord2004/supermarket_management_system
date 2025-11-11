<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.WarehouseStaff, model.OrderDetail, model.Order, model.DeliveryStaff" %>
<%
    Order order = (Order) request.getAttribute("order");
    List<OrderDetail> orderDetails = order != null ? order.getOrderDetails() : Collections.emptyList();
    DeliveryStaff deliveryStaff = (DeliveryStaff) request.getAttribute("deliveryStaff");

    WarehouseStaff warehouseStaff = (WarehouseStaff) session.getAttribute("warehouseStaff");
    if (warehouseStaff == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    String updateOrderSuccess = (String) request.getAttribute("updateOrderSuccess");

    request.setAttribute("title", "Hóa đơn");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn</title>
    <%@ include file="layout/head.jsp" %>
    <style>
        @media print {
            button, a, .no-print { display: none !important; }
            body { background: white; color: black; }
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-200 min-h-screen p-8">
<div class="max-w-4xl mx-auto">

    <% if (error != null) { %>
        <div class="bg-red-600/30 border border-red-500 text-red-200 px-4 py-3 rounded-lg mb-6">
            <strong class="font-semibold">Lỗi!</strong> <span><%= error %></span>
        </div>
    <% } %>
    <% if (success != null) { %>
        <div class="bg-green-600/30 border border-green-500 text-green-200 px-4 py-3 rounded-lg mb-6">
            <strong class="font-semibold"></strong> <span><%= success %></span>
        </div>
    <% } %>
    <% if (updateOrderSuccess != null) { %>
        <div class="bg-green-600/30 border border-green-500 text-green-200 px-4 py-3 rounded-lg mb-6">
            <strong class="font-semibold"></strong> <span><%= updateOrderSuccess %></span>
        </div>
    <% } %>

    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 space-y-4 sm:space-y-0">
        <div>
            <h1 class="text-3xl font-bold bg-gradient-to-r from-indigo-400 to-blue-400 bg-clip-text text-transparent">
                Hóa đơn bán hàng
            </h1>
            <div class="mt-2 flex items-center space-x-2">
                <a href="/WarehouseStaffView.jsp"
                   class="text-indigo-400 hover:underline flex items-center gap-1 no-print">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span>/</span>
                <a href="/orders"
                   class="text-indigo-400 hover:underline flex items-center gap-1 no-print">
                   Duyệt đơn hàng
                </a>
                <span>/</span>
                <span>Hóa đơn</span>
            </div>
        </div>
        <div class="bg-slate-800/50 border border-slate-700 rounded-lg px-4 py-2 text-sm shadow-lg flex flex-col items-center justify-center">
            <h1 class="font-bold bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent mb-2 text-[110%]">Hệ thống quản lý siêu thị</h1>
            <div>
                Nhân viên kho: <span class="text-indigo-400 font-semibold"><%= warehouseStaff.getName() %></span> |
                <a href="index.jsp" class="text-red-400 hover:text-red-300 hover:underline">Đăng xuất</a>
            </div>
        </div>
    </div>

    <form action="/invoice" method="POST" class="bg-gray-800 rounded-xl p-6 shadow-lg border border-gray-700">
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-cyan-400">HÓA ĐƠN BÁN HÀNG</h2>
            <p class="text-gray-400 text-sm">
                Ngày in hóa đơn: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) %>
            </p>
        </div>

        <div class="mb-8">
            <h5 class="text-lg text-cyan-400 mb-3 font-medium">Thông tin đơn hàng</h5>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 text-sm">
                <p><b>Mã đơn hàng:</b> <%= order.getId() %></p>
                <p><b>Ngày đặt:</b> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate()) %></p>
                <p><b>Tên khách hàng:</b> <%= order.getCustomer().getName() %></p>
                <p><b>SĐT:</b> <%= order.getCustomer().getPhoneNumber() %></p>
                <p class="sm:col-span-2"><b>Địa chỉ giao hàng:</b> <%= order.getShippingAddress() %></p>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-700 text-sm">
                <thead class="bg-gray-700 text-gray-300 uppercase">
                    <tr>
                        <th class="px-4 py-2 text-left">#</th>
                        <th class="px-4 py-2 text-left">Mã SP</th>
                        <th class="px-4 py-2 text-left">Tên sản phẩm</th>
                        <th class="px-4 py-2 text-center">Đơn giá (VNĐ)</th>
                        <th class="px-4 py-2 text-center">Số lượng</th>
                        <th class="px-4 py-2 text-left">Ghi chú</th>
                        <th class="px-4 py-2 text-right">Thành tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 1;
                        float totalAmount = 0;
                        for (OrderDetail detail : orderDetails) {
                            float sub = detail.getQuantity() * detail.getUnitPrice();
                            totalAmount += sub;
                    %>
                    <tr class="border-t border-gray-700 hover:bg-gray-750 transition">
                        <td class="px-4 py-2"><%= i++ %></td>
                        <td class="px-4 py-2"><%= detail.getProduct().getId() %></td>
                        <td class="px-4 py-2"><%= detail.getProduct().getName() %></td>
                        <td class="px-4 py-2 text-center"><%= String.format("%,.0f", detail.getUnitPrice()) %></td>
                        <td class="px-4 py-2 text-center"><%= detail.getQuantity() %></td>
                        <td class="px-4 py-2"><%= detail.getNote() != null ? detail.getNote() : "-" %></td>
                        <td class="px-4 py-2 text-right text-teal-400 font-semibold"><%= String.format("%,.0f", sub) %></td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr class="bg-gray-700">
                        <td colspan="6" class="px-4 py-2 text-right font-bold">Tổng cộng:</td>
                        <td class="px-4 py-2 text-right text-green-400 font-semibold"><%= String.format("%,.0f ₫", totalAmount) %></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="mt-6">
            <h5 class="text-lg text-cyan-400 mb-2 font-medium">Nhân viên giao hàng</h5>
            <p><b>Mã NV:</b> <%= deliveryStaff.getId() %></p>
            <p><b>Tên NV:</b> <%= deliveryStaff.getName() %></p>
        </div>

        <div action="/invoice" method="POST" class="text-center mt-8 no-print">
            <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
            <input type="hidden" name="deliveryStaffId" value="<%= deliveryStaff.getId() %>"/>
            <button type="submit"
                    class="bg-teal-500 hover:bg-teal-400 text-white px-6 py-2 rounded-lg font-medium transition">
                <i class="fa-solid fa-print"></i> In hóa đơn
            </button>
        </div>
    </div>
</div>
</body>
</html>
