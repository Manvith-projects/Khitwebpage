package com.db.students;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/StudentsServlet")
public class StudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String year = request.getParameter("year");
        String section = request.getParameter("section");
        String attendanceDate = request.getParameter("attendanceDate");
        String studentClass = year + section;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            String studentTableName = "students_" + studentClass;
            String attendanceTableName = "students_attendance_" + studentClass;

            // Query to get all students and their attendance status for the given date
            String query = "SELECT s.REG_NO, s.NAME, a.ATTENDANCE_STATUS " +
                           "FROM " + studentTableName + " s " +
                           "LEFT JOIN " + attendanceTableName + " a " +
                           "ON s.REG_NO = a.REG_NO AND a.ATTENDANCE_DATE = TO_DATE(?, 'yyyy-MM-dd')";

            pstmt = con.prepareStatement(query);
            pstmt.setString(1, attendanceDate);
            rs = pstmt.executeQuery();

            request.setAttribute("students", rs);
            request.setAttribute("attendanceDate", attendanceDate);
            request.setAttribute("year", year);
            request.setAttribute("section", section);
            request.getRequestDispatcher("attendance.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("attendance.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
