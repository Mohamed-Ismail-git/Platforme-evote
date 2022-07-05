package com.usthb.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.usthb.util.DBConnection;

public class check_id_existance_dao {
	Connection con = null;
	Statement statement = null;
	ResultSet resultSet = null;  
	/*fonction qui vérifie l'existance de l'id de la carte d'identité*/
	public boolean verifier_validité_id(String Id){
		 boolean valid=false;
//verifier dans la base de donnée de users_carte_id
String query="SELECT id_carte FROM evote_dbs.users_carte_id where id_carte=?";
try{con = DBConnection.createConnection();
PreparedStatement statement = con.prepareStatement(query);
statement.setString(1, Id.subSequence(1, Id.length()-1).toString());
ResultSet resultSet=statement.executeQuery();
while(resultSet.next()){
		    	if(resultSet.getString("id_carte").trim().equals(Id.subSequence(1, Id.length()-1).toString())){
		    		valid=true;
		    	}
		    	}			    
		     con.close();
		     } catch (SQLException e) {
		  e.printStackTrace();
		     }

return valid;
}
	/*fonction qui permet de savoir si un individu correspondant à un id de carte d'identité peut voter*/
	public int verifier_pouvoir_vote_id(String Id,String Type_vote){
		/*la réponse se fera comme suit:
		 * 1= déjà voté
		 * 0= peut voter
		 *-1= pas les droits de vote
		  */
		 int valid=99;
//verifier dans la base de donnée de users_carte_id
String query="SELECT ability FROM evote_dbs.users_carte_id where id_carte=?";
try{con = DBConnection.createConnection();
PreparedStatement statement = con.prepareStatement(query);
statement.setString(1, Id.subSequence(1, Id.length()-1).toString());
ResultSet resultSet=statement.executeQuery();
while(resultSet.next()){
		    	if(resultSet.getString("ability").trim().toString().equals("0")){
		    		valid=-1;
		    	}
		    	}	
if(valid !=-1) { /*ici on est sûr qu'il a les droits de vote donc on vérifie s'il a déjà voté ou pas*/
	 query="SELECT type_election FROM evote_dbs.users_vote where user_id=?";
	 statement = con.prepareStatement(query);
	 statement.setString(1, Id.subSequence(1, Id.length()-1).toString());
	 resultSet=statement.executeQuery();
	 valid=0;/* on suppose qu'il n'a pas encore voté donc peut voté*/  //dans le cas oû labdd est vide
	 while(resultSet.next()){
	    	try {
	    		if(resultSet.getString("type_election").trim().toString().equals(Type_vote)) { /*il a voté déjà pr cette election*/
	    		valid=1; /*déja voté*/
	    		}
	    	
	    	}
	    	catch (Exception e) {
				e.printStackTrace();
			}
	    	}
}
		     con.close();
		     } catch (SQLException e) {
		  e.printStackTrace();
		     }

return valid;
}
	
	/*fonction qui vérifie la correspendance entre id et password de l'admin*/
	public boolean verifier_correspondance_admin(String Id,String password){
		 boolean valid=false;
//verifier dans la base de donnée de users_carte_id
String query="SELECT user_id,user_pin FROM evote_dbs.users_pin where user_id=?";
try{con = DBConnection.createConnection();
PreparedStatement statement = con.prepareStatement(query);
statement.setString(1, Id.subSequence(1, Id.length()-1).toString()+"*");
ResultSet resultSet=statement.executeQuery();
while(resultSet.next()){ 
		    	if(resultSet.getString("user_id").trim().equals(Id.subSequence(1, Id.length()-1).toString()+"*") && resultSet.getString("user_pin").trim().equals(password)){
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

