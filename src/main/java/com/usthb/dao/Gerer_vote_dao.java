package com.usthb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.usthb.util.DBConnection;

public class Gerer_vote_dao {
	Connection con = null;
	Statement statement = null;
	ResultSet resultSet = null; 

	public boolean inserer_vote_user(String id,String type_vote,ArrayList<String> liste_votes,ArrayList<String> liste_codes) {

		boolean valid=false;
			 String liste_vote="";
			 String liste_code="";
			 for (int i=0;i<liste_votes.size();i++) {
				 if(i==liste_votes.size()-1) {
					 liste_vote=liste_vote+liste_votes.get(i);
					 liste_code=liste_code+liste_codes.get(i);
				 }
				 else {
				 liste_vote=liste_vote+liste_votes.get(i)+",";
				 liste_code=liste_code+liste_codes.get(i)+",";
			 }
			 }
			 System.out.println(liste_vote);
			 System.out.println(liste_code);
			 //verifier dans la base de donnée de users_carte_id
			 String query1 = "insert into evote_dbs.users_vote(user_id,type_election,vote,code) values (?,?,?,?)"; 

	try{con = DBConnection.createConnection();
		    
			     con.close();
			     } catch (SQLException e) {
			  e.printStackTrace();
			     }

	return valid;
	}

}