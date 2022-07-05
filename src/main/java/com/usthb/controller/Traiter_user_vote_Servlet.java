package com.usthb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.usthb.dao.Gerer_vote_dao;
import com.usthb.util.Generate_random_numbers;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Traiter_user_vote_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Traiter_user_vote_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id =request.getSession().getAttribute("id_user").toString();
		String type_vote= request.getSession().getAttribute("type_vote").toString();
		Generate_random_numbers generate=new Generate_random_numbers();
		String liste =request.getParameter("liste"); /*récupère la liste ayant été transmise avec ajax*/
			ArrayList<String> liste_votant=new ArrayList<String>();
			ArrayList<String> liste_code=new ArrayList<String>();
		liste=liste.substring(1, liste.length()-1);
		System.out.println(liste);
	List<String> matchList = new ArrayList<String>();
	Pattern regex = Pattern.compile("[^\\s\"']+|\"([^\"]*)\"|'([^']*)'");
	Matcher regexMatcher = regex.matcher(liste);
	while (regexMatcher.find()) {
	    if (regexMatcher.group(1) != null) {
	        // Add double-quoted string without the quotes
	        matchList.add(regexMatcher.group(1));
	    } else if (regexMatcher.group(2) != null) {
	        // Add single-quoted string without the quotes
	        matchList.add(regexMatcher.group(2));
	    } else {
	        // Add unquoted word
	        matchList.add(regexMatcher.group());
	    }
	} 
	System.out.println("Génération des votes/codes..");
	/*construire les listes finales*/
for(int i=0;i<matchList.size();i++) {
		if(matchList.get(i).length()>1) {
			String result[]=matchList.get(i).split("-");

			liste_votant.add(result[0]);
			//String S=generate.generate_number();
			liste_code.add(result[1]);

			System.out.println(result[0] +" / "+result[1]);
		}
	}
	//on envoit le vote
	Gerer_vote_dao gerer=new Gerer_vote_dao();
	boolean valid=gerer.inserer_vote_user(id, type_vote, liste_votant, liste_code);
	}

}
