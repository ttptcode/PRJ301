<%-- 
    Document   : topuser
    Created on : Aug 22, 2024, 12:56:43 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                width: 300px;
                text-align: center;
            }

            h1 {
                color: #4CAF50;
                margin-bottom: 20px;
                font-size: 24px;
            }

            p {
                margin: 10px 0;
                font-size: 18px;
            }

            p span {
                font-weight: bold;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>User Information</h1>
            <p>UserID: <span>${sessionScope.TOP_USER.userID}</span></p>
            <p>Full Name: <span>${sessionScope.TOP_USER.fullName}</span></p>
            <p>RoleID: <span>${sessionScope.TOP_USER.roleID}</span></p>
        </div>
    </body>
</html>