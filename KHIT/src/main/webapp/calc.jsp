<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="images/a1.jpeg" type="image/icon type">
    <title>Attendance Percentage</title>
    <style>
        body {
            background-color: #000000;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background-image: url("images//calc.jpg");
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

        .percentage {
            color: #ff4500;
            animation: fadeIn 1s ease-in; /* Animation for percentage */
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

        .date-picker-input, .dropdown {
            background-color: #333;
            border: 1px solid #555;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, border-color 0.3s ease;
            outline: none;
            margin-right: 10px;
        }

        .date-picker-input:hover, .dropdown:hover {
            background-color: #444;
        }

        .date-picker-input:focus, .dropdown:focus {
            background-color: #555;
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

       

        /* Responsive Design */
        @media (max-width: 600px) {
            .date-picker-container {
                flex-direction: column;
                align-items: stretch;
            }

            .date-picker-input, .dropdown, .filter-button {
                margin-bottom: 10px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <h1>Attendance Percentage Calculation</h1>

    <!-- Form to select the filter date and year/section -->
    <form action="AttendancePercentageServlet" method="post">
        <div class="date-picker-container">
            <label for="startDate" class="date-picker-label">Start Date:</label>
            <input type="date" id="startDate" name="startDate" class="date-picker-input" required>
            <label for="endDate" class="date-picker-label">End Date:</label>
            <input type="date" id="endDate" name="endDate" class="date-picker-input" required>

            <!-- Dropdowns for year and section -->
            <label for="year" class="date-picker-label">Year:</label>
            <select id="year" name="year" class="dropdown" required>
                <option value="">Select Year</option>
                <option value="2">2nd Year</option>
                <option value="3">3rd Year</option>
                <option value="4">4th Year</option>
            </select>

            <label for="section" class="date-picker-label">Section:</label>
            <select id="section" name="section" class="dropdown" required>
                <option value="">Select Section</option>
                <option value="a">A</option>
                <option value="b">B</option>
                <option value="c">C</option>
            </select>

            <button type="submit" name="filter" value="filter" class="filter-button">Filter</button>
        </div>
    </form>

    <!-- Table to display attendance data -->
    <table>
        <thead>
            <tr>
                <th>Registration Number</th>
                <th>Name</th>
                <th>Total Days</th>
                <th>Present Days</th>
                <th>Absent Days</th>
                <th>Percentage</th>
            </tr>
        </thead>
        <tbody>
            <% 
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    String year = request.getParameter("year");
                    String section = request.getParameter("section");

                    if (startDate != null && endDate != null && year != null && section != null) {
                        // Define table names based on year and section
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
                        
                        while (rs.next()) {
                            String regNo = rs.getString("REG_NO");
                            String name = rs.getString("NAME");
                            int totalDays = rs.getInt("TOTAL_DAYS");
                            int presentDays = rs.getInt("PRESENT_DAYS");
                            int absentDays = rs.getInt("ABSENT_DAYS");
                            double percentage = (totalDays > 0) ? (presentDays * 100.0 / totalDays) : 0.0;
            %>
            <tr>
                <td><%= regNo %></td>
                <td><%= name %></td>
                <td><%= totalDays %></td>
                <td><%= presentDays %></td>
                <td><%= absentDays %></td>
                <td class="percentage"><%= String.format("%.2f", percentage) %>%</td>
            </tr>
            <% 
                        }
                    } else {
                        out.println("<tr><td colspan='6'>No data available. Please select a date range and year/section.</td></tr>");
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

    <% if (request.getAttribute("message") != null) { %>
        <p style="color: red;"><%= request.getAttribute("message") %></p>
    <% } %>
</body>
</html>
