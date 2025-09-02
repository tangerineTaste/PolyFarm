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
    <main>
        <div class="div1">
            <h2>상품 목록</h2>
        </div>

        <div class="search-container">
            <input type="text" id="searchInput" onkeyup="searchItems()" placeholder="상품명을 입력하세요...">
        </div>

        <div id="noResultsMessage" class="no-results" style="display: none;"></div>

        <div class="category-list">
            <% 
                // 데이터베이스 연결
                String url = "jdbc:mysql://localhost:3306/myfarmshopdb";
                String user = "root";
                String password = "1234";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);
                    stmt = conn.createStatement();

                    // 카테고리 별로 상품을 불러오기 위한 쿼리
                    String[] categories = {"채소", "과일"};
                    for (String category : categories) {
                        out.println("<div class='category-container'>");
                        out.println("<div class='category-title' onclick=\"toggleCategory('" + category + "')\">");
                        out.println("<span>" + category + "</span>");
                        out.println("<span id='toggle-" + category + "'>+</span>");
                        out.println("</div>");
                        out.println("<div id='" + category + "' class='card-container'>");

                        // 카테고리에 해당하는 상품 가져오기
                        String sql = "SELECT * FROM items WHERE category = '" + category + "'";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            int price = rs.getInt("price");
                            String image = rs.getString("image");

                            
                            out.println("<div class='card'>");
                            
                            out.println("<a href='product.jsp?id=" + id + "'>");
                            out.println("<img src='images/" + image + "' alt='" + name + "'>");
                            out.println("</a>");
                            
                      
                            out.println("<h3>" + name + "</h3>");
                            out.println("<p>₩" + price + "</p>");
                            out.println("<button type='button' onclick=\"addToCart(" + id + ", '" + name + "', " + price + ", '" + image + "')\">장바구니에 추가</button>");
                            out.println("</div>");
                        }

                        out.println("</div>");  // card-container 닫기
                        out.println("</div>");  // category-container 닫기
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </main>
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
