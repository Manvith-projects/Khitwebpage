<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Attendance</title>
    <link rel="icon" href="images/a1.jpeg" type="image/icon type">
    <style>
        body {
            background-color: #000000;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background-image: url("images//att2.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            animation: fadeIn 1s ease-in; /* Animation for body */
        }

        h1 {
            background-color: #333;
            color: #FFCB9A;
            padding: 10px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 15px;
            animation: slideIn 1s ease-out; /* Animation for h1 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            border-radius: 10px;
            animation: fadeInUp 1s ease-out; /* Animation for table */
        }

        table, th, td {
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: rgba(51, 51, 51, 0.6); /* Semi-transparent header background */
            color: #FFCB9A;
        }

        td {
            background-color: rgba(30, 30, 30, 0.6); /* Semi-transparent cell background */
            color: #fff;
        }

        button {
            background-color: #ff4500;
            color: #fff;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            margin-right: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease; /* Animation */
            animation: pulse 1s infinite; /* Animation for button */
        }

        button:hover {
            background-color: #cc3700;
            transform: scale(1.05); /* Scale effect on hover */
        }

        a {
            display: block;
            text-align: center;
            color: #FFCB9A;
            text-decoration: none;
            font-size: 18px;
            margin-top: 20px;
            transition: color 0.3s ease; /* Animation */
        }

        a:hover {
            text-decoration: underline;
            color: #e6c2a7; /* Lighter hover color */
        }

        .disabled {
            background-color: #555;
            cursor: not-allowed;
        }

        .date-picker-container {
            margin-bottom: 20px;
            text-align: center;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            border-radius: 10px;
            padding: 10px;
            animation: fadeInUp 1s ease-out; /* Animation for date picker container */
        }

        .date-picker-label {
            color: #FFCB9A;
            font-size: 18px;
            margin-right: 10px;
        }

        .date-picker-input {
            background-color: rgba(51, 51, 51, 0.8); /* Semi-transparent input background */
            border: 1px solid rgba(255, 255, 255, 0.5);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
            outline: none;
            margin-right: 10px;
        }

        .date-picker-input:hover {
            background-color: rgba(51, 51, 51, 1);
        }

        .date-picker-input:focus {
            background-color: rgba(51, 51, 51, 1);
            border-color: #FFCB9A;
            box-shadow: 0 0 5px #FFCB9A;
        }

        .filter-button {
            background-color: #ff4500;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease; /* Animation */
            animation: pulse 1s infinite; /* Animation for filter button */
        }

        .filter-button:hover {
            background-color: #cc3700;
            transform: scale(1.05); /* Scale effect on hover */
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes focusGlow {
            from { box-shadow: 0 0 5px rgba(255, 203, 154, 0.5); }
            to { box-shadow: 0 0 10px rgba(255, 203, 154, 1); }
        }

        

        /* Responsive Design */
        @media (max-width: 600px) {
            .container {
                flex-direction: column;
                align-items: stretch;
            }

            form {
                min-width: auto;
            }
        }
    </style>
</head>
<body>
    <h1>Student Attendance</h1>

    <!-- Form to select the year, section, and filter date -->
    <form action="AttendanceServlet" method="post">
        <div class="date-picker-container">
            <label for="year" class="date-picker-label">Year:</label>
            <select id="year" name="year" class="date-picker-input">
                <option value="">Select Year</option>
                <option value="2" <%= "2".equals(request.getAttribute("year")) ? "selected" : "" %>>2nd Year</option>
                <option value="3" <%= "3".equals(request.getAttribute("year")) ? "selected" : "" %>>3rd Year</option>
                <option value="4" <%= "4".equals(request.getAttribute("year")) ? "selected" : "" %>>4th Year</option>
                <!-- Add more years as needed -->
            </select>
            <label for="section" class="date-picker-label">Section:</label>
            <select id="section" name="section" class="date-picker-input">
                <option value="">Select Section</option>
                <option value="A" <%= "A".equals(request.getAttribute("section")) ? "selected" : "" %>>A</option>
                <option value="B" <%= "B".equals(request.getAttribute("section")) ? "selected" : "" %>>B</option>
                <option value="C" <%= "C".equals(request.getAttribute("section")) ? "selected" : "" %>>C</option>
                <!-- Add more sections as needed -->
            </select>
            <label for="attendanceDate" class="date-picker-label">Select Date:</label>
            <input type="date" id="attendanceDate" name="attendanceDate" class="date-picker-input" value="<%= request.getAttribute("attendanceDate") != null ? request.getAttribute("attendanceDate") : "" %>" required>
            <button type="submit" name="filter" value="filter" class="filter-button">Filter</button>
        </div>
    </form>

    <!-- Table to display students -->
    <form action="AttendanceServlet" method="post">
        <input type="hidden" name="attendanceDate" value="<%= request.getAttribute("attendanceDate") != null ? request.getAttribute("attendanceDate") : "" %>">
        <input type="hidden" name="year" value="<%= request.getAttribute("year") != null ? request.getAttribute("year") : "" %>">
        <input type="hidden" name="section" value="<%= request.getAttribute("section") != null ? request.getAttribute("section") : "" %>">

        <!-- Table to show all students -->
        <table>
            <thead>
                <tr>
                    <th>Registration Number</th>
                    <th>Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection con = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String year = request.getAttribute("year") != null ? (String) request.getAttribute("year") : "";
                    String section = request.getAttribute("section") != null ? (String) request.getAttribute("section") : "";
                    String studentTableName = "students_" + year + section;
                    String attendanceTableName = "students_attendance_" + year + section;

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

                        // Query to get all students and their attendance status for the selected date
                        String query = "SELECT s.REG_NO, s.NAME, COALESCE(a.ATTENDANCE_STATUS, 'Not Marked') AS ATTENDANCE_STATUS " +
                                       "FROM " + studentTableName + " s LEFT JOIN " + attendanceTableName + " a " +
                                       "ON s.REG_NO = a.REG_NO AND a.ATTENDANCE_DATE = TO_DATE(?, 'yyyy-MM-dd')";
                        pstmt = con.prepareStatement(query);
                        pstmt.setString(1, request.getAttribute("attendanceDate") != null ? (String) request.getAttribute("attendanceDate") : "");
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String regNo = rs.getString("REG_NO");
                            String name = rs.getString("NAME");
                            String status = rs.getString("ATTENDANCE_STATUS");
                            String presentClass = "button";
                            String absentClass = "button";
                            String resetClass = "button";

                            if ("Present".equals(status)) {
                                presentClass += " disabled";
                                absentClass += " disabled";
                                resetClass += " enabled";
                            } else if ("Absent".equals(status)) {
                                absentClass += " disabled";
                                presentClass += " disabled";
                                resetClass += " enabled";
                            }
                %>
                <tr>
                    <td><%= regNo %></td>
                    <td><%= name %></td>
                    <td>
                        <button type="submit" name="action" value="Present" class="<%= presentClass %>" formaction="AttendanceServlet?regNo=<%= regNo %>&student_name=<%= name %>">Mark Present</button>
                        <button type="submit" name="action" value="Absent" class="<%= absentClass %>" formaction="AttendanceServlet?regNo=<%= regNo %>&student_name=<%= name %>">Mark Absent</button>
                        <button type="submit" name="action" value="Reset" class="<%= resetClass %>" formaction="AttendanceServlet?regNo=<%= regNo %>&student_name=<%= name %>">Reset</button>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </form>

    <% if (request.getAttribute("message") != null) { %>
        <p style="color: red;"><%= request.getAttribute("message") %></p>
    <% } %>
</body>
</html>
