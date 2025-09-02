<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.User, com.UserDAO" %>
<%
    String userEmail = request.getParameter("userEmail");
    String password = request.getParameter("password");

    User user = UserDAO.loginUser(userEmail, password);

    if (user != null) {
        session.setAttribute("user", user);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("password", user.getPassword());
        response.sendRedirect("login-success.jsp");
    } else {
        response.sendRedirect("login-failure.jsp");
    }
%>
