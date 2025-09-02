<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, javax.servlet.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>인증 코드 확인</title>
    <link rel="stylesheet" href="styles/product.css">
    <style>
        /* 페이지 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .verification-card {
            background-color: #ffffff;
            padding: 30px;
            max-width: 400px;
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .verification-card h2 {
            margin-bottom: 20px;
            color: #333333;
            font-size: 24px;
        }

        .verification-card label {
            display: block;
            font-size: 14px;
            margin-bottom: 8px;
            color: #666666;
            text-align: left;
        }

        .verification-card input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #dddddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .verification-card button {
            width: 100%;
            padding: 12px;
            background-color: #2fb380;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .verification-card button:hover {
            background-color: #249c6b;
        }
        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
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
    </style>
</head>
<body>
    <div class="verification-card">
        <h2>인증 코드 확인</h2>
        <form action="verifyCode.jsp" method="post">
            <label for="verificationCode">인증 코드:</label>
            <input type="text" id="verificationCode" name="verificationCode" placeholder="인증 코드를 입력하세요" required>
            <button type="submit">확인</button>
        </form>

        <%
            if (request.getMethod().equals("POST")) {
                String inputCode = request.getParameter("verificationCode");
                String sessionCode = (String) session.getAttribute("verificationCode");
                String email = (String) session.getAttribute("email");

                if (sessionCode != null && sessionCode.equals(inputCode)) {
                    // 인증 성공
                    try {
                        // 데이터베이스 연결
                        String dbURL = "jdbc:mysql://localhost:3306/myfarmshopdb";
                        String dbUser = "root";
                        String dbPassword = "1234";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                        // 이메일에 해당하는 비밀번호 조회
                        String query = "SELECT password FROM users WHERE email = ?";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String password = rs.getString("password");
                            out.println("<p style='color: green;'>인증이 성공했습니다!</p>");
                            out.println("<p>입력하신 이메일의 비밀번호는 다음과 같습니다:</p>");
                            out.println("<p><strong>" + password + "</strong></p>");
                            out.println("<a href='login.jsp'>로그인 페이지로 이동</a>");
                        } else {
                            out.println("<p style='color: red;'>해당 이메일에 대한 정보를 찾을 수 없습니다.</p>");
                        }

                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p style='color: red;'>서버 오류가 발생했습니다. 다시 시도해주세요.</p>");
                    }

                    session.removeAttribute("verificationCode"); // 인증 코드 세션 제거
                } else {
                    // 인증 실패
                    out.println("<p style='color: red;'>인증 코드가 일치하지 않습니다. 다시 시도하세요.</p>");
                }
            }
        %>
    </div>
</body>
</html>
