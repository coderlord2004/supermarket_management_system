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
<%@ include file="layout/head.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        primary: {
                            500: '#8b5cf6',
                            600: '#7c3aed',
                            700: '#6d28d9',
                        },
                        dark: {
                            800: '#1f2937',
                            900: '#111827',
                        },
                        accent: {
                            400: '#34d399',
                            500: '#10b981',
                        }
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-up': 'slideUp 0.3s ease-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' },
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(10px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' },
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-purple-900 to-gray-900 text-gray-100 py-8 px-4">
    <div class="max-w-6xl mx-auto">
        <!-- Header -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
            <div>
                <h1 class="text-3xl font-bold bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
                    Hệ thống quản lý siêu thị
                </h1>
                <div class="flex items-center gap-3 mt-2">
                    <div class="w-10 h-10 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 flex items-center justify-center text-white font-bold shadow-lg">
                        <%= customer.getName().charAt(0) %>
                    </div>
                    <div>
                        <h2 class="text-xl font-semibold text-white">
                            Xin chào, <span class="text-purple-300"><%= customer.getName() %></span>!
                        </h2>
                        <p class="text-sm text-purple-200/70">Khách hàng</p>
                    </div>
                </div>
            </div>

            <a href="index.jsp" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-red-500 to-pink-500 hover:from-red-600 hover:to-pink-600 text-white font-medium transition-all duration-300 transform hover:-translate-y-0.5 shadow-lg hover:shadow-red-500/25 flex items-center gap-2">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>

        <!-- Search Form -->
        <div class="bg-dark-800/50 backdrop-blur-lg p-6 rounded-2xl shadow-xl border border-purple-500/20 mb-8 animate-fade-in">
            <form action="products" method="get" class="flex flex-col md:flex-row gap-4">
                <div class="flex-1 relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-search text-purple-400"></i>
                    </div>
                    <input
                        type="search"
                        name="query"
                        placeholder="Tìm kiếm sản phẩm..."
                        class="w-full pl-10 pr-4 py-3.5 rounded-xl bg-gray-900/80 text-gray-200 border border-purple-500/30 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent placeholder-gray-400 transition-all duration-300"
                    />
                </div>
                <button
                    type="submit"
                    class="px-8 py-3.5 rounded-xl font-semibold bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white shadow-lg shadow-purple-500/30 transition-all duration-300 transform hover:-translate-y-0.5 flex items-center justify-center gap-2">
                    <i class="fas fa-search"></i>
                    <span>Tìm kiếm</span>
                </button>
            </form>
        </div>

        <!-- Products Table -->
        <div class="bg-dark-800/50 backdrop-blur-lg rounded-2xl shadow-2xl border border-purple-500/20 overflow-hidden animate-slide-up">
            <div class="px-6 py-4 border-b border-purple-500/20 bg-gradient-to-r from-purple-600/20 to-pink-600/20">
                <h3 class="text-xl font-bold text-white flex items-center gap-2">
                    <i class="fas fa-boxes text-purple-400"></i>
                    <span>Danh sách sản phẩm</span>
                </h3>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-sm text-left text-gray-200">
                    <thead class="bg-gradient-to-r from-purple-600 to-pink-600 text-white uppercase text-xs">
                        <tr>
                            <th scope="col" class="px-6 py-4 text-center font-semibold">STT</th>
                            <th scope="col" class="px-6 py-4 text-center font-semibold">Mã sản phẩm</th>
                            <th scope="col" class="px-6 py-4 text-center font-semibold">Tên sản phẩm</th>
                            <th scope="col" class="px-6 py-4 text-center font-semibold">Giá (VNĐ)</th>
                            <th scope="col" class="px-6 py-4 text-center font-semibold">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (products != null && !products.isEmpty()) {
                                int index = 1;
                                for (Product p : products) {
                        %>
                        <tr class="border-b border-purple-500/10 hover:bg-purple-500/10 transition-all duration-200 group">
                            <td class="px-6 py-4 text-center font-medium text-gray-300 group-hover:text-white">
                                <%= index++ %>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="font-semibold text-purple-300 bg-purple-500/10 px-3 py-1 rounded-full">
                                    <%= p.getId() %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-center font-medium text-white">
                                <%= p.getName() %>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="font-bold text-accent-400 bg-green-500/10 px-3 py-1.5 rounded-full">
                                    <%= String.format("%,.0f", p.getPrice()) %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <a href="/product/detail?id=<%= p.getId() %>"
                                   class="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-purple-500/10 hover:bg-purple-500/20 text-purple-300 hover:text-purple-200 font-medium transition-all duration-300 transform hover:-translate-y-0.5 border border-purple-500/30 hover:border-purple-400/50">
                                    <i class="fas fa-eye text-sm"></i>
                                    <span>Xem chi tiết</span>
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="px-6 py-12 text-center">
                                <div class="flex flex-col items-center justify-center text-gray-400">
                                    <i class="fas fa-box-open text-4xl mb-3 text-purple-500/50"></i>
                                    <p class="text-lg font-medium">Không có sản phẩm nào được tìm thấy</p>
                                    <p class="text-sm mt-1">Hãy thử tìm kiếm với từ khóa khác</p>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Footer Stats -->
            <div class="px-6 py-4 border-t border-purple-500/20 bg-gradient-to-r from-purple-600/10 to-pink-600/10">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-purple-200/80">
                    <div class="flex items-center gap-2">
                        <i class="fas fa-info-circle text-purple-400"></i>
                        <span>Tổng số sản phẩm: <strong class="text-white"><%= products != null ? products.size() : 0 %></strong></span>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="flex items-center gap-2">
                            <i class="fas fa-sync-alt text-purple-400"></i>
                            <span>Dữ liệu được cập nhật mới nhất</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>