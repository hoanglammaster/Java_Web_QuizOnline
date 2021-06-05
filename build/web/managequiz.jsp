<%-- 
    Document   : managequiz
    Created on : May 14, 2021, 7:42:08 AM
    Author     : hoang
--%>

<%@page import="dal.AccountDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Answer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Question"%>
<%@page import="model.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">

        <title>Manage Quiz</title>
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
                    Number of questions: <span class="blue-mark"> ${listQues.size()}</span>
                </div>
                <div class="sub-content">
                    <form method="POST">
                        <table class="spacing-column">
                            <tr class="head-row">
                                <td class="td-content blue-mark" style="width: 700px;">Question</td>
                                <td class="td-content blue-mark ">DateCreated</td>
                                
                            </tr>
                            <c:forEach items="${listQues}" var="ques">
                                <tr>
                                    <td>${ques.getQuesContent()}</td>
                                    <td>${ques.getDateToString()}</td>
                                </tr>
                            </c:forEach>
                            
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
