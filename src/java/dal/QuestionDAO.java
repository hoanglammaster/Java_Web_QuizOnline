/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Answer;
import model.Question;

/**
 *
 * @author hoang
 */
public class QuestionDAO {

    private DBContext db;
    private PreparedStatement stt;
    private ResultSet rs;
    private Connection connection;

    public QuestionDAO() {
        this.db = new DBContext();
        connection = db.connection;
    }

    public int getNumOfQues() {
        String query = "SELECT COUNT(quesID) AS numOfQues FROM Questions";
        
        try {
            stt = connection.prepareStatement(query);
            rs = stt.executeQuery();
            if (rs.next()) {
                return rs.getInt("numOfQues");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Question> getQuesFromDB(int numOfQues) {
        ArrayList<Question> listQuestions = new ArrayList<>();
        String query = "SELECT TOP(?) * FROM Questions ORDER BY NEWID()";
        try {
            stt = connection.prepareStatement(query);
            stt.setInt(1, numOfQues);
            rs = stt.executeQuery();
            while (rs.next()) {
                listQuestions.add(new Question(rs.getString("quesContent"), getlistAnswers(rs.getInt("quesID"))));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listQuestions;
    }

    private Answer getlistAnswers(int ansID) {
        Answer answer = null;
        String query = "SELECT * FROM Answers WHERE ansID = ?";
        try {
            stt = connection.prepareStatement(query);
            stt.setInt(1, ansID);
            ResultSet rs2 = stt.executeQuery();
            while (rs2.next()) {
                String[] listAnswer = {rs2.getString("ansContent1"), rs2.getString("ansContent2"), rs2.getString("ansContent3"), rs2.getString("ansContent4")};
                answer = new Answer(listAnswer, rs2.getInt("trueAnswer"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answer;
    }
    
    public boolean addQuestion(Question ques){
        String query = "EXEC AddQuestion ?,?,?,?,?,?";
        Answer answer = ques.getAnswer();
        String[] listAnswer = answer.getListAnswer();
        try {
            stt = connection.prepareStatement(query);
            stt.setString(1, ques.getQuesContent());
            stt.setString(2, listAnswer[0]);
            stt.setString(3, listAnswer[1]);
            stt.setString(4, listAnswer[2]);
            stt.setString(5, listAnswer[3]);
            stt.setInt(6, answer.getTrueAnswerInt());
            stt.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
    
    public Answer getAnswerByQuestion(String quesContent){
        String query = "SELECT * FROM Answers WHERE ansID = (SELECT quesID FROM Questions WHERE quesContent = ?)";
        Answer answer = null;
        try {
            stt = connection.prepareStatement(query);
            stt.setString(1, quesContent);
            rs = stt.executeQuery();
            if(rs.next()){
                String[] listAnswer = {rs.getString("ansContent1"),rs.getString("ansContent2"),rs.getString("ansContent3"),rs.getString("ansContent4")};
                answer = new Answer(listAnswer, rs.getInt("trueAnswer"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answer;
    }

    public ArrayList<Question> getAllQues(){
        String query = "SELECT * FROM Questions";
        ArrayList<Question> listQues = new ArrayList<>();
        try {
            stt = connection.prepareStatement(query);
            rs = stt.executeQuery();
            while(rs.next()){
                listQues.add(new Question(rs.getString("quesContent"), rs.getDate("createdDate")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listQues;
    }
    
}
