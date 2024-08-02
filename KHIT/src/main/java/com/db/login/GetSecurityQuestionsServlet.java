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

@WebServlet("/GetSecurityQuestionsServlet")
public class GetSecurityQuestionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String JDBC_USER = "system";
    private static final String JDBC_PASSWORD = "Manvith7226";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String[] questions = getSecurityQuestions(username);
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (questions != null) {
            out.println("{\"status\":\"success\", \"question1\":\"" + questions[0] + "\", \"question2\":\"" + questions[1] + "\"}");
        } else {
            out.println("{\"status\":\"error\", \"message\":\"Username not found.\"}");
        }
    }
    
    private String[] getSecurityQuestions(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String[] questions = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            String sql = "SELECT security_question1, security_question2 FROM stulogin WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                questions = new String[2];
                questions[0] = rs.getString("security_question1");
                questions[1] = rs.getString("security_question2");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        return questions;
    }
}
