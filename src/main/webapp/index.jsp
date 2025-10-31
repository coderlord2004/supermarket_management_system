<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = (String) request.getAttribute("error");
%>
<%@ include file="layout/head.jsp" %>
<html lang="vi">
<head>
    <title>Đăng nhập - Hệ thống quản lý siêu thị</title>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-indigo-500 to-purple-600 p-6">
    <div class="flex flex-col md:flex-row bg-white rounded-2xl overflow-hidden shadow-2xl max-w-5xl w-full">

        <div class="md:flex-1 bg-cover bg-center flex flex-col justify-center items-center text-white text-center p-10"
             style="background-image: linear-gradient(rgba(102,126,234,0.7), rgba(118,75,162,0.7)), url('https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60');">
            <h1 class="text-3xl font-semibold mb-3">Hệ Thống Quản Lý Siêu Thị</h1>
            <p class="text-base max-w-xs opacity-90">
                Quản lý kho, bán hàng và khách hàng một cách hiệu quả và chuyên nghiệp
            </p>
        </div>

        <div class="md:flex-1 p-10 flex flex-col justify-center">

            <div class="flex items-center mb-6">
                <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center text-white text-xl font-bold mr-3">
                    <i class="fas fa-store"></i>
                </div>
                <div class="text-2xl font-bold bg-gradient-to-r from-indigo-500 to-purple-600 bg-clip-text text-transparent">
                    SuperMart
                </div>
            </div>

            <h2 class="text-2xl font-semibold text-gray-800 mb-1">Đăng Nhập</h2>
            <p class="text-gray-500 text-sm mb-6">Vui lòng đăng nhập để truy cập hệ thống</p>

            <form action="login" method="post" class="space-y-5">

                <div class="relative">
                    <i class="fas fa-user absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" name="username" placeholder="Tên đăng nhập" required
                           class="w-full pl-11 pr-4 py-3 border border-gray-300 rounded-xl text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-400 transition" />
                </div>

                <div class="relative">
                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="password" name="password" placeholder="Mật khẩu" required
                           class="w-full pl-11 pr-4 py-3 border border-gray-300 rounded-xl text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-400 transition" />
                </div>

                <div class="relative">
                    <i class="fas fa-user-tag absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <select name="role" required
                            class="w-full pl-11 pr-4 py-3 border border-gray-300 rounded-xl text-gray-700 bg-white focus:outline-none focus:ring-2 focus:ring-indigo-400 transition">
                        <option value="">Chọn vai trò</option>
                        <option value="customer">Khách hàng</option>
                        <option value="warehouse_staff">Nhân viên kho</option>
                    </select>
                </div>

                <button type="submit"
                        class="w-full py-3 bg-gradient-to-r from-indigo-500 to-purple-600 text-white font-semibold rounded-xl shadow-md hover:shadow-xl hover:-translate-y-0.5 transition">
                    <i class="fas fa-sign-in-alt mr-2"></i> Đăng nhập
                </button>
            </form>

            <% if (error != null) { %>
                <div class="mt-5 bg-red-100 border-l-4 border-red-500 text-red-700 px-4 py-3 rounded-lg text-center text-sm">
                    <i class="fas fa-exclamation-circle mr-1"></i> <%= error %>
                </div>
            <% } %>

            <div class="text-center text-sm mt-6 text-gray-600">
                Chưa có tài khoản?
                <a href="Register.jsp" class="text-indigo-500 font-medium hover:underline">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
