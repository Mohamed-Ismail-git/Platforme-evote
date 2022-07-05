package com.usthb.controller;

import java.io.IOException;
import java.security.KeyPair;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.usthb.util.Encryption_Signature;
import com.usthb.util.Get_Valeurs_Properties;

/**
 * Servlet implementation class Generer_cryptage_Servlet
 */
public class Generer_cryptage_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Generer_cryptage_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("rrez");
		String cle_publique="";
		 HashMap<String, String> file_config=new HashMap<String,String>();
			Get_Valeurs_Properties config=new Get_Valeurs_Properties();
			file_config=config.getPropValues();
			for (Map.Entry<String,String> e : file_config.entrySet()){
			  //  request.getSession().setAttribute(e.getKey(), e.getValue()); /*sauvegarder les informations du fichier de parametre dans la session*/
			cle_publique=e.getValue();
			}

		  String json_string = new Gson().toJson(cle_publique);
			
			  response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(json_string);
	}

}
