<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    <title>Resort Dashboard | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #f0f4f8; 
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }

        
        .top-nav {
            background-color: #2c3e50;
            padding: 15px 50px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .resort-brand {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: bold;
        }

        
        .dashboard-header {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 60px 20px;
            text-align: center;
            margin-bottom: 40px;
        }

        
        .action-card {
            background: white;
            border: none;
            border-radius: 20px;
            padding: 40px 20px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            text-decoration: none;
            display: block;
            height: 100%;
        }

        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .icon-circle {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            font-weight: bold;
            color: white;
        }

        
        .bg-room { background-color: #00d2ff; }
        .bg-add { background-color: #ff9f43; }
        .bg-view { background-color: #2ecc71; }
        .bg-logout { background-color: #e74c3c; }

        .card-title {
            color: #2c3e50;
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .card-desc {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <nav class="top-nav">
        <div class="resort-brand">Ocean View Resort</div>
        <div>
            Logged in as: <span style="color: #ff9f43; font-weight: bold;"><%= user %></span>
        </div>
    </nav>

    <div class="dashboard-header">
        <h1 style="font-family: 'Playfair Display', serif; font-size: 45px;">Management Portal</h1>
        <p>Galle Coastline Premier Reservation System</p>
    </div>

    <div class="container">
        <div class="row g-4 justify-content-center">
            
            <div class="col-md-3">
                <a href="RoomDetails.jsp" class="action-card">
                    <div class="icon-circle bg-room">R</div>
                    <div class="card-title">Room Details</div>
                    <p class="card-desc">Check availability and room types.</p>
                </a>
            </div>

            <div class="col-md-3">
                <a href="AddReservation.jsp" class="action-card">
                    <div class="icon-circle bg-add">A</div>
                    <div class="card-title">New Booking</div>
                    <p class="card-desc">Register a new guest and stay.</p>
                </a>
            </div>

            <div class="col-md-3">
                <a href="ViewReservations.jsp" class="action-card">
                    <div class="icon-circle bg-view">V</div>
                    <div class="card-title">View Reservation Details</div>
                    <p class="card-desc">View the guest and stay details</p>
                </a>
            </div>

            <div class="col-md-3">
                <a href="Logout.jsp" class="action-card">
                    <div class="icon-circle bg-logout">L</div>
                    <div class="card-title">Logout</div>
                    <p class="card-desc">Safely exit the system.</p>
                </a>
            </div>

        </div>
        
    </div>

    <footer class="text-center mt-5 py-4 text-muted" style="font-size: 0.8rem;">
        (C) 2026 Ocean View Resort - Galle, Sri Lanka
    </footer>

</body>
</html>