<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect("products");
        return;
    }
%>
<%@ include file="layout/head.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                        }
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.6s ease-out',
                        'slide-up': 'slideUp 0.4s ease-out',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0', transform: 'translateY(-8px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' },
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
    <div class="max-w-4xl mx-auto">
        <div class="text-center mb-8 animate-fade-in">
            <h1 class="text-4xl font-bold bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent mb-2">
                Hệ thống quản lý siêu thị
            </h1>
            <p class="text-purple-200 text-xl">Chi tiết sản phẩm</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <div class="bg-dark-800/50 backdrop-blur-lg rounded-2xl shadow-2xl border border-purple-500/20 p-6 animate-slide-up">
                <div class="w-full h-64 bg-gradient-to-br from-purple-600/20 to-pink-600/20 rounded-xl flex items-center justify-center mb-4 border border-purple-500/30">
                    <i class="fas fa-box text-6xl text-purple-400/60"></i>
                </div>
                <div class="text-center">
                    <h3 class="text-2xl font-bold text-white mb-2"><%= product.getName() %></h3>
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-purple-500/10 border border-purple-500/30 rounded-full">
                        <i class="fas fa-tag text-purple-400"></i>
                        <span class="text-purple-300 font-semibold">Mã: <%= product.getId() %></span>
                    </div>
                </div>
            </div>

            <div class="bg-dark-800/50 backdrop-blur-lg rounded-2xl shadow-2xl border border-purple-500/20 p-8 animate-slide-up">
                <div class="flex items-center gap-3 mb-6">
                    <div class="w-10 h-10 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 flex items-center justify-center text-white">
                        <i class="fas fa-info"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-white">Thông tin chi tiết</h2>
                </div>

                <div class="space-y-6">
                    <div class="flex items-start gap-4">
                        <div class="w-8 h-8 rounded-full bg-purple-500/10 flex items-center justify-center mt-1">
                            <i class="fas fa-cube text-purple-400 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-purple-300 font-semibold mb-1">Tên sản phẩm</p>
                            <p class="text-white text-lg"><%= product.getName() %></p>
                        </div>
                    </div>

                    <div class="flex items-start gap-4">
                        <div class="w-8 h-8 rounded-full bg-green-500/10 flex items-center justify-center mt-1">
                            <i class="fas fa-tag text-green-400 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-purple-300 font-semibold mb-1">Giá bán</p>
                            <p class="text-green-400 font-bold text-xl">
                                <%= String.format("%,.0f", product.getPrice()) %> VNĐ
                            </p>
                        </div>
                    </div>

                    <div class="flex items-start gap-4">
                        <div class="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center mt-1">
                            <i class="fas fa-boxes text-blue-400 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-purple-300 font-semibold mb-1">Số lượng trong kho</p>
                            <div class="flex items-center gap-3">
                                <span class="text-white text-lg"><%= product.getStock() %> sản phẩm</span>
                                <% if (product.getStock() > 0) { %>
                                    <span class="px-2 py-1 bg-green-500/20 text-green-400 text-xs rounded-full border border-green-500/30">
                                        <i class="fas fa-check mr-1"></i>Còn hàng
                                    </span>
                                <% } else { %>
                                    <span class="px-2 py-1 bg-red-500/20 text-red-400 text-xs rounded-full border border-red-500/30">
                                        <i class="fas fa-times mr-1"></i>Đã hết hàng
                                    </span>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-start gap-4">
                        <div class="w-8 h-8 rounded-full bg-yellow-500/10 flex items-center justify-center mt-1">
                            <i class="fas fa-file-alt text-yellow-400 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-purple-300 font-semibold mb-1">Mô tả sản phẩm</p>
                            <div class="bg-gray-900/50 border border-purple-500/20 rounded-xl p-4">
                                <p class="text-gray-300 leading-relaxed"><%= product.getDescription() %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-8 pt-6 border-t border-purple-500/20 flex flex-col sm:flex-row gap-4">
                    <a href="/products"
                       class="flex-1 inline-flex items-center justify-center gap-2 px-6 py-3.5 bg-gray-700 hover:bg-gray-600 text-white font-semibold rounded-xl transition-all duration-300 transform hover:-translate-y-0.5 border border-gray-600 hover:border-gray-500">
                        <i class="fas fa-arrow-left"></i>
                        <span>Quay lại danh sách</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>