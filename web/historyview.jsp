

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        td {
            color: #555;
        }
    </style>
</head>
<body>
    <h1>This is your buying history</h1>
    <table border="0">
        <thead>
            <tr>
                <th>Date</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="list_his" value="${sessionScope.HIS_USER}"/>
            <c:forEach var="user" items="${list_his}">
                <tr>
                    <td>${user.date}</td>
                    <td>${user.product}</td>
                    <td>${user.quantity}</td>
                    <td>${user.price}</td>
                    <td>${user.total}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>