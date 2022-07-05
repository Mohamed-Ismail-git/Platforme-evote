package com.usthb.util;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.log4j.Logger;


public class DBConnection {
	//static final Logger LOGGER = Logger.getLogger(DBConnection.class);

 public static Connection createConnection()
 {
	 Connection con = null;
	 String url = "jdbc:mysql://localhost:3306/evote_dbs?serverTimezone=GMT&characterEncoding=utf-8&useSSL=false"; //MySQL URL followed by the database name
	 String username = "root"; //MySQL username
	 String password = "password"; //MySQL password
	 
	 try 
	 {
		 try 
		 {
			Class.forName("com.mysql.cj.jdbc.Driver"); //loading MySQL drivers. This differs for database servers 
		 } 
		 catch (ClassNotFoundException e)
		 {
			e.printStackTrace();
		 }
		 
		 con = DriverManager.getConnection(url, username, password); //attempting to connect to MySQL database

	 } 
	 catch (Exception e) 
	 {
		e.printStackTrace();
	 }
	 
	 return con; 
 }
}