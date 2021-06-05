<%-- 
    Document   : home
    Created on : May 13, 2021, 12:27:33 AM
    Author     : hoang
--%>

<%@page import="model.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Home</title>
    </head>
    <body>

        <div class="container">
            <div class="nav">
                <ul>
                    <li><a href="home">Home</a></li>
                    <li><a href="takequiz">Take Quiz</a></li> 
                    <li><a href="makequiz">Make Quiz</a></li>
                    <li><a href="managequiz">Manage Quiz</a></li>

                </ul>
            </div>
            <div class="main-content">
                <div class="header">
                    <h2>Login Form</h2>
                </div>
                <div class="sub-content">
                    <form action="home" method="POST">
                        <table border="0">
                            <tr>
                                <td>User Name:</td>
                                <td>
                                    <input type="text" name="userName" onkeypress="changeBgInput(this)">
                                    <c:if test="${emptyUserName!=null}">
                                        <span class="red-mark">UserName can not be empty!</span>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td>
                                    <input type="password" name="password" onkeypress="changeBgInput(this)">
                                    <c:if test="${emptyPassword!=null}">
                                        <span class="red-mark">Password can not be empty!</span>
                                    </c:if>
                                </td>
                            </tr>
                            <c:if test="${errorLoginFaile!=null}">
                                <tr>
                                    <td></td>
                                    <td><span class="red-mark">UserName or Password not correct!</span></td>
                                </tr>
                            </c:if>
                            <tr>
                                <td></td>
                                <td><input type="submit" name="submitButton" value="Sign in"> <input type="submit" name="submitButton" value="Register" ></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
    </body>
    <script type="text/javascript">
        function changeBgInput(x) {
            if (x.value === '') {
                x.style.background = 'white';
            } else {
                x.style.background = "rgb(250, 255, 189)";
            }
        }
    </script>
</html>
