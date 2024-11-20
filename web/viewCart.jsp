

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="sample.shopping.Cart"%>
<%@page import="sample.shopping.Clothes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tuc dep trai Store</title>
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                margin-top: 20px;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            /* Form Styles */
            form {
                display: flex;
                align-items: center;
            }

            input[type="number"] {
                width: 60px;
                padding: 5px;
                margin-right: 10px;
            }

            button {
                padding: 5px 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }

            /* Link Styles */
            a {
                color: #007bff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }
            button[name="action"][value="Purchase"] {
                background-color: white;
                color: black;
                transition: transform 0.3s ease-in-out;
            }

            button[name="action"][value="Purchase"]:hover {
                transform: scale(1.1);
                color: #007bff;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h1>Your shopping cart</h1>

        <c:if test="${not empty sessionScope.CART}">
            <c:set var="cart" value="${sessionScope.CART}" />

            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Remove</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="1" />
                    <c:set var="total" value="0.0" />

                    <c:forEach var="clothes" items="${cart.cart.values()}">
                        <c:set var="itemTotal" value="${clothes.price * clothes.quantity}" />
                        <c:set var="total" value="${total + itemTotal}" />

                        <tr>
                            <td>${count}</td>
                            <td>${clothes.id}</td>
                            <td>${clothes.name}</td>
                            <td>
                                <form action="MainController" method="POST">
                                    <input type="number" name="quantity" min="1" value="${clothes.quantity}" />
                                    <input type="hidden" name="Id" value="${clothes.id}" />
                                    <button type="submit" name="action" value="Edit">Edit</button>
                                </form>
                            </td>
                            <td><fmt:formatNumber value="${clothes.price}" type="currency" currencySymbol="$" /></td>
                            <td>
                                <a href="MainController?action=Remove&Id=${clothes.id}&quantity=${clothes.quantity}">Remove</a>
                            </td>
                            <td><fmt:formatNumber value="${itemTotal}" type="currency" currencySymbol="$" /></td>
                        </tr>
                        <c:set var="count" value="${count + 1}" />
                    </c:forEach>
                </tbody>
            </table>

            <h1>Total: <fmt:formatNumber value="${total}" type="currency" currencySymbol="$" /></h1>
        </c:if>


        <form action="MainController" method="POST"style="justify-content: center">

            <button type="submit" name="action" value="Purchase" style="font-size: 34px" > <i class="fa fa-shopping-cart"></i></button>
        </form>



        <div style="text-align: center; margin-top: 20px;">

            <a href="MainController?action=Shopping_Page">Add more!</a>


        </div>
    </body>
</html>