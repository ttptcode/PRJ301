

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <style>
            .container {
                width: 400px;
                margin: 50px auto;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                font-family: 'Arial', sans-serif;
            }

            /* Heading style */
            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Paragraph styling */
            p {
                font-size: 16px;
                color: #555;
                line-height: 1.6;
                margin: 10px 0;
            }

            /* Link styling */
            a {
                display: block;
                text-align: center;
                margin: 10px 0;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
                font-size: 16px;
            }

            a:hover {
                background-color: #45a049;
            }

            /* Link specific styling */
            a:last-child {
                background-color: #2196F3;
            }

            a:last-child:hover {
                background-color: #1976D2;
            }

        </style>
    </head>
    <body>  
        <c:if test="${sessionScope.LOGIN_USER==null || sessionScope.LOGIN_USER.roleID ne 'US'}">
            <c:redirect url="login.html"></c:redirect>
        </c:if>

        <div class="container">
            <h2>User information:</h2>
            <p>User ID: ${sessionScope.LOGIN_USER.userID}</p>
            <p>Password: ${sessionScope.LOGIN_USER.password}</p>
            <p>Role ID: ${sessionScope.LOGIN_USER.roleID}</p>
            <p>Full name: ${sessionScope.LOGIN_USER.fullName}</p>
            <c:url value="logoutLink" var="MainController">
                <c:param name="action" value="Logout"></c:param>
            </c:url>
            <a href="${logoutLink}">Logout</a>
            <a href="MainController?action=Shopping_Page">Shopping</a>
            <a href="MainController?action=History_View"> View History </a>

        </div>
    </body>
</html>
