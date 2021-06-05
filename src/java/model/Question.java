/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dal.QuestionDAO;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author hoang
 */
public class Question {
    private String quesContent;
    private Answer answer;
    private Date dateCreated;

    public Question(String quesContent, Answer answer) {
        this.quesContent = quesContent;
        this.answer = answer;
        this.dateCreated = Date.valueOf(LocalDate.now());
    }
    
    public Question(String quesContent, Date dateCreated) {
        this.quesContent = quesContent;
        this.answer = null;
        this.dateCreated = dateCreated;
    }
    
    public Question(String quesContent, Answer answer, Date dateCreated) {
        this.quesContent = quesContent;
        this.answer = answer;
        this.dateCreated = dateCreated;
    }
    
    public String getQuesContent() {
        return quesContent;
    }

    public void setQuesContent(String quesContent) {
        this.quesContent = quesContent;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }
    
    public String getTrueAnswer(){
        return answer.getTrueAnswer();
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
    public String getDateToString(){
        SimpleDateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
        return format.format(dateCreated);
    }
    
}
