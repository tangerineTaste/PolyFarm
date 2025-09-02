<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>농작물 쇼핑하기 - E런 농사</title>
    <style>
		.div1 {
            margin: 10px 0;
            padding: 20px;
            display: flex;
            color: white;
            background-color: #4CAF50;
            height: 50px;
            justify-content: center;
            align-items: center;
        }
        .search-container {
            text-align: center;
            margin: 20px 0;
        }
        .search-container input[type="text"] {
            padding: 10px;
            width: 80%;
            max-width: 400px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .category-list {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 20px;
            background-color: #f8f8f8;
        }
        .category-container {
            margin: 10px 0;
        }
        .category-title {
            cursor: pointer;
            font-size: 1.5em;
            margin: 10px 0;
            background-color: #e0e0e0;
            padding: 10px;
            border-radius: 5px;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .category-title span {
            font-size: 0.8em;
            padding: 0 10px;
        }
        .card-container {
            display: none;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 10px;
            text-align: center;
            width: 200px;
            background-color: #f9f9f9;
        }
        .card img {
            max-width: 100%;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .card h3 {
            font-size: 1.2em;
            margin: 10px 0;
        }
        .card p {
            font-size: 1em;
            color: #333;
        }
        .card button {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .card button:hover {
            background-color: #45a049;
        }
        footer {
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
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
        .cart-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .cart-button:hover {
            background-color: #45a049;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            text-align: center;
            border-radius: 10px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .no-results {
            text-align: center;
            font-size: 1.2em;
            color: red;
            margin-top: 20px;
        }    </style>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
	    function addToCart(itemId, itemName, itemPrice, itemImage) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "addToCart.jsp", true);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState == 4 && xhr.status == 200) {
	                showModal("장바구니에 추가되었습니다.");
	            }
	        };
	        xhr.send("id=" + itemId + "&name=" + encodeURIComponent(itemName) + "&price=" + itemPrice + "&image=" + itemImage);
	    }
	
	    function showModal(message) {
	        var modal = document.getElementById("myModal");
	        var modalMessage = document.getElementById("modalMessage");
	        modalMessage.innerText = message;
	        modal.style.display = "block";
	    }
	
	    function closeModal() {
	        var modal = document.getElementById("myModal");
	        modal.style.display = "none";
	    }
	
	    window.onclick = function(event) {
	        var modal = document.getElementById("myModal");
	        if (event.target == modal) {
	            modal.style.display = "none";
	        }
	    }
	
	    function searchItems() {
	        var input = document.getElementById("searchInput").value.toLowerCase();
	        var cards = document.getElementsByClassName("card");
	        var noResultsMessage = document.getElementById("noResultsMessage");
	        var found = false;
	
	        for (var i = 0; i < cards.length; i++) {
	            var card = cards[i];
	            var itemName = card.getElementsByTagName("h3")[0].innerText.toLowerCase();
	
	            if (itemName.includes(input)) {
	                card.style.display = "block";
	                found = true;
	            } else {
	                card.style.display = "none";
	            }
	        }
	
	        if (found) {
	            noResultsMessage.style.display = "none";
	        } else {
	            noResultsMessage.style.display = "block";
	            noResultsMessage.innerText = "검색하신 '" + input + "' 상품은 존재하지 않습니다.";
	        }
	    }
	
	    function toggleCategory(categoryId) {
	        var category = document.getElementById(categoryId);
	        var display = category.style.display;
	
	        if (display === "none" || display === "") {
	            category.style.display = "flex";
	            document.getElementById("toggle-" + categoryId).innerText = "-";
	        } else {
	            category.style.display = "none";
	            document.getElementById("toggle-" + categoryId).innerText = "+";
	        }
	    }
	    
		var IMP = window.IMP; // 생략 가능
	 	IMP.init('imp43155668'); // 테스트용 가맹점 식별코드

	    function requestPay() {
	        IMP.request_pay({
	          pg: 'kakaopay', // PG사 선택 (이니시스, 나이스 등)
	          pay_method: 'card', // 결제 방식 (카드, 가상계좌, 휴대폰 등)
	          merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
	          name: '테스트 결제', // 결제명
	          amount: 1000, // 결제 금액 (테스트용으로 1000원 설정)
	          buyer_email: 'test@test.com',
	          buyer_name: '홍길동',
	          buyer_tel: '010-1234-5678',
	          buyer_addr: '서울특별시 강남구',
	          buyer_postcode: '12345',
	        }, function (rsp) { // 콜백 함수
	          if (rsp.success) {
	            alert('결제가 성공적으로 완료되었습니다.');
	            // 성공 처리 로직 (서버에 결제 성공 데이터를 전달하는 등의 처리)
	          } else {
	            alert('결제에 실패했습니다. 에러 메시지: ' + rsp.error_msg);
	            // 실패 처리 로직
	          }
	        });
	      }
	 

    </script>
</head>
<body>
    <header class="header-container">
		<div class="logo">
            <a href="index.jsp" style="text-decoration: none; color: black;">
                <img src="images/logo1.png" alt="로고">
            </a>
        </div>
        <div class="title">
            <a href="index.jsp" style="text-decoration: none; color: black;">
                <h1>POLY FARM</h1>
            </a>
        </div>
        <div>
            <a href="cart.jsp" class="cart-button">장바구니로 이동하기</a>
        </div>
    </header>
    <button onclick="requestPay()">테스트 결제하기</button>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>POLY FARM</h2>
            <p id="modalMessage"></p>
            <button onclick="closeModal()">확인</button>
        </div>
    </div>
</body>
</html>
