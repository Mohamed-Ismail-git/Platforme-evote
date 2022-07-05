package com.usthb.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.usthb.bean.Carte_id;
import com.usthb.dao.check_PIN_validite_dao;
import com.usthb.dao.check_id_existance_dao;


/**
 * Servlet implementation class Verifier_existancce_carte_id_Servlet
 */
@WebServlet("/Verifier_existancce_carte_id_Servlet")
public class Gerer_authentification_carte_id_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public Gerer_authentification_carte_id_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession() !=null) {  /*s'assurer que la session est existance , cequi veut dire que la première étape de vérification a vraiment était validé*/

		int status;
		String id =request.getParameter("input").toString(); /*on a envoyé l'id avec le paramètre input , ici on le récupère*/
        String type_vote= request.getParameter("type_vote").toString();
        request.getSession().setAttribute("id_user", id);
        request.getSession().setAttribute("type_vote", type_vote);
    	String PIN=request.getParameter("pin");
        check_id_existance_dao check=new check_id_existance_dao();  /*vérifier l'existance de l'id dans la bdd*/
		boolean result=check.verifier_validité_id(id);
		System.out.println(result);
		System.out.println(request.getSession().getId().toString());
		if(result==true) { /*ici l'id de la carte existe*/
			/*on vérifie s'il a le droit de voter, si oui, l'a t'il déja fait ou pas
			 * la réponse se fera comme suit:
			 * 1= déjà voté
			 * 0= peut voter
			 *-1= pas les droits de vote
			  */
			
			status=check.verifier_pouvoir_vote_id(id,type_vote);
if(status==0) {
	/*chiffrer le PIN et le comparé a son correspondant dans la base de données*/
	String cipher_pin= Carte_id.encrypt(PIN.subSequence(1, PIN.length()-1).toString());
	check_PIN_validite_dao pin_validate=new check_PIN_validite_dao();
	boolean valid=pin_validate.verifier_validité_PIN(id, cipher_pin);
	if(valid == true) {
		status=0;
		/*String ID="52476757457645";
	    String VOTE="Berbar";
	    Send_vote_secure_server secure=new Send_vote_secure_server();
	    secure.SendInformations(ID, VOTE);*/
	}
	else {
		status=-1;
		request.getSession().invalidate();  /*terminer la session*/
	}
}
else {
	status=-2;
}
			request.getSession().setAttribute("state", "true");
			//request.setAttribute("state", "true");
			 
			}
		else { /*ici l'id de la carte n'existe pas du tout*/
			status=-2;
			request.getSession().invalidate();  /*kill the session*/
		}
		//HttpSession session = request.getSession();
		String json = new Gson().toJson(status);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);

			/*if(status==0) { on envoit une réponse à la page pour débloquer la suite de la procédure*/
				
			/*}
			else {
				/*on envoit une réponse à la page jsp pour prévenir l'utilisateur de son cas*/
			/*}*/
	}
		else {
			 /*session inexistante donc première étape a été suspendu*/
				response.sendRedirect(request.getContextPath() + "/Page_erreur.jsp");
			}
		
	}
}
