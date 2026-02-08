<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { response.sendRedirect("Login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>New Reservation | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f0f4f8; font-family: 'Poppins', sans-serif; }
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-top: 30px;
            margin-bottom: 50px;
        }
        .header-title {
            font-family: 'Playfair Display', serif;
            color: #2c3e50;
            border-bottom: 3px solid #ff9f43;
            display: inline-block;
            margin-bottom: 30px;
        }
        .btn-save { background-color: orange; color: white; font-weight: 600; border: none; }
        .btn-save:hover { background-color: #e68a2e; color: white; }
        .error-hint { color: #e74c3c; font-size: 0.8rem; display: none; margin-top: 5px; }
        .btn-back {
            background-color: #00d2ff;
            color: white;
            border-radius: 30px;
            padding: 10px 25px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-back:hover { background-color: #2c3e50; transform: scale(1.05); }
        .btn-clear {
            background-color: #95a5a6;
            color: white;
            font-weight: 600;
        }
        .btn-clear:hover { background-color: black; color: white; }
        
        
        .input-error-highlight { border: 2px solid #e74c3c !important; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mt-5">
        <h2 class="header-title">Add New Reservation</h2>
        <a href="Dashboard.jsp" class="btn-back">Back</a>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("msg") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("msg") %></div>
        <% } else if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="SaveReservationServlet" method="post" onsubmit="return validateForm()">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Reservation ID (Auto-Generated)</label>
                    <input type="text" class="form-control" placeholder="SYSTEM GENERATED" disabled>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Guest Name</label>
                    <input type="text" name="guest_name" class="form-control" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Contact Number</label>
                    <input type="text" name="contact" id="contact" class="form-control" required maxlength="10">
                    <div id="contactError" class="error-hint">Must be exactly 10 digits (numbers only).</div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Room Type</label>
                    <select name="room_type" class="form-select" required>
                        <option value="">Select Room Type...</option>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ocean_view_resort", "root", "");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT room_type FROM rooms");
                                while(rs.next()){
                                    out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
                                }
                                con.close();
                            } catch(Exception e) { out.println("<option>Error loading rooms</option>"); }
                        %>
                    </select>
                </div>

                <div class="col-12 mb-3">
                    <label class="form-label">Address</label>
                    <textarea name="address" class="form-control" rows="2" required></textarea>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Check-in Date</label>
                    <input type="date" name="check_in" id="check_in" class="form-control" required>
                    <div id="checkInRequiredError" class="error-hint">Please select Check-in date first!</div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Check-out Date</label>
                    <input type="date" name="check_out" id="check_out" class="form-control" required>
                    <div id="dateError" class="error-hint">Check-out must be after Check-in date.</div>
                </div>
            </div>

            <div class="mt-4 d-flex gap-3">
                <button type="submit" class="btn btn-save px-5">Save Reservation</button>
                <button type="reset" class="btn btn-clear px-5" onclick="resetValidation()">Clear Form</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const checkInInput = document.getElementById('check_in');
        const checkOutInput = document.getElementById('check_out');
        const checkInErrorHint = document.getElementById('checkInRequiredError');

        // FIXED: Use local date instead of UTC to avoid "previous day" bug
        const now = new Date();
        const offset = now.getTimezoneOffset() * 60000;
        const today = (new Date(now - offset)).toISOString().split('T')[0];

        checkInInput.setAttribute('min', today);
        checkOutInput.setAttribute('min', today);

        // Rest of your logic remains the same...
        checkOutInput.addEventListener('mousedown', function(e) {
            if (!checkInInput.value) {
                e.preventDefault();
                checkInErrorHint.style.display = 'block';
                checkInInput.classList.add('input-error-highlight');
                checkInInput.focus();
            }
        });

        checkInInput.addEventListener('input', function() {
            if (this.value) {
                checkInErrorHint.style.display = 'none';
                checkInInput.classList.remove('input-error-highlight');
                
                let checkInDate = new Date(this.value);
                let nextDay = new Date(checkInDate);
                nextDay.setDate(nextDay.getDate() + 1);
                checkOutInput.setAttribute('min', nextDay.toISOString().split('T')[0]);
            }
        });
    });


    function validateForm() {
        let isValid = true;
        const contact = document.getElementById('contact').value;
        const checkIn = document.getElementById('check_in').value;
        const checkOut = document.getElementById('check_out').value;
        
        // Contact Validation
        const contactRegex = /^[0-9]{10}$/;
        if (!contactRegex.test(contact)) {
            document.getElementById('contactError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('contactError').style.display = 'none';
        }

        // Final Date Logic Check
        if (new Date(checkOut) <= new Date(checkIn)) {
            document.getElementById('dateError').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('dateError').style.display = 'none';
        }

        return isValid;
    }

    function resetValidation() {
        document.getElementById('checkInRequiredError').style.display = 'none';
        document.getElementById('check_in').classList.remove('input-error-highlight');
        document.getElementById('contactError').style.display = 'none';
        document.getElementById('dateError').style.display = 'none';
    }
</script>

</body>
</html>