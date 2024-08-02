package announcements;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AnnouncementServlet")
public class AnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    deleteAnnouncement(id);
                    request.setAttribute("message", "Announcement deleted successfully!");
                } catch (NumberFormatException e) {
                    request.setAttribute("message", "Invalid announcement ID.");
                }
            } else {
                request.setAttribute("message", "Announcement ID is missing.");
            }
        } else {
            // Handle adding announcement
            String title = request.getParameter("title");
            String message = request.getParameter("message");

            if (title != null && message != null) {
                addAnnouncement(title, message);
                request.setAttribute("message", "Announcement added successfully!");
            } else {
                request.setAttribute("message", "Failed to add announcement. Title or message is missing.");
            }
        }

        // Forward to the JSP page
        request.getRequestDispatcher("/add_announcement.jsp").forward(request, response);
    }

    private void addAnnouncement(String title, String message) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            String query = "INSERT INTO announcements (title, message, post_date) VALUES (?, ?, SYSDATE)";
            statement = connection.prepareStatement(query);
            statement.setString(1, title);
            statement.setString(2, message);
            statement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void deleteAnnouncement(int id) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            String query = "DELETE FROM announcements WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
