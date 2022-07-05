package com.usthb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.usthb.util.DBConnection;

public class check_pin_personnel_existance_dao {
	Connection con = null;
	Statement statement = null;
	ResultSet resultSet = null; 
	public boolean verifier_existance_pin(String pin){
		
		 boolean valid=false;
//verifier dans la base de donnée de users_carte_id
String query="SELECT user_pin FROM evote_dbs.users_pin where user_pin=?";
try{con = DBConnection.createConnection();
PreparedStatement statement = con.prepareStatement(query);
statement.setString(1, pin);
ResultSet resultSet=statement.executeQuery();
while(resultSet.next()){
		    	if(resultSet.getString("user_pin").trim().equals(pin)){
		    		valid=true;
		    	}
		    	}			    
		     con.close();
		     } catch (SQLException e) {
		  e.printStackTrace();
		     }

return valid;
}
}
