<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Ocean View Resort | Help System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #00d2ff;
            --ocean-dark: #2c3e50;
            --accent-orange: #ff9f43;
        }
        body { background-color: #f4f7f6; font-family: 'Poppins', sans-serif; color: #444; }
        .help-hero {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('Images/1.jpg');
            background-size: cover; background-position: center; color: white; padding: 80px 0; text-align: center; margin-bottom: 50px; border-bottom: 5px solid var(--primary-blue);
        }
        .step-card { background: white; border-radius: 20px; padding: 30px; margin-bottom: 60px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border-left: 8px solid var(--primary-blue); }
        .step-badge { background: var(--ocean-dark); color: white; padding: 5px 20px; border-radius: 50px; font-weight: 600; display: inline-block; margin-bottom: 20px; }
        .screenshot-frame { background: #e9ecef; padding: 15px; border-radius: 12px; margin: 20px 0; border: 1px solid #ddd; }
        .screenshot-frame img { width: 100%; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
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
    </style>
</head>
<body>

    <div class="help-hero">
        <div class="container">
            <h1>System User Guide</h1>
            <p>Ocean View Resort Management System</p>
        </div>
    </div>

    <div class="container" style="max-width: 900px;">

        <div class="step-card">
            <span class="step-badge">Step 1</span>
            <h3>Accessing the Resort Portal</h3>
            <p>Start at the Home Page. Click the "Login" button at the top right.</p>
            <div class="screenshot-frame">
                <img src="Images/1.png" alt="Home Page">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 2</span>
            <h3>Staff Authentication</h3>
            <p>Enter credentials and check the real-time password validation and click the "Login" button.</p>
            <div class="screenshot-frame">
                <img src="Images/1-1.png" alt="Login">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 3</span>
            <h3>Handling New Reservations</h3>
            <p>Fill the reservation form. Note the system-generated ID and please select check in date first.</p>
            <div class="screenshot-frame">
                <img src="Images/7.png" alt="Add Reservation">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 4</span>
            <h3>Contact Number Handling</h3>
            <p>Must be exactly 10 digits in numbers only.</p>
            <div class="screenshot-frame">
                <img src="Images/5.png" alt="Validation">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 5</span>
            <h3>Searching Records</h3>
            <p>Use the View page to search by Reservation ID and that ID's bill generate. So click "Create Bill" button.</p>
            <div class="screenshot-frame">
                <img src="Images/11.png" alt="View Records">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 6</span>
            <h3>Generating Invoice</h3>
            <p>The system calculates the total amount automatically and click the "Print Bill" button print bill in printer.</p>
            <div class="screenshot-frame">
                <img src="Images/13.png" alt="Invoice">
            </div>
        </div>

        <div class="step-card">
            <span class="step-badge">Step 7</span>
            <h3>Logout</h3>
            <p>Confirm logout to end your session safely.</p>
            <div class="screenshot-frame">
                <img src="Images/9.png" alt="Logout">
            </div>
        </div>

        <div class="text-center">
            <a href="Index.jsp" class="btn-back">Back</a>
        </div>
    </div>

</body>
</html>