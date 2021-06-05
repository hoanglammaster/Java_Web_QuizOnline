/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author hoang
 */
public class Answer {
    private String[] listAnswer;
    private int trueAnswer;

    public Answer(String[] listAnswer, int trueAnswer) {
        this.listAnswer = listAnswer;
        this.trueAnswer = trueAnswer;
    }

    public void setListAnswer(String[] listAnswer) {
        this.listAnswer = listAnswer;
    }

    public void setTrueAnswer(int trueAnswer) {
        this.trueAnswer = trueAnswer;
    }

    public String[] getListAnswer() {
        return listAnswer;
    }

    public String getTrueAnswer() {
        return listAnswer[trueAnswer];
    }
    public int getTrueAnswerInt() {
        return trueAnswer;
    }
}
