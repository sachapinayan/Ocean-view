<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    // Security: Redirect to login if session is invalid
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Room Details | Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f4f7f6; font-family: 'Poppins', sans-serif; }
        
        .header-strip {
            background: #2c3e50;
            color: white;
            padding: 20px 0;
            text-align: center;
        }

        
        .room-img {
            height: 200px;
            object-fit: cover;
            border-radius: 15px 15px 0 0;
        }

        .room-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            background: white;
        }

        .price-tag {
            background: #ff9f43;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
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

        table { background: white; border-radius: 15px; overflow: hidden; }
        th { background-color: #00d2ff; color: white; }
    </style>
</head>
<body>

    <div class="header-strip">
        <h1 style="font-family: 'Playfair Display', serif;">Our Luxury Accommodations</h1>
        <p>Galle's Finest Selection of Rooms</p>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-4">
                <div class="room-card">
                    <img src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=500&q=80" class="room-img w-100" alt="Single">
                    <div class="p-3 text-center">
                        <h5>Single Rooms</h5>
                        <small class="text-muted">Perfect for solo travelers</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="room-card">
                    <img src="https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=500&q=80" class="room-img w-100" alt="Double">
                    <div class="p-3 text-center">
                        <h5>Double Rooms</h5>
                        <small class="text-muted">Comfort for couples</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="room-card">
                    <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=500&q=80" class="room-img w-100" alt="Suite">
                    <div class="p-3 text-center">
                        <h5>Deluxe Room</h5>
                        <small class="text-muted">Premium luxury experience</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <h3 class="mb-4" style="font-family: 'Playfair Display', serif;">Room Rates & Facilities</h3>
                <div class="table-responsive shadow">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th class="ps-4">Room Type</th>
                                <th>Price Per Night</th>
                                <th class="pe-4">Facilities</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ocean_view_resort", "root", "");
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM rooms");

                                    while(rs.next()) {
                            %>
                            <tr>
                                <td class="ps-4 fw-bold text-uppercase"><%= rs.getString("room_type") %></td>
                                <td><span class="price-tag">Rs. <%= rs.getDouble("price_per_night") %></span></td>
                                <td class="pe-4 text-muted"><%= rs.getString("facilities") %></td>
                            </tr>
                            <%
                                    }
                                    con.close();
                                } catch(Exception e) {
                                    out.print("<tr><td colspan='3' class='text-danger'>Error loading data: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="text-center my-5">
            <a href="Dashboard.jsp" class="btn-back">Back</a>
        </div>
    </div>

</body>
</html>