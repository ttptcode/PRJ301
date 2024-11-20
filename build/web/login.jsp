<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
        <div class="background">
            <div class="shape"></div>
            <div class="shape"></div>
        </div>
        <div id="container">
            <h1>Login Information</h1>
            <div>
                <form action="MainController" method="POSTs
                    User ID<input type="text" name="userID"/></br>
                    Password<input type="password" name="password"/></br>
                    <div class="g-recaptcha" data-sitekey="6LcrWwwqAAAAAK8feAuh03aCKVVhAlp9QtQfbYWz" style="justify-content: center; margin-left: 50px" ></div>
                    <input type="submit" name="action" value="Login"/>
                    <input type="reset" name="Reset" value="Reset"/>
                </form>
            </div>
            <a href="MainController?action=Create_Page">create account</a>

        </div>

        </br>

        <div class="error">${requestScope.ERROR}</div>

    </body>
</html>