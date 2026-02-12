<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.time.*, java.time.temporal.ChronoUnit" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { response.sendRedirect("Login.jsp"); return; }

    String resID = request.getParameter("id");
    if (resID == null) { response.sendRedirect("ViewReservations.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Guest Bill | Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f1f5f9; font-family: 'Poppins', sans-serif; }
        .bill-paper {
            background: white;
            padding: 50px;
            border-radius: 5px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 40px auto;
            border-top: 10px solid #ff9f43; /* Tropical Orange accent */
        }
        .resort-header h1 { font-family: 'Playfair Display', serif; color: #2c3e50; }
        .bill-label { font-weight: 600; color: #7f8c8d; text-transform: uppercase; font-size: 0.8rem; }
        .bill-value { font-size: 1.1rem; color: #2c3e50; margin-bottom: 15px; }
        .total-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
            border-left: 5px solid #00d2ff;
        }
        .btn-print { background-color: #27ae60; color: white; border: none; padding: 10px 25px; border-radius: 5px; }
        .btn-print:hover {
    background-color: #2c3e50;
    color: white;
    transform: scale(1.05);
}
       .btn-back {
    background-color: #00d2ff;
    color: white;
    border-radius: 30px;
    padding: 10px 25px;
    text-decoration: none;
    font-weight: 600;
    transition: 0.3s;
}

.btn-back:hover {
    background-color: #2c3e50;
    color: white;
    transform: scale(1.05);
}
        
        /* Modal Style for Success Message */
        #successModal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center; align-items: center;
        }
        .modal-content {
            background: white; padding: 30px; border-radius: 15px; text-align: center; width: 300px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="bill-paper">
        <div class="row resort-header mb-4">
            <div class="col-6">
                <h1>Ocean View Resort</h1>
                <p>Galle, Sri Lanka</p>
            </div>
            <div class="col-6 text-end">
                <h3 class="text-muted">INVOICE</h3>
                <p>Date: <%= java.time.LocalDate.now() %></p>
            </div>
        </div>

        <hr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ocean_view_resort", "root", "");
                
                // JOIN query to get room price and reservation details together
                String sql = "SELECT res.*, r.price_per_night FROM reservations res " +
                             "JOIN rooms r ON res.room_type = r.room_type " +
                             "WHERE res.reservation_id = ?";
                
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, resID);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String checkIn = rs.getString("check_in");
                    String checkOut = rs.getString("check_out");
                    
                    // Calculate number of nights
                    LocalDate d1 = LocalDate.parse(checkIn);
                    LocalDate d2 = LocalDate.parse(checkOut);
                    long nights = ChronoUnit.DAYS.between(d1, d2);
                    double rate = rs.getDouble("price_per_night");
                    double total = nights * rate;
        %>

        <div class="row mt-4">
            <div class="col-md-6">
                <div class="bill-label">Reservation ID</div>
                <div class="bill-value"><%= rs.getInt("reservation_id") %></div>
                
                <div class="bill-label">Room Type</div>
                <div class="bill-value"><%= rs.getString("room_type") %></div>
            </div>
            <div class="col-md-6">
                <div class="bill-label">Guest Name</div>
                <div class="bill-value"><%= rs.getString("guest_name") %></div>
                               
                <div class="bill-label">Stay Duration</div>
                <div class="bill-value"><%= checkIn %> to <%= checkOut %></div>
            </div>
        </div>

        <div class="total-box">
            <div class="row">
                <div class="col-6">
                    <p>Room Rate (per night):</p>
                    <p>Total Nights:</p>
                    <h4 class="text-primary">TOTAL AMOUNT:</h4>
                </div>
                <div class="col-6 text-end">
                    <p>Rs. <%= rate %></p>
                    <p><%= nights %></p>
                    <h4 class="text-primary">Rs. <%= total %></h4>
                </div>
            </div>
        </div>

        <%
                } else {
                    out.println("<div class='alert alert-danger'>Record not found.</div>");
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>

        <div class="d-flex justify-content-between mt-5">
            <button onclick="showSuccess()" class="btn-print">Print Bill</button>
            <a href="ViewReservations.jsp" class="btn-back">Back</a>
        </div>
    </div>
</div>

<div id="successModal">
    <div class="modal-content shadow-lg">
        <h3 style="color: #27ae60;">Success!</h3>
        <p>The bill has been sent to the printer successfully.</p>
        <button onclick="hideSuccess()" class="btn btn-success px-4">OK</button>
    </div>
</div>

<script>
    function showSuccess() {
        document.getElementById('successModal').style.display = 'flex';
    }
    function hideSuccess() {
        // As per your request: OK button takes you back to this same bill page
        document.getElementById('successModal').style.display = 'none';
    }
</script>

</body>
</html>