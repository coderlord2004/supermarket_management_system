<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.WarehouseStaff, model.Order, model.Customer" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Locale" %>

<%
    WarehouseStaff warehouseStaff = (WarehouseStaff) session.getAttribute("warehouseStaff");
    if (warehouseStaff == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    SimpleDateFormat vnDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss", new Locale("vi", "VN"));
%>

<html>
<head>
    <title>Duyệt đơn hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-gradient-to-br from-slate-900 to-slate-800 text-gray-100 min-h-screen font-sans">
<div class="max-w-7xl mx-auto p-6">

    <!-- Header -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 space-y-4 sm:space-y-0">
        <div>
            <h1 class="text-3xl font-bold bg-gradient-to-r from-indigo-400 to-blue-400 bg-clip-text text-transparent">
                Duyệt đơn hàng
            </h1>
            <div class="mt-2 flex items-center space-x-2">
                <a href="WarehouseStaffView.jsp" class="text-indigo-400 hover:underline flex items-center gap-1">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span>/</span>
                <span>Duyệt đơn hàng</span>
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

    <!-- Card -->
    <div class="bg-slate-800/60 border border-slate-700 rounded-xl shadow-xl overflow-hidden backdrop-blur-md">
        <div class="px-6 py-4 border-b border-slate-700 flex items-center justify-between">
            <h2 class="text-lg font-semibold text-gray-100 flex items-center gap-2">
                <i class="fas fa-clipboard-list text-indigo-400"></i>
                Danh sách đơn hàng
                <span class="text-amber-300">(Tổng cộng <%= orders != null ? orders.size() : 0 %> đơn)</span>
            </h2>
        </div>

        <div class="overflow-x-auto">
            <% if (orders == null || orders.isEmpty()) { %>
                <div class="py-16 text-center text-gray-400">
                    <i class="far fa-clipboard text-5xl mb-4 opacity-60"></i>
                    <p>Không có đơn hàng nào cần duyệt.</p>
                </div>
            <% } else { %>
                <table class="min-w-full text-sm">
                    <thead class="bg-slate-700/50 text-indigo-300 uppercase text-xs">
                    <tr>
                        <th class="px-4 py-3 text-left">#</th>
                        <th class="px-4 py-3 text-left">Mã</th>
                        <th class="px-4 py-3 text-left">Tên khách hàng</th>
                        <th class="px-4 py-3 text-left">Số điện thoại</th>
                        <th class="px-4 py-3 text-left">Địa chỉ giao hàng</th>
                        <th class="px-4 py-3 text-left">Ngày đặt hàng</th>
                        <th class="px-4 py-3 text-left">Trạng thái</th>
                        <th class="px-4 py-3 text-left">Ngày duyệt đơn</th>
                        <th class="px-4 py-3 text-left">Người duyệt</th>
                        <th class="px-4 py-3 text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-700">
                    <% for (int i=0; i<orders.size(); i++) {
                        Order order = orders.get(i);
                        Customer customer = order.getCustomer();
                        WarehouseStaff approver = order.getWarehouseStaff();

                        String status = order.getStatus() == null ? "" : order.getStatus();
                        String statusText;
                        String statusColor;
                        if (status.equals("EXPORTED")) {
                            statusText = "Đã duyệt";
                            statusColor = "bg-blue-900/40 text-blue-400";
                        } else {
                            statusText = "Chờ duyệt";
                            statusColor = "bg-amber-900/40 text-amber-400";
                        }
                    %>
                        <tr class="hover:bg-slate-700/40 transition">
                            <td class="px-4 py-3 font-medium text-gray-100"><%= (i+1) %></td>
                            <td class="px-4 py-3 font-medium text-gray-100"><%= order.getId() %></td>
                            <td class="px-4 py-3"><%= customer != null ? customer.getName() : "—" %></td>
                            <td class="px-4 py-3"><%= customer != null ? customer.getPhoneNumber() : "—" %></td>
                            <td class="px-4 py-3"><%= order.getShippingAddress() %></td>
                            <td class="px-4 py-3"><%= order.getOrderDate() != null ? vnDateFormat.format(order.getOrderDate()) : "—" %></td>
                            <td class="px-4 py-3">
                                <span class="px-3 py-1 rounded-full text-xs font-semibold <%= statusColor %>">
                                    <%= statusText %>
                                </span>
                            </td>
                            <td class="px-4 py-3">
                                <%= order.getApprovedDate() != null ? vnDateFormat.format(order.getApprovedDate()) : "—" %>
                            </td>
                            <td class="px-4 py-3">
                                <%= approver != null ? approver.getName() : "—" %>
                            </td>
                            <td class="px-4 py-3 text-center">
                                <% if ("PENDING".equals(order.getStatus()) || "NEW".equals(order.getStatus())) { %>
                                    <form action="/approve-order/detail" method="GET" class="inline">
                                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                        <input type="hidden" name="warehouseStaffId" value="<%= warehouseStaff.getId() %>">
                                        <button type="submit"
                                            class="inline-flex items-center gap-2 px-4 py-2 bg-emerald-600 hover:bg-emerald-500
                                                   text-white rounded-lg font-medium shadow-md transition">
                                            <i class="fas fa-check"></i> Duyệt
                                        </button>
                                    </form>
                                <% } else { %>
                                    <span class="text-gray-500">—</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
