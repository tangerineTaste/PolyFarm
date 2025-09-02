<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>ㄴㄴ
<%@ page import="com.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 성공</title>
    <link rel="stylesheet" href="styles/styles.css">
    <style>

        .logo a {
            text-decoration: none; 
            color: black;
        }

        .logo a:hover {
            color: black; 
        }

        header {
            display: flex;
            align-items: center;
            justify-content: space-between; 
            padding: 10px 20px;
            background-color: #f8f8f8;
        }

        .logoimage {
            width: 100px;
            height: 100px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center; 
            flex-grow: 1; 
        }

        .logo h1 {
            margin: 0;
            padding-left: 10px;
        }

        .login-confirmation {
            text-align: center;
            padding: 20px;
        }
    </style>
    <script type="text/javascript">
        setTimeout(function(){
            window.location.href = 'index.jsp';
        }, 3000);
    </script>
</head>
<body>
    <header>
        <div class="logoimage">
            <img src="images/logo1.png" alt="ë¡ê³ " width="100" height="100">
        </div>
        <div class="logo">
            <a href="index.jsp">
                <h1>POLY FARM</h1>
            </a>
        </div>
        <div style="width: 100px;">&nbsp;</div> 
    </header>
    <main>
        <section class="login-confirmation">
            <h2>로그인 완료</h2>
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
            <p><%= user.getUsername() %>환영합니다!</p>
            <% } %>
            <p>3초 후 메인 페이지로 돌아갑니다...</p>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트.</p>
    </footer>
</body>
</html>


