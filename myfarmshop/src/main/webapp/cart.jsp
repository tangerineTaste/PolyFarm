<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Cart" %>
<%@ page import="com.Item" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니 - 농작물 쇼핑몰</title>
    <link rel="stylesheet" href="styles/styles.css">
    <style>
        .header-container {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-color: #f8f8f8;
        }

        .header-container .logo img {
            width: 100px;
            height: auto;
        }

        .header-container .title {
            flex-grow: 1;
            text-align: center;
        }

        .cart-container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .cart-header h2 {
            margin: 0;
        }

        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }

        .cart-item img {
            width: 100px;
            height: auto;
            border-radius: 10px;
        }

        .cart-item-info {
            flex-grow: 1;
            padding: 0 20px;
        }

        .cart-item-info h3 {
            margin: 0;
        }

        .cart-item-info p {
            margin: 5px 0 0;
        }

        .cart-item-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-item-actions button {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .cart-item-actions button:hover {
            background-color: #d32f2f;
        }

        .cart-summary {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: right;
        }

        .cart-summary p {
            margin: 10px 0;
        }

        .checkout-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .checkout-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header class="header-container">
        <div class="logo">
            <a href="index.jsp" style="text-decoration: none; color: black;">
                <img src="images/logo1.png" alt="로고">
            </a>
        </div>
        <div class="title">
            <a href="index.jsp" style="text-decoration: none; color: black;">
                <h1>POLY FARM</h1>
            </a>
        </div>
    </header>
    <main>
        <div class="cart-container">
            <div class="cart-header">
                <h2>장바구니</h2>
                <a href="index.jsp" class="checkout-button">쇼핑 계속하기</a>
            </div>
            <div class="cart-items">
                <%
                    Cart cart = (Cart) session.getAttribute("cart");
                    if (cart != null && !cart.getItems().isEmpty()) {
                        for (Item item : cart.getItems()) {
                %>
                <div class="cart-item">
                    <img src="images/<%= item.getImage() %>" alt="<%= item.getName() %>">
                    <div class="cart-item-info">
                        <h3><%= item.getName() %></h3>
                        <p>₩<%= item.getPrice() %></p>
                    </div>
                    <div class="cart-item-actions">
                        <form action="removeFromCart.jsp" method="post">
                            <input type="hidden" name="id" value="<%= item.getId() %>">
                            <button type="submit">삭제</button>
                        </form>
                    </div>
                </div>
                <%
                        }
                %>
            </div>
            <div class="cart-summary">
                <p>상품수: <%= cart.getItems().size() %></p>
                <p>상품금액: ₩<%= cart.getTotalPrice() %></p>
                <p>총 결제금액: ₩<%= cart.getTotalPrice() %></p>
                <button class="checkout-button" onclick="location.href='checkout.jsp'">구매하기</button>
            </div>
                <%
                    } else {
                %>
                <p>장바구니가 비어 있습니다.</p>
                <%
                    }
                %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
</body>
</html>








