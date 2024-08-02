package com.db.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifySecurityAnswersServlet")
public class VerifySecurityAnswersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String JDBC_USER = "system";
    private static final String JDBC_PASSWORD = "Manvith7226";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String answer1 = request.getParameter("answer1");
        String answer2 = request.getParameter("answer2");
        
        boolean validAnswers = verifySecurityAnswers(username, answer1, answer2);
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (validAnswers) {
            out.println("{\"status\":\"success\"}");
        } else {
            out.println("{\"status\":\"error\", \"message\":\"Security answers are incorrect.\"}");
        }
    }
    
    private boolean verifySecurityAnswers(String username, String answer1, String answer2) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean valid = false;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            String sql = "SELECT security_answer1, security_answer2 FROM stulogin WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String correctAnswer1 = rs.getString("security_answer1");
                String correctAnswer2 = rs.getString("security_answer2");
                valid = answer1.equals(correctAnswer1) && answer2.equals(correctAnswer2);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        return valid;
    }
}
