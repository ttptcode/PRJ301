
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* Overall styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
            }

            /* Header styles */
            h1, h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            /* Table styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            /* Total styles */
            h1.total {
                font-size: 24px;
                font-weight: bold;
                text-align: center;
            }

            /* Link styles */
            a {
                display: block;
                text-align: center;
                color: #0077b6;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.LOGIN_USER.fullName}" />
        <h1>User ${user}</h1>

        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:choose>
            <c:when test="${not empty sessionScope.CART}">
                <h2>This is your bill</h2>
            </c:when>
            <c:otherwise>
                <h2>You have not bought anything yet</h2>
            </c:otherwise>
        </c:choose>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="total" value="0"/>
                <c:forEach items="${cart.cart.values()}" var="clothes">
                    <c:set var="itemTotal" value="${clothes.price * clothes.quantity}" />
                    <c:set var="total" value="${total + itemTotal}" />

                    <tr>
                        <td>${clothes.name}</td>
                        <td>${clothes.quantity}</td>
                        <td>${clothes.price}</td>
                        <td>${itemTotal}</td>
                    </tr>

                </c:forEach>
            </tbody>
        </table>
        <h1 class="total">Total: ${total}</h1>
        <c:remove var="CART" scope="session" />
        <a href="user.jsp">Return</a>
    </body>
</html>