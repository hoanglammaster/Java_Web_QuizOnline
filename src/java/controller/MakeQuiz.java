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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Answer;
import model.Question;

/**
 *
 * @author hoang
 */
@WebServlet(name = "MakeQuiz", urlPatterns = {"/makequiz"})
public class MakeQuiz extends HttpServlet {

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
            out.println("<title>Servlet MakeQuiz</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MakeQuiz at " + request.getContextPath() + "</h1>");
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
        if (obj == null) {
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            Account account = (Account) obj;
            AccountDAO accDAO = new AccountDAO();
            account.setIsTeacher(accDAO.checkIsTeacher(account));
            request.setAttribute("account", account);
            request.getRequestDispatcher("makequiz.jsp").forward(request, response);
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
//        processRequest(request, response);
        QuestionDAO quesDAO = new QuestionDAO();
        String quesContent = request.getParameter("question");
        String ansOp1 = request.getParameter("option1");
        String ansOp2 = request.getParameter("option2");
        String ansOp3 = request.getParameter("option3");
        String ansOp4 = request.getParameter("option4");
        String trueAns = request.getParameter("answer");

        if (quesContent.isEmpty() || ansOp1.isEmpty() || ansOp2.isEmpty() || ansOp3.isEmpty() || ansOp4.isEmpty() || trueAns.isEmpty()) {
            if (quesContent.isEmpty()) {
                request.setAttribute("emptyQues", true);
            }
            if (ansOp1.isEmpty()) {
                request.setAttribute("emptyOp1", true);
            }
            if (ansOp2.isEmpty()) {
                request.setAttribute("emptyOp2", true);
            }
            if (ansOp3.isEmpty()) {
                request.setAttribute("emptyOp3", true);
            }
            if (ansOp4.isEmpty()) {
                request.setAttribute("emptyOp4", true);
            }
            if (trueAns == null) {
                request.setAttribute("emptyAns", true);
            }
            request.getRequestDispatcher("makequiz.jsp").forward(request, response);
        } else {
            String listAns[] = {ansOp1, ansOp2, ansOp3, ansOp4};
            Answer ans = new Answer(listAns, Integer.parseInt(trueAns));
            Question question = new Question(quesContent, ans);
            if (quesDAO.addQuestion(question)) {
                request.setAttribute("isSucess", true);
                request.getRequestDispatcher("makequiz.jsp").forward(request, response);
            } else {
                request.setAttribute("quesDupli", true);
                request.getRequestDispatcher("makequiz.jsp").forward(request, response);
            }
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
