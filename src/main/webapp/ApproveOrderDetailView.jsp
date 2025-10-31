<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Order, model.OrderDetail, model.DeliveryStaff, model.WarehouseStaff" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderDetail> orderDetails = order != null ? order.getOrderDetails() : Collections.emptyList();
    List<DeliveryStaff> deliveryStaffs = (List<DeliveryStaff>) request.getAttribute("deliveryStaffs");

    WarehouseStaff warehouseStaff = (WarehouseStaff) session.getAttribute("warehouseStaff");
    if (warehouseStaff == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    request.setAttribute("title", "Duyệt đơn hàng #" + (order != null ? order.getId() : ""));
%>

<!DOCTYPE html>
<html lang="vi">
<%@ include file="layout/head.jsp" %>

<head>
    <style>
        div b {
            color: #FCD34D;
        }
        @layer utilities {
          label:has(input[type="radio"]:checked) {
            @apply bg-teal-700/60 ring-2 ring-teal-400;
          }
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-200 min-h-screen p-8">

<div class="max-w-6xl mx-auto">
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 space-y-4 sm:space-y-0">
        <div>
            <h1 class="text-3xl font-bold bg-gradient-to-r from-indigo-400 to-blue-400 bg-clip-text text-transparent">
                Duyệt chi tiết đơn hàng
            </h1>
            <div class="mt-2 flex items-center space-x-2">
                <a href="/WarehouseStaffView.jsp" class="text-indigo-400 hover:underline flex items-center gap-1">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span>/</span>
                <a href="/orders" class="text-indigo-400 hover:underline flex items-center gap-1">Duyệt đơn hàng</a>
                <span>/</span>
                <span>Đơn hàng #<%= order != null ? order.getId() : "" %></span>
            </div>
        </div>
        <div class="bg-slate-800/50 border border-slate-700 rounded-lg px-4 py-2 text-sm shadow-lg">
            Nhân viên kho: <span class="text-indigo-400 font-semibold"><%= warehouseStaff.getName() %></span> |
            <a href="/index.jsp" class="text-red-400 hover:text-red-300 hover:underline">Đăng xuất</a>
        </div>
    </div>

    <div class="bg-gray-800 rounded-xl p-6 mb-8 shadow-lg border border-gray-700">
        <h5 class="text-lg text-cyan-400 mb-4 font-medium">Thông tin đơn hàng</h5>
        <p><b>Mã đơn hàng:</b> <span><%= order.getId() %></span></p>
        <p><b>Tên khách hàng:</b> <span><%= order.getCustomer().getName() %></span></p>
        <p><b>SĐT:</b> <%= order.getCustomer().getPhoneNumber() %></p>
        <p><b>Địa chỉ giao hàng:</b> <%= order.getShippingAddress() %></p>
        <p><b>Ngày đặt:</b> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate()) %></p>
        <p><b>Trạng thái đơn hàng:</b>
            <% if (order.getStatus().equals("PENDING")) { %>
                <span class="px-2 py-1 bg-gray-700 rounded text-amber-400">Chờ duyệt</span>
            <% } else { %>
                <span class="px-2 py-1 bg-gray-700 rounded text-blue-500">Đã duyệt</span>
            <% } %>
        </p>
    </div>

    <div class="bg-gray-800 rounded-xl p-6 mb-8 shadow-lg border border-gray-700">
        <h5 class="text-lg text-cyan-400 mb-4 font-medium flex items-center gap-2">
            <i class="fa-solid fa-box"></i> Danh sách sản phẩm
        </h5>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-700 text-sm">
                <thead class="bg-gray-700 text-gray-300 uppercase">
                    <tr>
                        <th class="px-4 py-2 text-left">#</th>
                        <th class="px-4 py-2 text-left">Mã SP</th>
                        <th class="px-4 py-2 text-left">Tên sản phẩm</th>
                        <th class="px-4 py-2 text-right">Giá (VNĐ)</th>
                        <th class="px-4 py-2 text-right">Số lượng</th>
                        <th class="px-4 py-2 text-left">Ghi chú</th>
                        <th class="px-4 py-2 text-right">Thành tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        double total = 0;
                        int i = 1;
                        for (OrderDetail d : orderDetails) {
                            double sub = d.getQuantity() * d.getUnitPrice();
                            total += sub;
                    %>
                    <tr class="border-t border-gray-700 hover:bg-gray-750 transition">
                        <td class="px-4 py-2"><%= i++ %></td>
                        <td class="px-4 py-2"><%= d.getProduct().getId() %></td>
                        <td class="px-4 py-2"><%= d.getProduct().getName() %></td>
                        <td class="px-4 py-2 text-right"><%= String.format("%,.0f", d.getUnitPrice()) %></td>
                        <td class="px-4 py-2 text-right"><%= d.getQuantity() %></td>
                        <td class="px-4 py-2"><%= d.getNote() != null ? d.getNote() : "-" %></td>
                        <td class="px-4 py-2 text-right text-teal-400 font-semibold">
                            <%= String.format("%,.0f", sub) %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-right mt-4">
            <h5 class="text-lg font-medium">Tổng cộng:
                <span class="text-teal-400 font-semibold"><%= String.format("%,.0f", total) %> ₫</span>
            </h5>
        </div>
    </div>

    <div class="bg-gray-800 rounded-xl p-6 shadow-lg border border-gray-700">
        <h5 class="text-lg text-cyan-400 mb-4 font-medium flex items-center gap-2">
            <i class="fa-solid fa-truck"></i> Chọn nhân viên giao hàng
        </h5>
        <form action="/approve-order/assign" method="post" class="space-y-4">
            <input type="hidden" name="orderId" value="<%= order.getId() %>">

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <% for (DeliveryStaff staff : deliveryStaffs) { %>
                      <div>
                          <input
                            id="staff-<%= staff.getId() %>"
                            type="radio"
                            name="staffId"
                            value="<%= staff.getId() %>"
                            class="hidden peer"
                            required
                          />
                          <label for="staff-<%= staff.getId() %>" class="flex items-center justify-between bg-gray-700/50 p-4 rounded-lg hover:bg-gray-700 cursor-pointer transition peer-checked:bg-teal-700/60 peer-checked:ring-2 peer-checked:ring-teal-400">
                                <div class="font-medium">
                                      <p>Mã NV: <%= staff.getId() %></p>
                                      <p>Tên: <%= staff.getName() %></p>
                                </div>
                          </label>
                      </div>
              <% } %>
            </div>

            <div class="w-full text-center pt-6">
                <button
                    type="submit"
                    class="bg-teal-500 hover:bg-teal-400 text-white px-6 py-2 rounded-lg font-medium transition"
                >
                    <i class="fa-solid fa-check"></i> Xác nhận duyệt đơn
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
