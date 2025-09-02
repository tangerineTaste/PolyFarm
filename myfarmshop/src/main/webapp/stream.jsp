<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Stream - POLY FARM</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #e0f2e9, #f7fff7);
            color: #333;
        }

        header {
            
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
        }

        .logo img {
            width: 100px;
            height: auto;
        }

        .title h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
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

        .wrapper {
            display: grid;
            grid-template-columns: 65% 1fr;
            gap: 30px;
            padding: 30px;
        }

        video {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .wrap-right {
            text-align: center;
        }

        .wrap-right h1 {
            font-weight: 600;
            margin-bottom: 20px;
        }

        .wrap-right img {
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        footer {
            text-align: center;
            padding: 10px 0;
            background: linear-gradient(135deg, #4caf50 0%, #81c784 100%);
            color: white;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <header>
        <div class="logo">
            <a href="index.jsp" style="text-decoration: none;">
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

    <div class="div1">
        <h2>작물 상태 확인</h2>
    </div>

    <div class="wrapper">
        <video id="liveStream" autoplay controls></video>
        <div class="wrap-right">
            <h1>마이팜 관리하기</h1>
            <img src="images/QR.png" alt="QR코드" width="300px" height="300px">
        </div>
    </div>

    <footer>
        &copy; 2024 4조 캡스톤 프로젝트
    </footer>

    <script>
        const videoElement = document.getElementById('liveStream');
        const streamURL = 'http://192.168.102.139:8080/video'; 

        if ('MediaSource' in window) {
            const mediaSource = new MediaSource();
            videoElement.src = URL.createObjectURL(mediaSource);

            mediaSource.addEventListener('sourceopen', () => {
                const sourceBuffer = mediaSource.addSourceBuffer('video/mp4; codecs="avc1.42E01E"');
                fetchStreamData(sourceBuffer);
            });

            function fetchStreamData(buffer) {
                fetch(streamURL)
                    .then(response => response.arrayBuffer())
                    .then(data => buffer.appendBuffer(data))
                    .catch(error => console.error('Stream error:', error));
            }
        } else {
            alert('Your browser does not support MediaSource.');
        }
    </script>
</body>
</html>