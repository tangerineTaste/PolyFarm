<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Cart" %>
<%@ page import="com.Item" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    int price = Integer.parseInt(request.getParameter("price"));
    String image = request.getParameter("image"); // 이미지 URL 파라미터 추가

    // 세션에서 장바구니 가져오기
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }

    // 장바구니에 아이템 추가
    Item item = new Item(id, name, price, image); // 이미지 URL을 설정
    cart.addItem(item);

    response.setContentType("text/plain");
    response.getWriter().write("success");
%>

