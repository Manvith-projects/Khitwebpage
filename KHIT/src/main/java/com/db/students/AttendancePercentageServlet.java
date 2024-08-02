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

@WebServlet("/AttendancePercentageServlet")
public class AttendancePercentageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String year = request.getParameter("year");
        String section = request.getParameter("section");

        if (startDate == null || endDate == null || startDate.trim().isEmpty() || endDate.trim().isEmpty() ||
            year == null || section == null || year.trim().isEmpty() || section.trim().isEmpty()) {
            request.setAttribute("message", "Start date, end date, year, and section are all required.");
            request.getRequestDispatcher("calc.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            // Define the table name based on year and section
            String studentTableName = "students_" + year + section;
            String attendanceTableName = "students_attendance_" + year + section;

            String query = "SELECT s.REG_NO, s.NAME, " +
                           "       COUNT(a.ATTENDANCE_DATE) AS TOTAL_DAYS, " +
                           "       SUM(CASE WHEN a.ATTENDANCE_STATUS = 'Present' THEN 1 ELSE 0 END) AS PRESENT_DAYS, " +
                           "       SUM(CASE WHEN a.ATTENDANCE_STATUS = 'Absent' THEN 1 ELSE 0 END) AS ABSENT_DAYS " +
                           "FROM " + studentTableName + " s " +
                           "LEFT JOIN " + attendanceTableName + " a " +
                           "ON s.REG_NO = a.REG_NO AND a.ATTENDANCE_DATE BETWEEN TO_DATE(?, 'yyyy-MM-dd') AND TO_DATE(?, 'yyyy-MM-dd') " +
                           "GROUP BY s.REG_NO, s.NAME";

            pstmt = con.prepareStatement(query);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            rs = pstmt.executeQuery();

            request.setAttribute("resultSet", rs);
            request.getRequestDispatcher("calc.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while fetching the data.");
            request.getRequestDispatcher("calc.jsp").forward(request, response);
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
}
