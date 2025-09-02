<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    boolean exists = false;

    String url = "jdbc:mysql://localhost:3306/myfarmshopdb";
    String user = "root";
    String password = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            exists = rs.getInt(1) > 0;
        }

        // JSON 형식으로 응답 생성
        out.print("{\"exists\": " + exists + "}");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
