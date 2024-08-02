package com.db.students;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.servlet.annotation.*;

@WebServlet("/removeStudent")
public class RemoveStudentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl"; // Database URL
    private static final String DB_USER = "system";
    private static final String DB_PASSWORD = "Manvith7226";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String regNo = request.getParameter("regNoRemove");
        String year = request.getParameter("year");  // Assuming year is provided in the request
        String section = request.getParameter("section");  // Assuming section is provided in the request

        Connection con = null;
        PreparedStatement pst1 = null;
        PreparedStatement pst2 = null;
        String message = "";

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to Database
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Disable auto-commit to handle transactions manually
            con.setAutoCommit(false);

            // Construct the table names dynamically
            String studentsTableName = "students_" + year + section.toLowerCase();
            String attendanceTableName = "students_attendance_" + year + section.toLowerCase();

            // Prepare statements for deletion
            String query1 = "DELETE FROM " + attendanceTableName + " WHERE reg_no = ?";
            String query2 = "DELETE FROM " + studentsTableName + " WHERE reg_no = ?";

            pst1 = con.prepareStatement(query1);
            pst1.setString(1, regNo);
            int rowsDeletedFromAttendance = pst1.executeUpdate();

            pst2 = con.prepareStatement(query2);
            pst2.setString(1, regNo);
            int rowsDeletedFromStudents = pst2.executeUpdate();

            // Commit transaction if both deletions were successful
            if (rowsDeletedFromAttendance > 0 && rowsDeletedFromStudents > 0) {
                con.commit();
                message = "Student removed successfully!";
            } else {
                // Rollback transaction if any deletion failed
                con.rollback();
                message = "Failed to remove student.";
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            message = "An error occurred: " + e.getMessage();
        } finally {
            try {
                if (pst1 != null) pst1.close();
                if (pst2 != null) pst2.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set message as request attribute and forward to JSP
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("manageStudents.jsp");
        dispatcher.forward(request, response);
    }
}
