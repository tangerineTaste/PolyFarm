<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 농작물 쇼핑몰</title>
    <link rel="stylesheet" href="styles/styles.css">
    <style>
        /* 로고 링크 스타일 */
        .logo a {
            text-decoration: none; /* 밑줄 제거 */
            color: black; /* 글자 색상 검정색 */
        }

        .logo a:hover {
            color: black; /* 마우스를 올렸을 때도 색상 유지 */
        }

        /* 상단바 스타일 */
        header {
            display: flex;
            align-items: center;
            justify-content: space-between; /* 공간을 균등하게 분배 */
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
            justify-content: center; /* 중앙 정렬 */
            flex-grow: 1; /* 여유 공간을 모두 차지하여 중앙으로 배치 */
        }

        .logo h1 {
            margin: 0;
            padding-left: 10px;
        }

        /* 가운데 정렬 */
        .login-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .login-form form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        #button{
            width: 100%;
            padding: 12px;
            background-color: #2fb380; /* 메인 색상 */
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        #button:hover {
            background-color: #249c6b; /* 버튼 호버 색상 */
        }
        
    </style>
</head>
<body>
    <header>
        <div class="logoimage">
            <img src="images/logo1.png" alt="로고" width="100" height="100">
        </div>
        <div class="logo">
            <a href="index.jsp">
                <h1>POLY FARM</h1>
            </a>
        </div>
        <div style="width: 100px;">&nbsp;</div> <!-- 오른쪽 여유 공간 -->
    </header>
    <main>
        <section class="login-form">
            <h2>로그인</h2>
            <form action="loginAction.jsp" method="post">
                <label for="username">이메일:</label>
                <input type="text" id="userEmail" name="userEmail" required>
                
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
                
                <button type="submit" id = "button">로그인</button>
        
                <button type="button" onclick="location.href='FindPassword.jsp'" id = "button" style="margin:10px;">비밀번호 찾기</button>
            </form>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
</body>
</html>

