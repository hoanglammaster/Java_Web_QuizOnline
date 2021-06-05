/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.AccountDAO;
import dal.QuestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Answer;
import model.Question;

/**
 *
 * @author hoang
 */
@WebServlet(name = "TakeQuiz", urlPatterns = {"/takequiz"})
public class TakeQuiz extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TakeQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TakeQuiz at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        Object obj = request.getSession().getAttribute("account");
        if(obj==null){
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }else{
            Account account = (Account) obj;
            AccountDAO accDAO = new AccountDAO();
            account.setIsTeacher(accDAO.checkIsTeacher(account));
            request.setAttribute("account", account);
            request.getRequestDispatcher("takequiz.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuestionDAO quesDAO = new QuestionDAO();
        HttpSession session = request.getSession();

        String numOfQuesStr = request.getParameter("quesNumber");
        RequestDispatcher dis = request.getRequestDispatcher("takequiz.jsp");
        int numOfQuesInput;
        ArrayList<Question> listQues = null;
        String status = request.getParameter("status");
        if (status == null) {
            try {
                int numOfQues = quesDAO.getNumOfQues();
                numOfQuesInput = Integer.parseInt(numOfQuesStr);
                if (numOfQuesInput > numOfQues) {
                    request.setAttribute("errorNumOfQues", true);
                    request.setAttribute("numOfQues", numOfQues);
                    dis.forward(request, response);
                } else {
                    listQues = quesDAO.getQuesFromDB(numOfQuesInput);
                    request.setAttribute("listQues", listQues);
                    request.setAttribute("timeRemain", numOfQuesInput);
                    dis.forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorNumOfQues", true);
                dis.forward(request, response);
            }
        } else {
            int score = 0;
            int numOfQues = Integer.parseInt(request.getParameter("numOfQuestion"));
            for(int i = 1; i <= numOfQues; i ++){
                Answer answer = quesDAO.getAnswerByQuestion(request.getParameter("ques"+i));
                if(answer.getTrueAnswer().equals(request.getParameter("answer"+i))){
                    score++;
                }
            }
            BigDecimal bdScore = new BigDecimal(score);
            
            BigDecimal bdQues = new BigDecimal(numOfQues);
           
            BigDecimal result = bdScore.divide(bdQues,2,RoundingMode.HALF_UP);
            result = result.multiply(new BigDecimal(10));
            request.setAttribute("score", Double.parseDouble(result.toString()));
            request.getRequestDispatcher("takequiz.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
