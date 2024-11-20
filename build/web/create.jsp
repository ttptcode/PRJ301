
<%@page import="sample.users.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create User</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                padding: 20px;
            }
            
            .container {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                margin: 0 auto;
            }
            
            h1 {
                text-align: center;
                color: #4CAF50;
            }
            
            input[type=text], input[type=password] {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            
            input[type=submit], input[type=reset] {
                background-color: #4CAF50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            
            input[type=submit]:hover, input[type=reset]:hover {
                background-color: #45a049;
            }
            
            .error {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create User</h1>
            <form action="MainController" method="POST">
                User ID <input type="text" name="userID" required="">${requestScope.USER_ERROR.userIDError}
                </br> Full Name <input type="text" name="fullname" required="">${requestScope.USER_ERROR.fullNameError}
                </br> Role ID <input type="text" name="roleID" value="US" readonly="">
                </br> Password <input type="password" name="password" required="">
                </br> Confirm <input type="password" name="confirm" required="">${requestScope.USER_ERROR.confirmError}
                </br> <input type="submit" name="action" value="Create">
                </br> <input type="reset" value="Reset">
            </form>
            <p class="error">${requestScope.USER_ERROR.error}</p>
        </div>
    </body>
</html>