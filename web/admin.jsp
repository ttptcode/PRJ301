
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="sample.users.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <style>

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f8f8;
                color: #333;
                margin: 0;
                padding: 0;
            }

            /* Header styling */
            h1 {
                text-align: center;
                color: #333;
                margin: 20px 0;
            }

            /* Table styling */
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            table th, table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            table th {
                background-color: #4CAF50;
                color: white;
                font-weight: bold;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #f1f1f1;
            }

            /* Form styling */
            form {
                display: flex;
                justify-content: center;
                margin: 20px 0;
            }

            form input[type="text"] {
                padding: 8px;
                margin-right: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            form input[type="submit"] {
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            form input[type="submit"]:hover {
                background-color: #45a049;
            }

            /* Link styling */
            a {
                display: inline-block;
                padding: 8px 16px;
                background-color: #f44336;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            a:hover {
                background-color: #d32f2f;
            }

            /* Error message styling */
            .error {
                width: 90%;
                margin: 20px auto;
                padding: 10px;
                background-color: #f44336;
                color: white;
                text-align: center;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .aa1 {
                display: flex;
                justify-content: center;
                align-items: center;
                 /* 100% of the viewport height */
                background-color: #f8f8f8; /* Optional background color */
                text-align: center;
                font-size: 18px;
                color: white;
                text-decoration: none;
                 /* Green background */
                padding: 10px 20px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            /* Hover effect */
            .aa1:hover {
                background-color: #45a049; /* Darker green on hover */
            }
        </style>


    </head>
    <body>
        <c:if test="${sessionScope.LOGIN_USER==null || sessionScope.LOGIN_USER.roleID ne 'AD' }">
            <c:redirect url="login.html"></c:redirect>
        </c:if>
        <h1>Welcome ${sessionScope.LOGIN_USER.fullName}</h1>
        <c:url var="logoutLink" value="MainController">
            <c:param name="action" value="Logout">
            </c:param>
        </c:url>
        <a class="aa1" href="${logoutLink}">Logout</a>
        <form action="MainController" method="POST"> 
            Search: <input type="text" name="search" value="${param.search}"/>
            <input type="submit" name="action" value="Search"/>

        </form>
        <c:if test="${requestScope.LIST_USER !=null}">
            <c:if test="${not empty requestScope.LIST_USER}">
                <table>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>User ID</th>
                            <th>Full name</th>
                            <th>Role ID</th>
                            <th>Password</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" varStatus="counter" items="${requestScope.LIST_USER}">
                        <form action="MainController" method="POST">
                            <tr>
                                
                                <td>${counter.count}</td>
                                <td>
                                    <input type="text" name="userID" value="${user.userID}"/>
                                </td>
                                <td>
                                    <input type="text" name="fullName" value="${user.fullName}" required=""/>
                                </td>
                                <td>
                                    <input type="text" name="roleID" value="${user.roleID}" required=""/>
                                </td>
                                <td>
                                    ${user.password}
                                </td>
                                <td>
                                    <input type="submit" name="action" value="Update" /> 
                                    <input type="hidden" name="search" value="${param.search}" /> 
                                </td>
                                <td>
                                    <c:url var="deleteLink" value="MainController">
                                        <c:param name="action" value="Delete">
                                        </c:param>   
                                        <c:param name="userID" value="${user.userID}">
                                        </c:param>


                                    </c:url>
                                    <a href="${deleteLink}">Delete</a>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${not empty requestScope.ERROR}">
                <div class="error">${requestScope.ERROR}</div>
            </c:if>
        </c:if>
    </c:if>
</body>
</html>