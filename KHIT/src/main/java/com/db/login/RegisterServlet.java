package com.db.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob"); // Ensure this is in 'YYYY-MM-DD' format
        String email = request.getParameter("email");
        String securityQuestion1 = request.getParameter("security-question1");
        String securityAnswer1 = request.getParameter("security-answer1");
        String securityQuestion2 = request.getParameter("security-question2");
        String securityAnswer2 = request.getParameter("security-answer2");
        String year = request.getParameter("year");
        String section = request.getParameter("section");

        // Debug statements to check parameter values
        System.out.println("Received parameters:");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("Phone: " + phone);
        System.out.println("Date of Birth: " + dob);
        System.out.println("Email: " + email);
        System.out.println("Security Question 1: " + securityQuestion1);
        System.out.println("Security Answer 1: " + securityAnswer1);
        System.out.println("Security Question 2: " + securityQuestion2);
        System.out.println("Security Answer 2: " + securityAnswer2);
        System.out.println("Year: " + year);
        System.out.println("Section: " + section);

        // Validate username
        if (!isValidUsername(username)) {
            sendJsonResponse(response, "error", "Invalid username format.");
            return;
        }

        // Validate email
        if (!isValidEmail(email)) {
            sendJsonResponse(response, "error", "Invalid email format.");
            return;
        }

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            // Check if username or email already exists
            String checkUserSql = "SELECT username FROM stulogin WHERE username = ? OR email = ?";
            statement = connection.prepareStatement(checkUserSql);
            statement.setString(1, username);
            statement.setString(2, email);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Username or email already exists
                sendJsonResponse(response, "error", "Username or email already in use.");
            } else {
                // Insert new user
                String insertSql = "INSERT INTO stulogin (id, username, password, phone, dob, security_question1, security_answer1, security_question2, security_answer2, year, section, email) " +
                        "VALUES (stulogin_seq.NEXTVAL, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?, ?)";

                statement = connection.prepareStatement(insertSql);
                statement.setString(1, username);
                statement.setString(2, password);
                statement.setString(3, phone);
                statement.setString(4, dob); // Ensure dob is in 'YYYY-MM-DD' format
                statement.setString(5, securityQuestion1);
                statement.setString(6, securityAnswer1);
                statement.setString(7, securityQuestion2);
                statement.setString(8, securityAnswer2);
                statement.setString(9, year);
                statement.setString(10, section);
                statement.setString(11, email);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    sendJsonResponse(response, "success", "New user registered successfully!");
                } else {
                    sendJsonResponse(response, "error", "An error occurred while registering the user.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            sendJsonResponse(response, "error", "An error occurred: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to validate username format
    private boolean isValidUsername(String username) {
        // Define the allowed patterns for username
        String pattern1 = "228x1a42[d-j][0-9]";
        String pattern2 = "238x5a42[0-1][0-4]";

        // Check if username matches any of the patterns
        return username.matches(pattern1) || username.matches(pattern2);
    }

    // Method to validate email format
    private boolean isValidEmail(String email) {
        String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        return email.matches(emailRegex);
    }

    // Method to send JSON response
    private void sendJsonResponse(HttpServletResponse response, String status, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{ \"status\": \"" + status + "\", \"message\": \"" + message + "\" }");
    }
}

