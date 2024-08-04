<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/a1.jpeg" type="image/icon type">
    <title>Manage Announcements</title>
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: #000000;
            color: #fff;
            padding: 20px;
            background-image: url("images/ann.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            animation: fadeIn 1s ease-in; /* Animation for body */
        }

        h1, h2 {
            background-color: rgba(51, 51, 51, 0.8); /* Semi-transparent background */
            color: #FFCB9A;
            padding: 10px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 10px;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            width: 100%;
            animation: slideIn 1s ease-out; /* Animation for headings */
        }

        form {
            background-color: rgba(30, 30, 30, 0.7); /* Semi-transparent background */
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            animation: fadeInUp 1s ease-out; /* Animation for forms */
        }

        label {
            color: #FFCB9A;
            font-size: 18px;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #555;
            border-radius: 4px;
            font-size: 16px;
            background-color: rgba(51, 51, 51, 0.8); /* Semi-transparent background */
            color: #fff;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            transition: background-color 0.3s ease, border-color 0.3s ease; /* Animation */
        }

        input[type="text"]:hover, textarea:hover {
            background-color: rgba(51, 51, 51, 0.9);
        }

        input[type="text"]:focus, textarea:focus {
            background-color: rgba(51, 51, 51, 1);
            border-color: #FFCB9A;
            box-shadow: 0 0 5px #FFCB9A;
        }

        ::placeholder {
            color: #ccc;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #ff4500;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.2s; /* Animation */
            animation: pulse 1s infinite; /* Animation for submit button */
        }

        input[type="submit"]:hover {
            background-color: #cc3700;
            transform: scale(1.05); /* Scale effect on hover */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            animation: fadeInUp 1s ease-out; /* Animation for table */
        }

        table, th, td {
            border: 1px solid #555;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: rgba(51, 51, 51, 0.8); /* Semi-transparent background */
            color: #FFCB9A;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
        }

        td {
            background-color: rgba(30, 30, 30, 0.7); /* Semi-transparent background */
            color: #fff;
        }

        .delete-button {
            background-color: #d9534f;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s; /* Animation */
        }

        .delete-button:hover {
            background-color: #c9302c;
        }

        .message {
            text-align: center;
            color: #FFCB9A;
            margin: 20px 0;
        }

        .error {
            color: #ff4500;
        }

        .success {
            color: #4CAF50;
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

       
    </style>
</head>
<body>
    <h1>Add a New Announcement</h1>
    <form action="AnnouncementServlet" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required placeholder="Enter announcement title">
        
        <label for="message">Message:</label>
        <textarea id="message" name="message" rows="4" required placeholder="Enter announcement message"></textarea>

        <input type="submit" value="Add Announcement">
    </form>

    <h1>Manage Announcements</h1>
    <form action="AnnouncementServlet" method="post">
        <input type="hidden" name="action" value="delete">
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Message</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Fetch announcements from the database
                    Connection connection = null;
                    PreparedStatement statement = null;
                    ResultSet resultSet = null;

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

                        // Query to fetch all announcements
                        String query = "SELECT id, title, message FROM announcements ORDER BY post_date DESC";
                        statement = connection.prepareStatement(query);
                        resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            int id = resultSet.getInt("id");
                            String title = resultSet.getString("title");
                            String message = resultSet.getString("message");
                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= message %></td>
                    <td>
                        <form action="AnnouncementServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="delete-button">Delete</button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </form>

    <!-- Display messages if available -->
    <% 
        String message = (String) request.getAttribute("message"); // Cast the Object to String
        if (message != null && !message.isEmpty()) {
            String messageClass = message.contains("Error") ? "error" : "success";
    %>
        <p class="message <%= messageClass %>"><%= message %></p>
    <% 
        } 
    %>
</body>
</html>
