<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Ocean View Resort | Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1353&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 20px;
            width: 420px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
        }
        .rules-container {
            font-size: 0.8rem;
            margin-top: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        .rule { color: #888; transition: 0.3s; }
        .rule.valid { color: #157347; font-weight: bold; }
        .rule.valid::before { content: "[OK] "; }
        .rule.invalid::before { content: "[..] "; }
        
        .btn-login { background-color: #ff9f43; color: white; font-weight: 600; border: none; }
        .btn-login:hover { background-color: #00d2ff; color: white; }
        .btn-login:disabled { background-color: #cccccc; cursor: not-allowed; }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.9rem;
            border: 1px solid #f5c6cb;
        }
        .back-home {
    color: #666;
    text-decoration: none;
    transition: all 0.3s ease;
    font-weight: 500;
}

.back-home:hover {
    color: black;  
    text-shadow: 0 0 8px rgba(255, 159, 67, 0.8);
}
        
    </style>
</head>
<body>

<div class="container d-flex flex-column align-items-center">
    <h1 style="color: white; font-family: 'Playfair Display', serif; margin-bottom: 20px; text-shadow: 2px 2px 5px #000;">Ocean View Resort</h1>

    <div class="login-card">
        <h2 class="text-center mb-4">Staff Login</h2>

        <%-- Error Message Display --%>
        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { %>
            <div class="alert-error text-center"> <%= error %> </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required autocomplete="off">
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" id="password" class="form-control" required>
                
                <div class="form-check mt-2">
                    <input class="form-check-input" type="checkbox" id="showPass" onclick="togglePassword()">
                    <label class="form-check-label" style="font-size: 0.85rem;">Show Password</label>
                </div>

                <div class="rules-container">
                    <div id="len" class="rule invalid">8+ Characters</div>
                    <div id="upper" class="rule invalid">1 Uppercase Letter</div>
                    <div id="lower" class="rule invalid">Lowercase Letters</div>
                    <div id="num" class="rule invalid">1 Number</div>
                    <div id="special" class="rule invalid">1 Special Char (@#$%^&*)</div>
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-login py-2" id="submitBtn" disabled>Login</button>
            </div>
        </form>

        <div class="text-center mt-3">
            <a href="Index.jsp" class="back-home">Back to Home</a>

        </div>
    </div>
</div>

<script>
    const passwordInput = document.getElementById('password');
    const submitBtn = document.getElementById('submitBtn');

    const rules = {
        len: { reg: /.{8,}/, el: document.getElementById('len') },
        upper: { reg: /[A-Z]/, el: document.getElementById('upper') },
        lower: { reg: /[a-z]/, el: document.getElementById('lower') },
        num: { reg: /[0-9]/, el: document.getElementById('num') },
        special: { reg: /[!@#$%^&*]/, el: document.getElementById('special') }
    };

    passwordInput.addEventListener('input', () => {
        const val = passwordInput.value;
        let allValid = true;

        for (let key in rules) {
            const isValid = rules[key].reg.test(val);
            if (isValid) {
                rules[key].el.classList.replace('invalid', 'valid');
            } else {
                rules[key].el.classList.replace('valid', 'invalid');
                allValid = false;
            }
        }
        submitBtn.disabled = !allValid;
    });

    function togglePassword() {
        const p = document.getElementById('password');
        p.type = p.type === "password" ? "text" : "password";
    }
</script>
</body>
</html>