<!-- 1:1 문의 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의</title>
    <link rel="stylesheet" href="styles/styles.css">
</head>
<body>
    <header>
        <h1>1:1 문의</h1>
    </header>
    <main>
        <form action="submit_inquiry.jsp" method="post">
            <label for="subject">제목:</label>
            <input type="text" id="subject" name="subject" required>
            <label for="message">문의 내용:</label>
            <textarea id="message" name="message" required></textarea>
            <button type="submit">제출</button>
        </form>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
</body>
</html>
