<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>농작물 쇼핑몰</title>
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

        /* 섹션 스타일 */
        .section {
            padding: 20px;
            margin: 10px;
            border: 2px solid lightgreen; /* 연두색 테두리 */
            border-radius: 5px;
            background-color: #f9f9f9;
            cursor: pointer; /* 클릭 가능한 커서 */
            
            
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        
        }
        

        .section h2 {
            color: #4CAF50;
        }

        .section img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .section p {
            margin-top: 10px;
        }

        /* 2x2 그리드 레이아웃 */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 숨기기 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.9); /* 검은색 배경 투명도 */
        }

        .modal-content {
            margin: 15% auto;
            display: block;
            width: 80%;
            max-width: 700px;
        }

        .close {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }

        .close:hover,
        .close:focus {
            color: #bbb;
            text-decoration: none;
            cursor: pointer;
        }
        .logoimage {
  			width: 280px;
  			margin-bottom: 0px;
		}
    </style>
    
</head>
<body>
    <header>
    <div class="logoimage">
    		<img src="images/logo1.png" alt="로고" width="100" height = "100">
    	</div>
        <div class="logo" >
    		<h1>
        		<a href="index.jsp">POLY FARM</a>
    		</h1>
		</div>
        <div class="user-cart">
        
    	<% String username = (String) session.getAttribute("username"); %>
    
    	<% if (username != null) { %>
        	<span>환영합니다, <%= username %>님!</span>
        	<a href="logout.jsp">로그아웃</a>
        	<a href="cart.jsp">장바구니</a>
        	<a href="myPage.jsp" id="mypage-link">마이페이지</a>
    
    	<% } else { %>
	        <a href="login.jsp">로그인</a>
	        <a href="register.jsp">회원가입</a>
	        <a href="cart.jsp">장바구니</a>
	        <a href="myPage.jsp" id="mypage-link">마이페이지</a>
    	<% } %>
    	<a href="customerService.jsp">고객센터</a>
</div>
    </header>
    <nav>
        <ul>
            <li><a href="shop.jsp">농작물 쇼핑하기</a></li>
            <li><a href="stream.jsp">실시간 농작물 상태 보기</a></li>
            <li><a href="#">기간별 농작물 상태 확인</a></li>
        </ul>
    </nav>
    <main>
        <section class="banner">
            <img src="images/banner1.png" alt="농작물 배너" width="1550">
        </section>
        
        <div class="grid-container">
            <section class="section" onclick="openModal('modal1')">
                <h2>스마트팜이란?</h2>
                <img src="images/smartfarm.png" alt="스마트팜 설명">
                <p>농업에 ICT 기술을 접목해 원격 · 자동으로 최적의 생육환경을 제어할 수 있는 농장</p>
            </section>

            <section class="section" onclick="openModal('modal2')">
                <h2>스마트팜의 이점</h2>
                <img src="images/smartfarm_benefits.png" alt="스마트팜의 이점">
                <p>스마트폰으로 언제 어디서나 감시와 제어가 가능하여 편의성이 증가하고, 센서와 데이터 기반 농사으로 많은 인력이 필요하지 않습니다.</p>
            </section>

            <section class="section" onclick="openModal('modal3')">
                <h2>스마트팜의 적용 사례</h2>
                <img src="images/smartfarm_cases.png" alt="스마트팜의 적용 사례">
                <p>현재 국내에서도 청년들을 위한 창업 시스템 구축과 스마트팜 산업 인프라 구축, 스마트팜 혁신밸리 조성등의 정책을 추진중입니다.</p>
            </section>

            <section class="section" onclick="openModal('modal4')">
                <h2>스마트팜 관련 기술</h2>
                <img src="images/smartfarm_technology.png" alt="스마트팜 관련 기술">
                <p>IoT(사물인터넷) 센서, 드론, 인공지능(AI), 빅데이터 분석, 자동화 시스템 등이 포함됩니다.</p>
            </section>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>

    <!-- 모달 요소들 -->
    <div id="modal1" class="modal">
        <span class="close" onclick="closeModal('modal1')">&times;</span>
        <img class="modal-content" id="modal-img1">
    </div>

    <div id="modal2" class="modal">
        <span class="close" onclick="closeModal('modal2')">&times;</span>
        <img class="modal-content" id="modal-img2">
    </div>

    <div id="modal3" class="modal">
        <span class="close" onclick="closeModal('modal3')">&times;</span>
        <img class="modal-content" id="modal-img3">
    </div>

    <div id="modal4" class="modal">
        <span class="close" onclick="closeModal('modal4')">&times;</span>
        <img class="modal-content" id="modal-img4">
    </div>

    <script>
        function openModal(modalId) {
            var modal = document.getElementById(modalId);
            var img = modal.querySelector(".modal-content");
            var sectionImg = document.querySelector("#" + modalId + " img");
            img.src = sectionImg.src;
            modal.style.display = "block";
        }

        function closeModal(modalId) {
            var modal = document.getElementById(modalId);
            modal.style.display = "none";
        }

        // 해당 이미지를 가져오기 위해 각 섹션의 이미지를 설정
        document.getElementById('modal-img1').src = 'images/smartfarm.png';
        document.getElementById('modal-img2').src = 'images/smartfarm_benefits.png';
        document.getElementById('modal-img3').src = 'images/smartfarm_cases.png';
        document.getElementById('modal-img4').src = 'images/smartfarm_technology.png';
    </script>
</body>
</html>
