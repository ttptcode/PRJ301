
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.shopping.CLothes2"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Tuc Store</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                background-color: #f4f4f4;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                font-family: 'Arial', sans-serif;
            }

            /* Heading style */
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
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

            /* Button styling */
            .btn {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
                margin: 5px;
            }

            .btn:hover {
                background-color: #45a049;
            }

            /* Message styling */
            p {
                color: #d9534f;
                text-align: center;
                font-size: 16px;
                font-weight: bold;
            }

            /* Responsive design for smaller screens */
            @media (max-width: 768px) {
                .container {
                    width: 95%;
                }

                table th, table td {
                    padding: 8px;
                    font-size: 14px;
                }

                .btn {
                    font-size: 14px;
                    padding: 8px 16px;
                }
            }

        </style>


    </head>
    <body>
        <div class="container">
            <h1>Welcome to ttpt's Store</h1>
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Remain</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Add</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="clothes" varStatus="loop" items="${requestScope.LIST_SHOPPING}">
                    <form action="MainController" method="POST">
                        <tr>
                            <td>${loop.count}</td>
                            <td>${clothes.id}</td>
                            <td>${clothes.name}</td>
                            <td>${clothes.quantity}</td>
                            <td>
                                <select name="cmbQuantity">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                            </td>
                            <td>${clothes.price}$</td>
                            <td>
                                <input type="hidden" name="id" value="${clothes.id}"/>
                                <button type="submit" name="action" value="Add" class="btn">Add</button>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
                </tbody>
            </table>

            <form action="MainController" method="POST">
                <button type="submit" name="action" value="View" class="btn">View</button>
            </form>
            <c:if test="${not empty sessionScope.MESSAGE}">
                <p>${sessionScope.MESSAGE}</p>
            </c:if>
            <c:if test="${not empty sessionScope.MESSAGE2}">
                <p>${sessionScope.MESSAGE2}</p>
            </c:if>
        </div>
    </body>
</html>