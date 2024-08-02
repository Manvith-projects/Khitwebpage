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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String regNo = request.getParameter("regNo");
        String name = request.getParameter("student_name");
        String attendanceDate = request.getParameter("attendanceDate");
        String year = request.getParameter("year");
        String section = request.getParameter("section");
        String filter = request.getParameter("filter");

        // Convert section to lowercase
        if (section != null) {
            section = section.toLowerCase();
        }

        // Construct table names based on year and section
        String studentTableName = "students_" + year + section;
        String attendanceTableName = "students_attendance_" + year + section;

        // Debugging statements
        System.out.println("Student Table Name: " + studentTableName);
        System.out.println("Attendance Table Name: " + attendanceTableName);

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        SimpleDateFormat customDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date sqlDate = null;

        try {
            // Validate attendanceDate parameter
            if (attendanceDate == null || attendanceDate.trim().isEmpty()) {
                throw new IllegalArgumentException("Attendance date is required.");
            }

            java.util.Date parsedDate = customDateFormat.parse(attendanceDate);
            sqlDate = new java.sql.Date(parsedDate.getTime());

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(sqlDate);
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek == Calendar.SUNDAY) {
                request.setAttribute("message", "Attendance cannot be marked on Sundays.");
                request.getRequestDispatcher("attendance.jsp").forward(request, response);
                return;
            }

            Calendar today = Calendar.getInstance();
            if (calendar.after(today)) {
                request.setAttribute("message", "Attendance cannot be marked for future dates.");
                request.getRequestDispatcher("attendance.jsp").forward(request, response);
                return;
            }

            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            if ("filter".equals(filter)) {
                request.setAttribute("attendanceDate", attendanceDate);
                request.setAttribute("year", year);
                request.setAttribute("section", section);
                request.getRequestDispatcher("attendance.jsp").forward(request, response);
                return;
            }

            String checkQuery = "SELECT COUNT(*) FROM " + attendanceTableName + " WHERE REG_NO = ? AND ATTENDANCE_DATE = ?";
            System.out.println("Check Query: " + checkQuery);

            pstmt = con.prepareStatement(checkQuery);
            pstmt.setString(1, regNo);
            pstmt.setDate(2, sqlDate);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                String updateQuery = "UPDATE " + attendanceTableName + " SET ATTENDANCE_STATUS = ? WHERE REG_NO = ? AND ATTENDANCE_DATE = ?";
                System.out.println("Update Query: " + updateQuery);
                pstmt = con.prepareStatement(updateQuery);
                pstmt.setString(1, action);
                pstmt.setString(2, regNo);
                pstmt.setDate(3, sqlDate);
            } else {
                String insertQuery = "INSERT INTO " + attendanceTableName + " (REG_NO, ATTENDANCE_DATE, ATTENDANCE_STATUS) VALUES (?, ?, ?)";
                System.out.println("Insert Query: " + insertQuery);
                pstmt = con.prepareStatement(insertQuery);
                pstmt.setString(1, regNo);
                pstmt.setDate(2, sqlDate);
                pstmt.setString(3, action);
            }
            pstmt.executeUpdate();

            // Redirect to JSP to display updated attendance
            request.setAttribute("attendanceDate", attendanceDate);
            request.setAttribute("year", year);
            request.setAttribute("section", section);
            request.getRequestDispatcher("attendance.jsp").forward(request, response);

        } catch (ParseException e) {
            request.setAttribute("message", "Invalid date format. Please use yyyy-MM-dd.");
            request.getRequestDispatcher("attendance.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing the request.");
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
}
