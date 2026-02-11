<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Login | CineStream</title>

            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: #141414;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .login-container {
                    background: #181818;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(229, 9, 20, 0.4);
                    border: 2px solid #E50914;
                    overflow: hidden;
                    max-width: 450px;
                    width: 100%;
                    animation: slideIn 0.5s ease-out;
                }

                @keyframes slideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .login-header {
                    background: #E50914;
                    color: white;
                    padding: 40px 30px;
                    text-align: center;
                }

                .login-header i {
                    font-size: 48px;
                    margin-bottom: 15px;
                    display: block;
                }

                .login-header h1 {
                    font-size: 28px;
                    font-weight: 600;
                    margin-bottom: 8px;
                }

                .login-header p {
                    font-size: 14px;
                    opacity: 0.9;
                }

                .login-body {
                    padding: 40px 30px;
                }

                .form-group {
                    margin-bottom: 25px;
                }

                .form-group label {
                    display: block;
                    font-weight: 500;
                    color: #ffffff;
                    margin-bottom: 8px;
                    font-size: 14px;
                }

                .form-group input {
                    width: 100%;
                    padding: 14px 18px;
                    border: 2px solid #333;
                    background: #2F2F2F;
                    color: white;
                    border-radius: 10px;
                    font-size: 15px;
                    font-family: 'Outfit', sans-serif;
                    transition: all 0.3s ease;
                }

                .form-group input:focus {
                    outline: none;
                    border-color: #E50914;
                    box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.2);
                }

                .btn-login {
                    width: 100%;
                    padding: 15px;
                    background: #E50914;
                    color: white;
                    border: none;
                    border-radius: 10px;
                    font-size: 16px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: transform 0.2s, box-shadow 0.2s;
                    font-family: 'Outfit', sans-serif;
                }

                .btn-login:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 20px rgba(229, 9, 20, 0.6);
                    background: #b20710;
                }

                .btn-login:active {
                    transform: translateY(0);
                }

                .error-message {
                    background: #fee;
                    color: #c33;
                    padding: 12px 18px;
                    border-radius: 10px;
                    margin-bottom: 20px;
                    border-left: 4px solid #c33;
                    font-size: 14px;
                    animation: shake 0.4s;
                }

                @keyframes shake {

                    0%,
                    100% {
                        transform: translateX(0);
                    }

                    25% {
                        transform: translateX(-10px);
                    }

                    75% {
                        transform: translateX(10px);
                    }
                }

                .back-home {
                    text-align: center;
                    margin-top: 20px;
                }

                .back-home a {
                    color: #E50914;
                    text-decoration: none;
                    font-size: 14px;
                    transition: color 0.3s;
                }

                .back-home a:hover {
                    color: #b20710;
                }
            </style>
        </head>

        <body>
            <div class="login-container">
                <div class="login-header">
                    <i class="bi bi-shield-lock"></i>
                    <h1>Administration</h1>
                    <p>Accès réservé aux administrateurs</p>
                </div>

                <div class="login-body">
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/login" method="post">
                        <div class="form-group">
                            <label for="email">
                                <i class="bi bi-envelope"></i> Email
                            </label>
                            <input type="email" id="email" name="email" placeholder="admin@admin" required autofocus>
                        </div>

                        <div class="form-group">
                            <label for="password">
                                <i class="bi bi-lock"></i> Mot de passe
                            </label>
                            <input type="password" id="password" name="password" placeholder="••••••••" required>
                        </div>

                        <button type="submit" class="btn-login">
                            <i class="bi bi-box-arrow-in-right"></i> Se connecter
                        </button>
                    </form>

                    <div class="back-home">
                        <a href="${pageContext.request.contextPath}/">
                            <i class="bi bi-arrow-left"></i> Retour à l'accueil
                        </a>
                    </div>
                </div>
            </div>
        </body>

        </html>