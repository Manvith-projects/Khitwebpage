package student;



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
import javax.servlet.http.HttpSession;

@WebServlet("/attendanceDataServlet")
public class AttendanceDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Manvith7226");

            // Query attendance data
            pst = con.prepareStatement("SELECT COUNT(*) AS total, SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) AS present FROM attendance WHERE student_id = (SELECT student_id FROM stulogin WHERE username = ?)");
            pst.setString(1, username);
            rs = pst.executeQuery();

            if (rs.next()) {
                int total = rs.getInt("total");
                int present = rs.getInt("present");
                int absent = total - present;

                // Create JSON response
                out.println("{");
                out.println("  \"present\": " + (present * 100 / total) + ",");
                out.println("  \"absent\": " + (absent * 100 / total));
                out.println("}");
            } else {
                out.println("{\"present\": 0, \"absent\": 0}");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("{\"error\": \"An error occurred.\"}");
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
