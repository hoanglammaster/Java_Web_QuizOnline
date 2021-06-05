<%-- 
    Document   : makequiz
    Created on : May 14, 2021, 5:57:20 AM
    Author     : hoang
--%>

<%@page import="dal.AccountDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Make Quiz</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <div class="container">
            <div class="nav">
                <ul>
                    <li><a href="home">Home</a></li>
                    <li><a href="takequiz">Take Quiz</a></li> 
                        <c:if test="${account.isIsTeacher()==true}">
                        <li><a href="makequiz">Make Quiz</a></li>
                        <li><a href="managequiz">Manage Quiz</a></li>
                        </c:if>
                        <c:if test="${account != null}">
                        <li><a href="home?logout=true">Log out</a></li>
                        </c:if>
                </ul>
            </div>
            <div class="main-content">
                <div class="header">
                    Welcome <span id="fullName">${account.getUserName()}</span>
                    <c:if test="${isSucess!=null}">
                        <p class="blue-mark">Save success full!</p>
                    </c:if>
                </div>
                <div class="sub-content">
                    <form action="makequiz" method="POST">
                        <table border="0">
                            <tbody>
                                <tr>
                                    <td class="td-content">Question:
                                        <c:if test="${emptyQues != null}">
                                            <span class="red-mark">Question can not be empty!</span>
                                        </c:if>
                                        <c:if test="${quesDupli != null}">
                                            <span class="red-mark">Question already exist! </span>
                                        </c:if>
                                    </td>
                                    <td><textarea id="ques-textarea" name="question"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="td-content">Option 1:
                                        <c:if test="${emptyOp1 != null}">
                                            <span class="red-mark">Option 1 can not be empty!</span>
                                        </c:if>
                                    </td>
                                    <td><textarea class="option-textarea" name="option1"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="td-content">Option 2:
                                        <c:if test="${emptyOp2 != null}">
                                            <span class="red-mark">Option 2 can not be empty!</span>
                                        </c:if>
                                    </td>
                                    <td><textarea class="option-textarea" name="option2"></textarea></td>
                                </tr><tr>
                                    <td class="td-content">Option 3:
                                        <c:if test="${emptyOp3 != null}">
                                            <span class="red-mark">Option 3 can not be empty!</span>
                                        </c:if>
                                    </td>
                                    <td><textarea class="option-textarea" name="option3"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="td-content">Option 4:
                                        <c:if test="${emptyOp4 != null}">
                                            <span class="red-mark">Option 4 can not be empty!</span>
                                        </c:if>
                                    </td>
                                    <td><textarea class="option-textarea" name="option4"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="td-content">Answer(s):
                                        <c:if test="${emptyAns != null}">
                                            <span class="red-mark">Please choose true answer!</span>
                                        </c:if>
                                    </td>

                                    <td>
                                        <input type="checkbox" name="answer" onclick="onlyOne(this)" value="0">Option 1
                                        <input type="checkbox" name="answer" onclick="onlyOne(this)" value="1">Option 2
                                        <input type="checkbox" name="answer" onclick="onlyOne(this)" value="2">Option 3
                                        <input type="checkbox" name="answer" onclick="onlyOne(this)" value="3">Option 4
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td-content"></td>
                                    <td> <input type="submit" value="Save" id="save-button"></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        function onlyOne(checkbox) {
            var checkboxes = document.getElementsByName(checkbox.name);
            checkboxes.forEach((item) => {
                if (item !== checkbox)
                    item.checked = false;
            })
        }
    </script>

</html>
