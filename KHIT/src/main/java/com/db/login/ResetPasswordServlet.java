package com.db.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String JDBC_USER = "system";
    private static final String JDBC_PASSWORD = "Manvith7226";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        
        boolean resetSuccess = resetPassword(username, newPassword);
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (resetSuccess) {
            out.println("{\"status\":\"success\", \"message\":\"Password reset successful.\"}");
        } else {
            out.println("{\"status\":\"error\", \"message\":\"Failed to reset password.\"}");
        }
    }
    
    private boolean resetPassword(String username, String newPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            String sql = "UPDATE stulogin SET password = ? WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, username);
            int rowsAffected = stmt.executeUpdate();
            
            success = (rowsAffected > 0);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        return success;
    }
}
