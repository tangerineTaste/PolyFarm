<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Cart" %>
<%@ page import="com.Item" %>
<%
    // 요청 파라미터에서 item ID 가져오기
    int itemId = Integer.parseInt(request.getParameter("id"));
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart != null) {
        // 장바구니에서 해당 아이템 제거
        cart.getItems().removeIf(item -> item.getId() == itemId);
    }
    // 장바구니 페이지로 리디렉션
    response.sendRedirect("cart.jsp");
%>