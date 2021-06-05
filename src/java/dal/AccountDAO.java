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
import model.Account;

/**
 *
 * @author hoang
 */
public class AccountDAO {
    private DBContext db;
    private PreparedStatement stt;
    private ResultSet rs;
    private Connection connection;
    
    public AccountDAO(){
        db = new DBContext();
        connection = db.connection;
    }
    
    public boolean signIn(Account acc){
        String query = "SELECT * FROM Accounts WHERE userName = ? AND passwords = ?";
        boolean signInSuccess = false;
        try {
            stt = connection.prepareStatement(query);
            stt.setString(1, acc.getUserName());
            stt.setString(2,acc.getPassword());
            rs = stt.executeQuery();
            if(rs.next()){
                signInSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return signInSuccess;
    }
    
    public boolean register(Account acc){
        String query = "INSERT INTO Accounts VALUES(?,?,?,?)";
        try {
            stt = connection.prepareStatement(query);
            stt.setString(1, acc.getUserName());
            stt.setString(2, acc.getPassword());
            stt.setBoolean(3, acc.isIsTeacher());
            stt.setString(4, acc.getEmail());
            stt.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
    
    public boolean checkIsTeacher(Account acc){
        String query = "SELECT * FROM Accounts WHERE userName = ? and isTeacher = ?";
        boolean isTeacher = false;
        try {
            stt = connection.prepareStatement(query);
            stt.setString(1, acc.getUserName());
            stt.setBoolean(2, true);
            rs = stt.executeQuery();
            if(rs.next()){
                isTeacher = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isTeacher;
    }
}
