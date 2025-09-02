<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Cart, com.Item" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 확인 - 농작물 쇼핑몰</title>
    <link rel="stylesheet" href="styles/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .header-container {
            display: flex;
            align-items: center;
            justify-content: center;
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
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .payment-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .payment-method {
            flex: 1;
            min-width: 200px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .payment-method:hover {
            background-color: #e9e9e9;
        }
        .payment-method input {
            margin-right: 10px;
        }
        .cart-total {
            text-align: right;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            color: white;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .hidden {
            display: none;
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
            max-width: 500px;
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
        .modal button {
            padding: 10px 20px;
            margin: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
        }
        .modal button:hover {
            background-color: #45a049;
        }
    </style>
    
    <% Cart cart = (Cart) session.getAttribute("cart"); %>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	
    	var totalAmount = '<%= cart != null ? cart.getTotalPrice() : 0 %>'
	    var IMP = window.IMP; // 생략 가능
	 	IMP.init('imp43155668'); // 테스트용 가맹점 식별코드
	
	    function kakaoRequestPay() {
	 		IMP.request_pay({
	          pg: 'kakaopay', // PG사 선택 (이니시스, 나이스 등)
	          pay_method: 'card', // 결제 방식 (카드, 가상계좌, 휴대폰 등)
	          merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
	          name: '농작물 결제', // 결제명
	          amount: totalAmount , // 결제 금액 (테스트용으로 1000원 설정)
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
	 	
	    function tossRequestPay() {
	 		IMP.request_pay({
	          pg: 'tosspay',
	          pay_method: 'card', // 결제 방식 (카드, 가상계좌, 휴대폰 등)
	          merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
	          name: '농작물 결제', // 결제명
	          amount: totalAmount , // 결제 금액 (테스트용으로 1000원 설정)
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
	 	
	 	
        function showPaymentPrompt() {
            var selectedPaymentMethod = document.querySelector('input[name="payment"]:checked');
            if (selectedPaymentMethod && selectedPaymentMethod.id === 'credit-card') {
                var modal = document.getElementById("paymentModal");
                modal.style.display = "block";
            } 
            else if(selectedPaymentMethod && selectedPaymentMethod.id === 'kakao-pay'){
            	kakaoRequestPay();
            }
            else if(selectedPaymentMethod && selectedPaymentMethod.id === 'toss-pay'){
            	tossRequestPay();
            }
            else {
                alert("결제 방법을 선택해주세요.");
            }
        }

        function closeModal() {
            var modal = document.getElementById("paymentModal");
            modal.style.display = "none";
        }

        function selectBank(bankName) {
            document.getElementById("selectedPaymentMethod").value = bankName;
            document.getElementById("paymentForm").submit();
        }

        window.onclick = function(event) {
            var modal = document.getElementById("paymentModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
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
    </header>
    <main>
        <div class="container">
            <section class="section">
                <h2>결제 확인</h2>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>상품명</th>
                                <th>수량</th>
                                <th>가격</th>
                                <th>총 가격</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
						    
						    if (cart != null && !cart.getItems().isEmpty()) {
						        for (Item item : cart.getItems()) {
						%>
                            <tr>
                                <td><%= item.getName() %></td>
                                <td>1</td>
                                <td>₩<%= item.getPrice() %></td>
                                <td>₩<%= item.getPrice() %></td>
                            </tr>
                            <%
                                    }
                            %>
                            <tr>
                                <td colspan="3">총 가격</td>
                                <td>₩<%= cart.getTotalPrice() %></td>
                            </tr>
                            <%
                                } else {
                            %>
                            <tr>
                                <td colspan="4">장바구니가 비어 있습니다.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </section>
            <section class="section">
                <h2>결제 방법</h2>
                <div class="payment-methods"">
                    <div class="payment-method">
                        <input type="radio" name="payment" id="credit-card" value="신용카드" >
                        <label for="credit-card">신용카드</label>
                    </div>
                    <div class="payment-method">
                        <input type="radio" name="payment" id="bank-transfer" value="계좌 이체">
                        <label for="bank-transfer">계좌 이체</label>
                    </div>
                    <div class="payment-method">
                        <input type="radio" name="payment" id="kakao-pay" value="카카오페이" >
                        <label for="kakao-pay">카카오페이</label>
                    </div>
                    <div class="payment-method">
                        <input type="radio" name="payment" id="toss-pay" value="토스페이">
                        <label for="toss-pay">토스페이</label>
                    </div>
                </div>
            </section>
            <%
                if (cart != null && !cart.getItems().isEmpty()) {
            %>
            <div class="cart-total">
                <strong>총 결제 금액: ₩<%= cart.getTotalPrice() %></strong>
            </div>
            <button class="btn" onclick="showPaymentPrompt()">결제 완료</button>
            <%
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 4조 캡스톤 프로젝트</p>
    </footer>

    <!-- 결제 모달 -->
    <div id="paymentModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>결제 은행 선택</h2>
            <button onclick="selectBank('우리은행')">우리은행</button>
            <button onclick="selectBank('카카오뱅크')">카카오뱅크</button>
            <button onclick="selectBank('신한은행')">신한은행</button>
        </div>
    </div>

    <form id="paymentForm" action="processPayment.jsp" method="post">
        <input type="hidden" id="selectedPaymentMethod" name="selectedPaymentMethod" value="">
        <input type="hidden" name="paymentMethod" id="paymentMethod" value="">
    </form>
</body>
</html>


