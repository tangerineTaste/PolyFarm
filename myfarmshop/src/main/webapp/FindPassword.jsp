<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <style>
        /* 페이지 전체 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9; /* 부드러운 배경색 */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        /* 비밀번호 찾기 카드 스타일 */
        .recovery-card {
            background-color: #ffffff;
            padding: 30px;
            max-width: 400px;
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 카드 그림자 */
            text-align: center;
        }

        .recovery-card h2 {
            margin-bottom: 20px;
            color: #333333;
            font-size: 24px;
        }

        /* 입력란 스타일 */
        .recovery-card label {
            display: block;
            font-size: 14px;
            margin-bottom: 8px;
            color: #666666;
            text-align: left;
        }

        .recovery-card input[type="email"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #dddddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .recovery-card input[type="email"]:focus {
            border-color: #2fb380; /* 포커스 시 강조 */
            outline: none;
        }

        /* 버튼 스타일 */
        .recovery-card button {
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

        .recovery-card button:hover {
            background-color: #249c6b; /* 버튼 호버 색상 */
        }
    </style>
</head>
<body>
    <div class="recovery-card">
        <h2>비밀번호 찾기</h2>
        <form action="sendVerificationCode.jsp" method="post">
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
            <button type="submit">인증 코드 전송</button>
        </form>
    </div>
</body>
</html>
