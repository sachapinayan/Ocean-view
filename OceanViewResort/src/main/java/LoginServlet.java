import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding to handle ISO-8859-1 form data
        request.setCharacterEncoding("ISO-8859-1");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ocean_view_resort", 
                "root", 
                ""
            );

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // SUCCESS -> Store user in session and go to welcome page
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                response.sendRedirect("welcome.jsp");
            } else {
                // FAILURE -> Back to login with error message
                request.setAttribute("error", "Invalid username or password!");
                RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            
            response.setContentType("text/html; charset=ISO-8859-1");
            response.getWriter().println("<h3>Database Connection Error</h3>");
            e.printStackTrace(response.getWriter());
        } finally {
            try { if(con != null) con.close(); } catch(SQLException se) { se.printStackTrace(); }
        }
    }
}