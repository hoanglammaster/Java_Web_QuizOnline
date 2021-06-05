<%-- 
    Document   : takequiz
    Created on : May 13, 2021, 10:35:05 AM
    Author     : hoang
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Question"%>
<%@page import="dal.AccountDAO"%>
<%@page import="model.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Take Quiz</title>
        <link rel="stylesheet" href="css/style.css">

    </head>
    <body onload="countDown()"> 

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

                    <c:choose>
                        <c:when test="${score == null}">
                            Welcome <span id="fullName">${account.getUserName()}</span>
                            <c:if test="${timeRemain != null}">
                                <p id="time-remaining">Time remaining: <span class="red-mark" id="display-time"></span></p>
                                <input type="hidden" id="time-remain" value="${timeRemain}">
                            </c:if>
                        </c:when>
                        <c:otherwise>

                            <c:choose>
                                <c:when test="${score >= 5}">
                                    Your score <span class="blue-mark">${score}(${score * 10}%) - Passed </span>
                                </c:when>
                                <c:otherwise>
                                    Your score <span class="red-mark">${score}(${score * 10}%) - Passed </span>
                                </c:otherwise>
                            </c:choose>

                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="sub-content">
                    <c:choose>
                        <c:when test="${score == null}">
                            <form id="formId" action="takequiz" method="POST">
                                <c:choose>
                                    <c:when test="${timeRemain == null}">
                                        <div class="form-ques-number">
                                            Enter number of questions:
                                            <br>
                                            <input id="input-time" type="text" name="quesNumber">
                                            <c:if test="${errorNumOfQues!=null}">
                                                <c:choose>
                                                    <c:when test="${numOfQues!=null}">
                                                        <span class="error-num-of-ques">Max number of question is ${numOfQues}!</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="error-num-of-ques">Number of question must be Integer!</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <br>
                                            <input id="button-start" type="submit" value="Start">
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="form-content-ques">

                                            <c:set value="0" var="index"/>
                                            <c:forEach items="${listQues}" var="ques">
                                                <div style="display: none" id="${index=index+1}">
                                                    <p>${ques.quesContent}</p>
                                                    <input type="hidden" name="ques${index}" value="${ques.quesContent}"/>
                                                    <c:forEach items="${ques.answer.listAnswer}" var="ans">
                                                        <input type="checkbox" name="answer${index}" onclick="onlyOne(this)" value="${ans}">${ans} <br>
                                                    </c:forEach>
                                                </div>
                                            </c:forEach>
                                            <input type="hidden" id="status" name="status"/>
                                            <input type="hidden" name="numOfQuestion" value="${timeRemain}">
                                            <input class="button" type="button" onclick="change()" value="Next"/>
                                        </div>

                                    </c:otherwise>
                                </c:choose>

                            </c:when>
                            <c:otherwise>
                                Take another test <input type="button" value="Start" onclick="moreQuiz()"/>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>

            </div>
        </div>

    </body>
    <script type="text/javascript">
        function onlyOne(checkbox) {
            var checkboxes = document.getElementsByName(checkbox.name)
            checkboxes.forEach((item) => {
                if (item !== checkbox)
                    item.checked = false
            })
        }

        async function countDown() {
            change();
            var timeRemain = document.getElementById("time-remain").value;
            if (timeRemain !== '0') {
                var minutes = timeRemain;
                var seconds = 0;
                do {
                    if (seconds < 0) {
                        if (minutes > 0) {
                            seconds = 59;
                            minutes--;
                        } else {
                            break;
                        }
                    }
                    if (seconds < 10) {
                        seconds = "0" + seconds;
                    }
                    document.getElementById("display-time").innerHTML = minutes + ":" + seconds;
                    seconds--;
                    await sleep(1000);
                } while (minutes >= 0);
                document.getElementById("status").value = "finish";
                document.getElementById("formId").submit();
            }
        }
        function sleep(ms) {
            return new Promise(resolve => setTimeout(resolve, ms));
        }

        var index = 1;
        var size = document.getElementById("time-remain").value;
        var i;
        function change() {
            if (index > size) {
                document.getElementById("status").value = "finish";
                document.getElementById("formId").submit();
            }
            for (i = 1; i < parseInt(size) + 1; i++) {

                if (i !== index) {
                    document.getElementById(i.toString()).style.display = "none";
                } else {
                    document.getElementById(i.toString()).style.display = "block";
                }
            }
            index = index + 1;
        }

        function moreQuiz() {
            window.location.href = "takequiz.jsp";
        }

    </script>
</html>
