import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/SaveReservationServlet")
public class SaveReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("ISO-8859-1");

        String guestName = request.getParameter("guest_name");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        String roomType = request.getParameter("room_type");
        String checkIn = request.getParameter("check_in");
        String checkOut = request.getParameter("check_out");

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/ocean_view_resort",
                    "root",
                    ""
            );

            // 1️⃣ Check for overlapping reservation for the same guest
            String checkSql =
                "SELECT COUNT(*) FROM reservations " +
                "WHERE guest_name = ? " +
                "AND (? < check_out AND ? > check_in)";

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, guestName);
            checkPs.setString(2, checkIn);
            checkPs.setString(3, checkOut);

            ResultSet rs = checkPs.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                request.setAttribute("error", 
                    "This guest already has a reservation during the selected dates."
                );
                RequestDispatcher rd = request.getRequestDispatcher("AddReservation.jsp");
                rd.forward(request, response);
                return; // Stop further execution
            }

            // ✅ Insert reservation
            String sql =
                "INSERT INTO reservations " +
                "(guest_name, address, contact_number, room_type, check_in, check_out) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, guestName);
            ps.setString(2, address);
            ps.setString(3, contact);
            ps.setString(4, roomType);
            ps.setString(5, checkIn);
            ps.setString(6, checkOut);

            int result = ps.executeUpdate();

            if (result > 0) {
                request.setAttribute(
                    "msg",
                    "Reservation for " + guestName + " saved successfully!"
                );
            } else {
                request.setAttribute(
                    "error",
                    "Failed to save reservation."
                );
            }

        } catch (Exception e) {
            request.setAttribute("error", "Database Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }

        request.getRequestDispatcher("AddReservation.jsp")
               .forward(request, response);
    }
}
