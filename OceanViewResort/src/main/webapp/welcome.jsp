<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Welcome</title>

    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #1c92d2, #f2fcfe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .welcome-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            width: 420px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        .welcome-card h2 {
            color: #1c92d2;
            margin-bottom: 15px;
        }

        .welcome-card p {
            font-size: 16px;
            color: #555;
        }

        .btn-dashboard {
            background-color: #1c92d2;
            color: white;
            margin-top: 20px;
        }

        .btn-dashboard:hover {
            background-color: #166fa3;
        }

        .resort-title {
            font-size: 26px;
            font-weight: bold;
            color: #1c92d2;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<div class="welcome-card">

    <div class="resort-title"><h1>Ocean View Resort</h1></div>

    <h2>Welcome</h2>

    <p>Login successful.</p>
    <p>We are happy to have you. Enjoy managing your resort services.</p>

    <a href="Dashboard.jsp" class="btn btn-dashboard">Go to Dashboard</a>

</div>

</body>
</html>
