<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.mail.*, javax.mail.internet.*, java.util.*" %>
<%
    String email = request.getParameter("email");

    // 랜덤한 6자리 인증 코드 생성
    String verificationCode = String.valueOf((int)(Math.random() * 1000000));

    // 세션에 인증 코드 저장
    session.setAttribute("verificationCode", verificationCode);
    session.setAttribute("email", email);

    // 이메일 발송 설정
    String host = "smtp.gmail.com"; // SMTP 서버 주소
    String user = "sim021228@gmail.com"; // SMTP 사용자 계정
    String password = "ukha bjxf kguu jdiz"; // SMTP 사용자 비밀번호

    // 이메일 속성 설정
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "587"); // 일반적으로 사용하는 포트
    props.put("mail.smtp.starttls.enable", "true");

    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(user, password);
        }
    });
    
    
    
    try {
    	MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(user));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

        // 이메일 제목 및 본문 설정
        message.setSubject("비밀번호 찾기 인증 코드");
        message.setText("안녕하세요, 요청하신 비밀번호 찾기 인증 코드는 " + verificationCode + " 입니다.");

        // 이메일 전송
        Transport.send(message);
        out.println("<p>이메일로 인증 코드가 전송되었습니다.</p>");
        out.println("<a href='verifyCode.jsp'>인증 코드 입력 페이지로 이동</a>");
    } catch (MessagingException e) {
        e.printStackTrace();
        out.println("<p>이메일 전송에 실패했습니다.</p>");
    }
%>
