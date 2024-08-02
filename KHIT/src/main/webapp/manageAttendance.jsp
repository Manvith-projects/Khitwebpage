<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Manage Attendance</title>
</head>
<body>
    <h1>Manage Attendance</h1>
    <form method="post" action="manageAttendance.jsp">
        <label for="commencementDate">Commencement Date:</label>
        <input type="date" id="commencementDate" name="commencementDate" required>
        <input type="submit" value="Calculate Attendance">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String commencementDate = request.getParameter("commencementDate");

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

                String query = "SELECT s.reg_no, s.name, "
                             + "SUM(CASE WHEN sa.attendance_status = 'present' THEN 1 ELSE 0 END) AS present_days, "
                             + "SUM(CASE WHEN sa.attendance_status = 'absent' THEN 1 ELSE 0 END) AS absent_days, "
                             + "COUNT(sa.attendance_status) AS total_days "
                             + "FROM students s "
                             + "LEFT JOIN student_attendance sa ON s.reg_no = sa.reg_no "
                             + "WHERE sa.attendance_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND SYSDATE "
                             + "GROUP BY s.reg_no, s.name";

                // Print SQL query for debugging
                out.println("SQL Query: " + query + "<br>");

                pst = con.prepareStatement(query);
                pst.setString(1, commencementDate);
                rs = pst.executeQuery();

                out.println("<h2>Attendance Summary</h2>");
                out.println("<table border='1'>");
                out.println("<tr><th>Reg No</th><th>Name</th><th>Present Days</th><th>Absent Days</th><th>Total Days</th><th>Attendance Percentage</th></tr>");

                boolean foundRecords = false;

                while (rs.next()) {
                    foundRecords = true; // Flag to indicate that records were found
                    String regNo = rs.getString("reg_no");
                    String name = rs.getString("name");
                    int presentDays = rs.getInt("present_days");
                    int absentDays = rs.getInt("absent_days");
                    int totalDays = rs.getInt("total_days");
                    double attendancePercentage = ((double) presentDays / totalDays) * 100;

                    out.println("<tr>");
                    out.println("<td>" + regNo + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + presentDays + "</td>");
                    out.println("<td>" + absentDays + "</td>");
                    out.println("<td>" + totalDays + "</td>");
                    out.println("<td>" + String.format("%.2f", attendancePercentage) + "%</td>");
                    out.println("</tr>");
                }

                out.println("</table>");

                if (!foundRecords) {
                    out.println("<p>No attendance records found for the specified commencement date.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("An error occurred: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <a href="adminhome">Home</a>
</body>
</html>
