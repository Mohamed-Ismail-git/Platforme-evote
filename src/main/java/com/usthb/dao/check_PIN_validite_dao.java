package com.usthb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.usthb.util.DBConnection;

public class check_PIN_validite_dao {
	Connection con = null;
	Statement statement = null;
	ResultSet resultSet = null; 
	public boolean verifier_validité_PIN(String Id,String cipher_pin){
		
		 boolean valid=false;
//verifier dans la base de donnée de users_carte_id
String query="SELECT user_pin FROM evote_dbs.users_pin where user_id=?";
try{con = DBConnection.createConnection();
PreparedStatement statement = con.prepareStatement(query);
System.err.println(Id);
statement.setString(1, Id.subSequence(1, Id.length()-1).toString());
ResultSet resultSet=statement.executeQuery();
while(resultSet.next()){
		    	if(resultSet.getString("user_pin").trim().equals(cipher_pin.trim())){
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
