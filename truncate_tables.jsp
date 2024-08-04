<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Truncate Tables</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        * {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        body {
            background-image: url('images/1.png'); /* Adjust as needed */
            background-size: cover;
            background-color: #000000;
            color: #fff;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #FFCB9A;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            background-color: rgba(30, 30, 30, 0.9); /* Semi-transparent background */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3); /* Soft box shadow */
            max-width: 400px;
            margin: 0 auto;
            backdrop-filter: blur(10px); /* Blur effect */
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #FFCB9A;
        }

        select,
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #333;
            border-radius: 5px;
            background-color: rgba(46, 46, 46, 0.8); /* Semi-transparent background */
            color: #fff;
        }

        input[type="submit"] {
            background-color: #ff004f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #cc003a; /* Darker shade on hover */
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.7);
        }

        input[type="submit"]:active {
            background-color: #b3002f; /* Darker shade on active */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        .message {
            color: #FFCB9A;
            text-align: center;
            margin-top: 20px;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <h2>Truncate Tables</h2>

    <% 
        String action = request.getParameter("action");
        String year = request.getParameter("year");
        String section = request.getParameter("section");

        if ("Submit".equals(action) && year != null && section != null) {
            // Database connection parameters
            String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl"; // Update with your database URL
            String jdbcUser = "system"; // Update with your database username
            String jdbcPassword = "Manvith7226"; // Update with your database password

            Connection connection = null;
            Statement statement = null;

            try {
                // Load Oracle JDBC driver (if needed)
                Class.forName("oracle.jdbc.driver.OracleDriver");

                // Establish the database connection
                connection = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                statement = connection.createStatement();

                // Construct suffixes based on year and section
                String suffix = year + section;

                // Define table prefixes
                String[] tablePrefixes = { "students_attendance_","students_" };

                // Generate and execute the truncate SQL for both table prefixes
                for (String prefix : tablePrefixes) {
                    String tableName = prefix + suffix;
                    try {
                        String truncateSQL = "TRUNCATE TABLE " + tableName;
                        statement.executeUpdate(truncateSQL);
                        out.println("<p class='message'>Table " + tableName + " has been truncated.</p>");
                    } catch (SQLException e) {
                        out.println("<p class='message'>Error truncating table " + tableName + ": " + e.getMessage() + "</p>");
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='message'>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try {
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='message'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        } else {
            // Display the input form
    %>
    <form action="truncate_tables.jsp" method="post">
        <label for="year">Year:</label>
        <select id="year" name="year" required>
            <option value="">Select Year</option>
            <option value="2">2ND YEAR</option>
            <option value="3">3RD YEAR</option>
            <option value="4">4TH YEAR</option>
            <!-- Add more years as needed -->
        </select>
        
        <label for="section">Section:</label>
        <select id="section" name="section" required>
            <option value="">Select Section</option>
            <option value="a">A</option>
            <option value="b">B</option>
            <option value="c">C</option>
            <!-- Add more sections as needed -->
        </select>
        
        <input type="submit" name="action" value="Submit">
    </form>
    <% 
        }
    %>
</body>
</html>
