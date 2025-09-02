<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>E런 적상추 150g</title>
	<link rel="stylesheet" href="styles/product.css">
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
        
        const DescriptionImages =["img.png", "smartfarm.png","smartfarm_benefits.png","smartfarm_cases.png","smartfarm_technology.png"];
        const Descriptiontext1 =["본 제품은 스마트팜에서 생산된 제품으로,","스마트팜이란 농업에 ICT 기술을 접목해","스마트팜의 장점은 스마트폰으로 언제 어디서든","현재 국내에서도 청년들을 위한 창업 시스템 구축과","스마트팜의 관련된 기술들은"];
        const Descriptiontext2 =["소비자분들에게 사시사철 신선한 제품을 제공하고 있습니다.","원격·자동으로 생육환경을 제어가능한 농장입니다.","관리할 수 있으며, 센서와 데이터 기반으로 많은 인력이 필요하지 않습니다.","스마트팜 인프라 구축, 스마트팜 혁신밸리 조성들의 정책을 추진 중 입니다.","IoT센서, 드론, 인공지능, 빅데이터분석, 자동화 시스템 등이 포함됩니다."];
        var NowDescrptionImage = 0;
        
        function DescriptionNextImageClick(){
        	NowDescrptionImage++;
        	if(NowDescrptionImage>4) NowDescrptionImage = 0;
        	var image = document.getElementById('image');
        	var text1 = document.getElementById('text1');
        	var text2 = document.getElementById('text2');
        	image.src = "./images/"+ DescriptionImages[NowDescrptionImage];
        	text1.innerText = Descriptiontext1[NowDescrptionImage];
        	text2.innerText = Descriptiontext2[NowDescrptionImage];
        }
        function DescriptionPreviousImageClick(){
        	NowDescrptionImage--;
        	if(NowDescrptionImage<0) NowDescrptionImage = 4;
        	var image = document.getElementById('image');
        	var text1 = document.getElementById('text1');
        	var text2 = document.getElementById('text2');
        	image.src = "./images/"+ DescriptionImages[NowDescrptionImage];
        	text1.innerText = Descriptiontext1[NowDescrptionImage];
        	text2.innerText = Descriptiontext2[NowDescrptionImage];
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
        	<a href="shop.jsp" class="cart-button" style="margin-right:20px">계속 쇼핑하기</a>
        </div>
        <div>
            <a href="cart.jsp" class="cart-button">장바구니로 이동하기</a>
        </div>
    </header>
    <div class="div1">
    	<h2>상품 세부정보</h2>
    </div>
	<div class="main">
	   	<% 
            String id = request.getParameter("id");
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

                String sql = "SELECT * FROM items WHERE id = " + id;
                rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    String image = rs.getString("image");
                    String category = rs.getString("category");

        %>
	   	<div class="wrapper">
	        <div>
	            <img src="images/<%= image %>" width="400px">
	        </div>
	        <div class="wrap-right">
	            <h1 style="margin-bottom: 0px; margin-top: 100px"><%= name %></h1>
	            <p style="margin: 0px;">원산지: 한국</p>
	            <h2>₩<%= price %></h2>
	            <button type="button" onclick="addToCart(<%= id %>, '<%= name %>', <%= price %>, '<%= image %>')" style="font-size:20px; margin-top:10px">장바구니에 추가</button>
	        </div>
	        <div class="description">
	   			<div class="middle">
	   				<img id="previous" src="images/next.png" onclick="DescriptionPreviousImageClick()" width=50px height=50px >
	   				<img id="image" src="images/img.png" alt="스마트팜" width=400px height=200px>
	   				<img id="next" src="images/next.png" onclick="DescriptionNextImageClick()" width=50px height=50px style="transform: scaleX(-1);"	>
	   			</div>
	   			
	   			<p ><span id="text1">본 제품은 스마트팜에서 생산된 제품으로,</span></p>
	   			<p style="margin-top:0px;"><span id="text2">소비자분들에게 사시사철 신선한 제품을 제공하고 있습니다.</span></p>	
	   		</div>
	   		 
	    </div>
	    <%
	    String currentCategory = rs.getString("category"); // 현재 상품의 카테고리 가져오기

		 // 같은 카테고리에서 현재 상품을 제외한 랜덤 2개의 추천 상품 쿼리
		 String recommendQuery = "SELECT * FROM items WHERE category = ? AND id != ? ORDER BY RAND() LIMIT 2";
		 PreparedStatement recommendPstmt = conn.prepareStatement(recommendQuery);
		 recommendPstmt.setString(1, currentCategory);
		 recommendPstmt.setInt(2, Integer.parseInt(id)); // 현재 상품은 제외
		 ResultSet recommendRs = recommendPstmt.executeQuery();

	    %>
		<div class="other">
	   		<h2>[추천 상품]</h2>
			   	<div class="card-container">
			   		<% while (recommendRs.next()) { %>
			            <div class="card">
			                <a href="product.jsp?id=<%= recommendRs.getInt("id") %>" style="text-decoration: none; color: black;">
			                    <img src="images/<%= recommendRs.getString("image") %>" alt="<%= recommendRs.getString("name") %>">
			                </a>
			               	<h3><%= recommendRs.getString("name") %></h3>
			                <p>₩<%= recommendRs.getInt("price") %></p>
            </div>
        <% } %>

		   		</div>
   		</div>
   		<%
                } else {
                    out.println("<p>상품 정보를 찾을 수 없습니다.</p>");
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