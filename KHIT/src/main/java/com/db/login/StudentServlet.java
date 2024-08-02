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

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        
        String username = request.getParameter("username");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");
            
            // Fetch student attendance
            pst = con.prepareStatement("SELECT attendance_percentage FROM student_attendance WHERE username = ?");
            pst.setString(1, username);
            rs = pst.executeQuery();
            
            if (rs.next()) {
                String attendancePercentage = rs.getString("attendance_percentage");
                pw.print("<h1>Student Attendance</h1>");
                pw.print("<p>Attendance Percentage: " + attendancePercentage + "%</p>");
                pw.print("<a href='INDEX.html'>Home</a>");
            } else {
                pw.print("<h1>No attendance data found.</h1>");
                pw.print("<a href='INDEX.html'>Home</a>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            pw.print("<h1>An error occurred. Please try again later.</h1>");
            pw.print("<a href='INDEX.html'>Home</a>");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
