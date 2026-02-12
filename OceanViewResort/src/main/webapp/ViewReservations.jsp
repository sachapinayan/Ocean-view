<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    
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
<title>View Reservations | Ocean View Resort</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

<style>
body { background-color: #f8fafc; font-family: 'Poppins', sans-serif; }

.header-banner {
    background: linear-gradient(45deg, #2c3e50, #00d2ff);
    color: white;
    padding: 40px 0;
    text-align: center;
    margin-bottom: 30px;
}

.search-container {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    margin-bottom: 30px;
}

.table-card {
    background: white;
    border-radius: 15px;
    padding: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}

.btn-search {
    background-color: #00d2ff;
    color: white;
    font-weight: 600;
}

.btn-search:hover {
    background-color: #00b8e6;
    color: white;
}

.btn-clear {
    background-color: #6c757d;
    color: white;
    font-weight: 600;
}

.btn-clear:hover {
    background-color: #495057;
    color: white;
}

.btn-bill {
    background-color: #28a745;
    color: white;
    font-size: 0.85rem;
    padding: 6px 14px;
    border-radius: 6px;
    text-decoration: none;
    transition: 0.3s;
}

.btn-bill:hover {
    background-color: #dc3545;
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

th {
    background-color: #f1f5f9;
    color: #475569;
    text-transform: uppercase;
    font-size: 0.85rem;
}

.no-records {
    color: #FF0000;
    font-weight: 600;
    padding: 20px;
    text-align: center;
}

.error-message {
    color: red;
    font-weight: 600;
    margin-top: 10px;
}
</style>
</head>

<body>

<div class="header-banner">
    <h1 style="font-family: 'Playfair Display', serif;">View Reservation Details</h1>
    <p>View and Search Guest Booking Information</p>
</div>

<div class="container">

    <div class="search-container">
        <form action="ViewReservations.jsp" method="get" class="row g-3 align-items-end">
            <div class="col-md-6">
                <label class="form-label fw-bold">Search by Reservation ID</label>
                <input type="text" name="searchID" class="form-control"
                       placeholder="Enter ID (e.g. 101)"
                       value="<%= request.getParameter("searchID") != null ? request.getParameter("searchID") : "" %>"
                       autocomplete="off">
            </div>

            <div class="col-md-3 d-grid">
                <button type="submit" name="searchBtn" value="search" class="btn btn-search">Search</button>
            </div>

            <div class="col-md-3 d-grid">
                <a href="ViewReservations.jsp" class="btn btn-clear">Clear</a>
            </div>
        </form>

        <%
            String searchID = request.getParameter("searchID");
            String searchBtn = request.getParameter("searchBtn");

            if (searchBtn != null && (searchID == null || searchID.trim().isEmpty())) {
        %>
                <div class="error-message">Enter Reservation ID</div>
        <%
            }
        %>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Guest Name</th>
                    <th>Address</th>
                    <th>Contact</th>
                    <th>Room Type</th>
                    <th>Check In</th>
                    <th>Check Out</th>
                    <th>Bill</th>
                </tr>
                </thead>
                <tbody>

<%
    Connection con = null;
    boolean recordFound = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ocean_view_resort", "root", "");

        String sql;
        PreparedStatement ps;

        if (searchID != null && !searchID.trim().isEmpty()) {
            sql = "SELECT * FROM reservations WHERE reservation_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, searchID);
        } else {
            sql = "SELECT * FROM reservations ORDER BY reservation_id DESC";
            ps = con.prepareStatement(sql);
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            recordFound = true;
%>
            <tr>
                <td class="fw-bold"><%= rs.getInt("reservation_id") %></td>
                <td><%= rs.getString("guest_name") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("contact_number") %></td>
                <td><span class="badge bg-info text-dark"><%= rs.getString("room_type") %></span></td>
                <td><%= rs.getString("check_in") %></td>
                <td><%= rs.getString("check_out") %></td>
                <td>
                    <a href="GenerateBill.jsp?id=<%= rs.getInt("reservation_id") %>"
                       class="btn-bill">Create Bill</a>
                </td>
            </tr>
<%
        }

        if (!recordFound) {
%>
            <tr>
                <td colspan="8" class="no-records">
                    No Records Found
                </td>
            </tr>
<%
        }

    } catch (Exception e) {
        out.println("<tr><td colspan='8' class='no-records'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        if (con != null) con.close();
    }
%>

                </tbody>
            </table>
        </div>
    </div>

    <div class="text-center mt-5 mb-5">
        <a href="Dashboard.jsp" class="btn-back">Back</a>
    </div>

</div>

</body>
</html>
