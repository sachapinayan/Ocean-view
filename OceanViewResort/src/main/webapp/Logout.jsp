<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    <title>Ocean View Resort | Logout</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1353&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }

        .logout-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 50px;
            border-radius: 25px;
            width: 480px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .resort-name {
            font-family: 'Playfair Display', serif;
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .warning-icon {
            width: 80px;
            height: 80px;
            background-color: #fff3cd;
            color: #856404;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: bold;
            margin: 0 auto 25px;
            border: 2px solid #ffeeba;
        }

        h2 {
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }

        p {
            color: #666;
            margin-bottom: 35px;
            font-size: 1.1rem;
        }

        .btn-group-custom {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        
        .btn-confirm {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-confirm:hover {
            background-color: #c0392b;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
            color: white;
        }

        
        .btn-cancel {
            background-color: #00d2ff;
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-cancel:hover {
            background-color: #0099cc;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 210, 255, 0.4);
            color: white;
        }
    </style>
</head>
<body>

    <div class="logout-card">
        <div class="resort-name">Ocean View Resort</div>
        <div class="warning-icon">!</div>
        
        <h2>Confirm Logout</h2>
        <p>Are you sure, <span style="color:#ff9f43;"><%= user %></span>?</p>
        
        <div class="btn-group-custom">
            <form action="LogoutServlet" method="post">
                <button type="submit" class="btn-confirm">Confirm Logout</button>
            </form>
            
            <a href="Dashboard.jsp" class="btn-cancel">Cancel</a>
        </div>
    </div>

</body>
</html>