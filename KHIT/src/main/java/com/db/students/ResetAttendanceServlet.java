package com.db.students;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/resetAttendance")
public class ResetAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DATE_FORMAT = "yyyy-MM-dd"; // Expected date format

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String regNo = request.getParameter("regNo");
        String year = request.getParameter("year");
        String section = request.getParameter("section");
        String attendanceDate = request.getParameter("attendanceDate");

        if (regNo == null || regNo.isEmpty() || year == null || year.isEmpty() || section == null || section.isEmpty() || attendanceDate == null || attendanceDate.isEmpty()) {
            response.setContentType("text/plain");
            response.getWriter().write("One or more required parameters are missing or empty.");
            return;
        }

        if (!isValidDate(attendanceDate)) {
            response.setContentType("text/plain");
            response.getWriter().write("Invalid date format. Expected format: yyyy-MM-dd.");
            return;
        }

        String tableName = "students_attendance_" + year + section;
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            // Check if the table exists
            DatabaseMetaData metaData = con.getMetaData();
            ResultSet tables = metaData.getTables(null, null, tableName.toUpperCase(), null);
            if (!tables.next()) {
                response.setContentType("text/plain");
                response.getWriter().write("Table does not exist: " + tableName);
                return;
            }

            // Prepare and execute delete query
            String query = "DELETE FROM " + tableName + " WHERE reg_no = ? AND attendance_date = TO_DATE(?, 'YYYY-MM-DD')";
            pst = con.prepareStatement(query);
            pst.setString(1, regNo);
            pst.setString(2, attendanceDate);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                response.setContentType("text/plain");
                response.getWriter().write("Attendance reset successfully!");
            } else {
                response.setContentType("text/plain");
                response.getWriter().write("No record found for the given registration number and date.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private boolean isValidDate(String dateStr) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        sdf.setLenient(false);
        try {
            sdf.parse(dateStr);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }
}