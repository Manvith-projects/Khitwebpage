package files;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/fileServlet")
@MultipartConfig
public class FileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("Upload".equals(action)) {
            Part filePart = request.getPart("file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            File uploads = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR);
            if (!uploads.exists()) {
                uploads.mkdirs();
            }
            File file = new File(uploads, fileName);
            filePart.write(file.getAbsolutePath());
            response.sendRedirect("results.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("List".equals(action)) {
            File uploads = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR);
            File[] files = uploads.listFiles();
            request.setAttribute("files", files);
            request.getRequestDispatcher("results.jsp").forward(request, response);
        } else if ("Download".equals(action)) {
            String fileName = request.getParameter("fileName");
            File file = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + fileName);
            if (file.exists()) {
                response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
                Files.copy(file.toPath(), response.getOutputStream());
            }
        } else if ("Delete".equals(action)) {
            String fileName = request.getParameter("fileName");
            File file = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + fileName);
            if (file.exists()) {
                file.delete();
            }
            response.sendRedirect("results.jsp");
        }
    }
}
