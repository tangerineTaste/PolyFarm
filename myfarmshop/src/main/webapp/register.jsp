<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - E-런 농사</title>
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

        .register-form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }

        .register-form h2 {
            text-align: center;
        }

        .register-form form {
            display: flex;
            flex-direction: column;
        }

        .register-form label {
            margin-bottom: 5px;
        }

        .register-form input {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
        }

        #register {
            padding: 10px;
            background-color: blue;
            color: white;
            border: none;
            cursor: pointer;
        }

        #register:hover {
            background-color: darkblue;
        }
    </style>
    
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 	<script>
	 	$(document).ready(function() {
	 	    $('#email').on('input', function() {
	 	        let email = $('#email').val();
	 	        
	 	        if (email.length === 0) {
	 	            // 입력이 없을 때 초기화
	 	            $('#email').css('border-color', '');
	 	            $('#email_feedback').html('');
	 	            return;
	 	        }
	
	 	        $.ajax({
	 	            url: "emailCheck.jsp", 
	 	            type: "post",
	 	            data: { email: email},
	 	            dataType: 'json',
	 	            success: function(result) {
	 	                if (result.exists) {
	 	                    // 이메일 중복 시 빨간색
	 	                    $("#email").css("border-color", "#dc3545");
	 	                    $("#email_feedback").html("이미 사용 중인 이메일입니다").css("color", "#dc3545");
	 	                    $("#register").css("background-color","gray");
	 	                    
	 	                } else {
	 	                    // 중복되지 않은 경우 초록색
	 	                    $("#email").css("border-color", "#2fb380");
	 	                    $("#email_feedback").html("사용 가능한 이메일입니다").css("color", "#2fb380");
	 	                   $("#register").css("background-color","blue");
	 	                }
	 	            },
	 	            error: function() {
	 	                alert("서버 요청 실패");
	 	            }
	 	        });
	 	    });
	 	});

 		
 	</script>
 	
<script>
    function execPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var roadAddr = data.roadAddress;
                var extraRoadAddr = '';

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
         
                document.getElementById("engAddress").value = data.addressEnglish;

                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
    
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
        <section class="register-form">
            <h2>회원가입</h2>
            <form action="registerAction.jsp" method="post">
                <label for="username">사용자 이름:</label>
                <input type="text" id="username" name="username" required>
                
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" required>
                <div><font id="email_feedback" size="2"></font></div>
                
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
                
                
                <label for="adress">주소:</label>
                <input type="text" id="postcode" name="postcode" placeholder="우편번호" required>
				<input type="button" onclick="execPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소" size="60" required><br>
				<input type="hidden" id="jibunAddress" placeholder="지번주소"  size="60">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"  size="60" required><br>
				<input type="hidden" id="extraAddress" placeholder="참고항목"  size="60">
				<input type="hidden" id="engAddress" placeholder="영문주소"  size="60" ><br>
                
                <input type="submit"  id="register" >회원가입 </input>
            </form>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
</body>
</html>

