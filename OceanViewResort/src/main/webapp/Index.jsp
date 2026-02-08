<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Ocean View Resort | Galle</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <style>
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body, html { height: 100%; font-family: 'Poppins', sans-serif; color: white; }

        .hero-bg {
            background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), 
                              url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1353&q=80');
            height: 100%;
            background-position: center;
            background-size: cover;
            display: flex;
            flex-direction: column;
        }

        .navbar { display: flex; justify-content: flex-end; padding: 30px 50px; }

        .nav-buttons a {
            text-decoration: none;
            color: white;
            font-weight: 600;
            padding: 12px 25px;
            margin-left: 15px;
            border-radius: 30px;
            transition: all 0.4s ease; 
            text-transform: uppercase;
            font-size: 14px;
            display: inline-block;
        }

        
        .btn-login { 
            background-color: #ff9f43; 
            border: 2px solid #ff9f43;
            box-shadow: 0 4px 15px rgba(255, 159, 67, 0.3);
        }

        
        .btn-login:hover { 
            background-color: #00d2ff; 
            border-color: #00d2ff;
            color: #fff;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 210, 255, 0.5);
        }

        
        .btn-help { 
            background-color: rgba(255, 255, 255, 0.1); 
            border: 2px solid white; 
        }

        /* Hover Effect for Help: Changes from Transparent to Solid White */
        .btn-help:hover { 
            background-color: white; 
            color: #333; /* Dark text for contrast against white background */
            transform: translateY(-3px);
        }

        .content {
            flex: 1; display: flex; flex-direction: column;
            justify-content: center; align-items: center;
            text-align: center; padding: 0 20px;
        }

        .content h1 { font-family: 'Playfair Display', serif; font-size: 80px; margin-bottom: 20px; }
        
        .content p {
            font-size: 20px; max-width: 800px; line-height: 1.6;
            background: rgba(0, 0, 0, 0.3); padding: 20px;
            border-radius: 15px; backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>

    <div class="hero-bg">
        <nav class="navbar">
    <div class="nav-buttons">
        <a href="Login.jsp" class="btn-login">Login</a>
        <a href="help.jsp" class="btn-help">Help</a>
    </div>
</nav>

        <div class="content">
            <h1>Ocean View Resort</h1>
            <p>
                Welcome to Galle's premier destination. The resort features several beachfront cabanas located very close to the ocean.
            </p>
        </div>
    </div>

</body>
</html>