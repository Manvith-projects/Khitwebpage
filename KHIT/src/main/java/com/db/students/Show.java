package com.db.students;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.servlet.annotation.*;

@WebServlet("/viewstudents")
public class Show extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish a connection to the database
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");
            st = con.createStatement();

            // Query to combine data from all specified tables
            String query = "SELECT reg_no, name, branch FROM students_2a UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_2b UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_2c UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_3a UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_3b UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_3c UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_4a UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_4b UNION ALL " +
                           "SELECT reg_no, name, branch FROM students_4c";

            // Execute the query
            rs = st.executeQuery(query);

            // Print the HTML content
            pw.print("<!DOCTYPE html>");
            pw.print("<html lang='en'>");
            pw.print("<head>");
            pw.print("<meta charset='UTF-8'>");
            pw.print("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            pw.print("<title>Student List</title>");
            pw.print("<style>");
            pw.print("body { background-color: #000000; color: #fff; font-family: 'Poppins', sans-serif; margin: 0; }");
            pw.print("h1 { background-color: #333; color: #FFCB9A; padding: 10px; text-align: center; margin-bottom: 20px; }");
            pw.print("table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }");
            pw.print("table, th, td { border: 1px solid #ccc; }");
            pw.print("th, td { padding: 15px; text-align: left; }");
            pw.print("th { background-color: #333; color: #FFCB9A; }");
            pw.print("td { background-color: #1e1e1e; color: #fff; }");
            pw.print("a { display: block; text-align: center; color: #FFCB9A; text-decoration: none; font-size: 18px; margin-top: 20px; }");
            pw.print("a:hover { text-decoration: underline; }");
            pw.print("</style>");
            pw.print("</head>");
            pw.print("<body>");
            pw.print("<h1>Student List</h1>");
            pw.print("<table>");
            pw.print("<tr><th>Reg No</th><th>Name</th><th>Branch</th></tr>");

            // Process the result set
            while (rs.next()) {
                String regNo = rs.getString("reg_no");
                String name = rs.getString("name");
                String branch = rs.getString("branch");

                pw.print("<tr>");
                pw.print("<td>" + regNo + "</td>");
                pw.print("<td>" + name + "</td>");
                pw.print("<td>" + branch + "</td>");
                pw.print("</tr>");
            }

            pw.print("</table>");
            pw.print("<a href='adminhome.jsp'>Home</a>");
            pw.print("</body>");
            pw.print("</html>");
        } catch (ClassNotFoundException | SQLException e) {
            // Log error and show a user-friendly message
            e.printStackTrace();
            pw.print("<html><body><h2>An error occurred while fetching student data.</h2></body></html>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
