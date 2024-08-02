package com.db.students;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.servlet.annotation.*;

@WebServlet("/addStudent")
public class AddStudentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl"; // Database URL
    private static final String DB_USER = "system";
    private static final String DB_PASSWORD = "Manvith7226";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String regNo = request.getParameter("regNo");
        String studentName = request.getParameter("studentName");
        String year = request.getParameter("year");
        String section = request.getParameter("section");
        String branch = request.getParameter("branch");

        // Debugging statements
        pw.println("regNo: " + regNo + "<br>");
        pw.println("studentName: " + studentName + "<br>");
        pw.println("year: " + year + "<br>");
        pw.println("section: " + section + "<br>");
        pw.println("branch: " + branch + "<br>");

        Connection con = null;
        PreparedStatement studentsPst = null;
        PreparedStatement attendancePst = null;
        String message = "";

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to Database
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Construct the table names dynamically
            String studentsTableName = "students_" + year + section.toLowerCase();
            String attendanceTableName = "students_attendance_" + year + section.toLowerCase();

            // Insert into students table
            String studentsQuery = "INSERT INTO " + studentsTableName + " (reg_no, name, branch) VALUES (?, ?, ?)";
            studentsPst = con.prepareStatement(studentsQuery);
            studentsPst.setString(1, regNo);
            studentsPst.setString(2, studentName);
            studentsPst.setString(3, branch);
            int rowsInserted = studentsPst.executeUpdate();

            // Insert into students_attendance table
            // Assuming attendance_date as current date and default status 'Present'
            String attendanceQuery = "INSERT INTO " + attendanceTableName + " (reg_no, attendance_date, attendance_status) VALUES (?, SYSDATE, 'Present')";
            attendancePst = con.prepareStatement(attendanceQuery);
            attendancePst.setString(1, regNo);
            int attendanceRowsInserted = attendancePst.executeUpdate();

            if (rowsInserted > 0 && attendanceRowsInserted > 0) {
                message = "Student added successfully!";
            } else {
                message = "Failed to add student.";
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            message = "Database driver not found: " + e.getMessage();
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        } finally {
            try {
                if (studentsPst != null) studentsPst.close();
                if (attendancePst != null) attendancePst.close();
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
