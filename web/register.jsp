<%-- 
    Document   : register
    Created on : May 14, 2021, 5:06:52 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Register</title>
    </head>
    <body>
        <div class="container">
            <div class="nav">
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="takequiz.jsp">Take Quiz</a></li> 
                    <li><a href="makequiz.jsp">Make Quiz</a></li>
                    <li><a href="managequiz">Manage Quiz</a></li>
                </ul>
            </div>
            <div class="main-content">
                <div class="header">
                    <h2>Registration Form</h2>
                </div>
                <div class="sub-content">
                    <form action="register" method="POST">
                        <table border="0"id="outside-tb">
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
                            <tr>
                                <td>User Type</td>
                                <td><select name="userType">
                                        <option value="teacher">Teacher</option>
                                        <option value="student">Student</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td>
                                    <input type="text" name="email" onkeypress="changeBgInput(this)" >
                                    <c:if test="${emptyEmail != null}">
                                        <span class="red-mark">Email can not be empty!</span>
                                    </c:if>
                                    <c:if test="${errorEmail != null}">
                                        <span class="red-mark">Email must contain @!</span>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Register"></td>
                            </tr>
                        </table>
                        <c:if test="${regisFaile!=null}">
                            <span class="red-mark">Account already exist!</span>
                        </c:if>
                        <c:if test="${regisSuccess!=null}">
                            <span class="blue-mark">Register successfully</span>
                        </c:if>
                    </form>
                </div>
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
