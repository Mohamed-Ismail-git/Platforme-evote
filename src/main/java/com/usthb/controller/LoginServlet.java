package com.usthb.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.usthb.bean.Carte_id;
import com.usthb.dao.check_id_existance_dao;
import com.usthb.dao.check_pin_personnel_existance_dao;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code_id = "\""+request.getParameter("code_id_Login")+"\"";
		String Password_Login = request.getParameter("Password_Login");
		check_pin_personnel_existance_dao pin=new check_pin_personnel_existance_dao();
		/*vérifier existance code_id*/
		check_id_existance_dao exist=new check_id_existance_dao();
		boolean valid=exist.verifier_validité_id(code_id);
		if(valid==true) {
	     /* si oui vérifier correspendance id et pin de l'admin*/
		valid=exist.verifier_correspondance_admin(code_id, Carte_id.encrypt(Password_Login));
		if(valid==true) {
			/*entrée*/
			request.getSession().setAttribute("admin", "true");
			 response.sendRedirect(request.getContextPath()+"/admin.jsp");//pour ecrire dans url

		}
		else {
			/*message d'erreur*/
			request.getSession().setAttribute("privilege", "true");
			request.setAttribute("infos_erreur", "erreur");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
		}
	}

}
