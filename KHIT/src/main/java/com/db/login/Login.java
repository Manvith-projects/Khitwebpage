package com.db.login;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/validate")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        
        String id = request.getParameter("MYUSER");
        String pwd = request.getParameter("MYPWD");
        
        // Check credentials for Admin and CR
        if ("admin".equals(id) && "aiml2022".equals(pwd)) {
            // Admin credentials
            response.sendRedirect("adminhome.jsp");
            return;
        } else if ("cr@aiml-c".equals(id) && "123".equals(pwd)) {
            // CR credentials
            response.sendRedirect("Crhome.jsp");
            return;
        }

        // For students, check against the database
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            // Fetch user details for students
            pst = con.prepareStatement("SELECT password FROM stulogin WHERE username = ?");
            pst.setString(1, id);
            rs = pst.executeQuery();

            if (rs.next()) {
                String storedPwd = rs.getString("password");

                // Compare stored password with the provided password
                if (pwd.equals(storedPwd)) {
                    // Redirect student to their servlet
                    response.sendRedirect("studenthome.jsp");
                } else {
                    pw.print("Login failed due to wrong password..<a href='INDEX.html'>Home</a>");
                }
            } else {
                pw.print("User not found..<a href='INDEX.html'>Home</a>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            pw.print("An error occurred. Please try again later.<a href='INDEX.html'>Home</a>");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
