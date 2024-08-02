package student;

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
import javax.servlet.http.HttpSession;

@WebServlet("/studentDashboard")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.html"); // Redirect to login if not authenticated
            return;
        }
        
        int totalClasses = 0;
        int attendedClasses = 0;

        try {
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");
            String sql = "SELECT COUNT(*) as total_classes, SUM(CASE WHEN attendance_status = 'Present' THEN 1 ELSE 0 END) as attended_classes FROM students_attendance WHERE reg_no = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalClasses = rs.getInt("total_classes");
                attendedClasses = rs.getInt("attended_classes");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Calculate percentages
        int absentClasses = totalClasses - attendedClasses;
        double attendancePercentage = (totalClasses > 0) ? (attendedClasses / (double) totalClasses) * 100 : 0;
        double absencePercentage = 100 - attendancePercentage;

        // Pass data to JSP
        request.setAttribute("username", username);
        request.setAttribute("attendancePercentage", attendancePercentage);
        request.setAttribute("absencePercentage", absencePercentage);

        request.getRequestDispatcher("studentDashboard.jsp").forward(request, response);
    }
}
