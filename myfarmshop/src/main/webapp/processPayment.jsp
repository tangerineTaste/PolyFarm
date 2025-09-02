<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 처리 - 농작물 쇼핑몰</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
        }

        .message {
            margin-top: 20px;
            font-size: 1.2em;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            color: white;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>결제 처리</h1>
        <div class="message">
            <%
                String paymentMethod = request.getParameter("paymentMethod");
                String selectedPaymentMethod = request.getParameter("selectedPaymentMethod");
                if (paymentMethod != null && !paymentMethod.isEmpty()) {
                    if (paymentMethod.equals("신용카드") && selectedPaymentMethod != null && !selectedPaymentMethod.isEmpty()) {
                        out.println(selectedPaymentMethod + " 결제를 선택하셨습니다.<br>");
                    } else {
                        out.println(paymentMethod + " 결제를 선택하셨습니다.<br>");
                    }
                } else {
                    out.println("결제 방법이 선택되지 않았습니다.<br>");
                }
            %>
        </div>
        <button class="btn" onclick="alert('결제가 완료되었습니다.'); window.location.href='index.jsp';">결제하기</button>
    </div>
</body>
</html>

