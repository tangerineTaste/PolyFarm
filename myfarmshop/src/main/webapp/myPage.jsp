<!-- 마이 페이지 미완성 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <link rel="stylesheet" href="styles/styles.css">
</head>
<body>
    <header>  
    </header>
    <main>
        <h1>환영합니다, <%= user.getUsername() %>!</h1>
        <p>여기는 개인 페이지입니다.</p>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
</body>
</html>
