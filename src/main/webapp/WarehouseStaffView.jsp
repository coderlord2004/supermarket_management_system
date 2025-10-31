<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.WarehouseStaff" %>
<%
    WarehouseStaff warehouseStaff = (WarehouseStaff) session.getAttribute("warehouseStaff");
    if (warehouseStaff == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%@ include file="layout/head.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống quản lý siêu thị</title>
</head>
<body class="bg-gradient-to-br from-dark-900 via-purple-900 to-dark-800 min-h-screen flex items-center justify-center p-4">
    <div class="bg-dark-800/70 backdrop-blur-lg rounded-2xl shadow-2xl p-8 md:p-12 w-full max-w-lg border border-purple-500/20">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent mb-2">
                Hệ thống quản lý siêu thị
            </h1>
            <div class="flex justify-center items-center mt-4 mb-6">
                <div class="w-16 h-16 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 flex items-center justify-center text-white text-xl font-bold shadow-lg">
                    <%= warehouseStaff.getName().charAt(0) %>
                </div>
            </div>
            <h2 class="text-xl font-semibold text-white mb-1">
                Xin chào <span class="text-amber-400"><%= warehouseStaff.getName() %>!</span>
            </h2>
            <p class="text-purple-300 text-sm">
                Bạn đã đăng nhập với vai trò <span class="font-medium text-purple-400">Nhân viên kho</span>
            </p>
        </div>

        <div class="space-y-4">
            <a href="/orders" class="block w-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-medium py-3 px-4 rounded-xl transition-all duration-300 transform hover:-translate-y-1 shadow-lg hover:shadow-xl flex items-center justify-center gap-2">
                <i class="fas fa-clipboard-check"></i>
                <span>Duyệt đơn</span>
            </a>

            <a href="index.jsp" class="block w-full bg-dark-700 hover:bg-dark-600 border border-purple-500/30 text-white font-medium py-3 px-4 rounded-xl transition-all duration-300 flex items-center justify-center gap-2">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>

        <div class="mt-8 pt-6 border-t border-purple-500/20 text-center">
            <p class="text-xs text-purple-300/70">
                Hệ thống quản lý siêu thị &copy; 2025 - Bản quyền thuộc về B22DCCN154.
            </p>
        </div>
    </div>
</body>
</html>