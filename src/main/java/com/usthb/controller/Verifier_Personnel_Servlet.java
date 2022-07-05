package com.usthb.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.usthb.bean.Carte_id;
import com.usthb.dao.check_PIN_validite_dao;
import com.usthb.dao.check_pin_personnel_existance_dao;


public class Verifier_Personnel_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Verifier_Personnel_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code=request.getParameter("code_pin").toString();
		int status=-1;
        /*on le hash*/
		check_pin_personnel_existance_dao pin=new check_pin_personnel_existance_dao();
		boolean valid=pin.verifier_existance_pin(Carte_id.encrypt(code));

		if(valid==true) {
			/*on sait préalablement que l'admin est une suite de 1*/
			if(Carte_id.encrypt(code).toString().trim().equals(Carte_id.encrypt("111111111"))) {
				/*redirection*/
				request.getSession().setAttribute("privilege", "true");
				response.sendRedirect(request.getContextPath()+"/login.jsp");

			}
			else {
				/*envoyer message d'erreur kill session*/
				request.getSession().invalidate();
				request.setAttribute("privilege", "false");
				request.getRequestDispatcher("/index1.jsp").forward(request, response);
				
			}
		}
		else {
			/*envoyer message d'erreur kill session*/
			request.getSession().invalidate();
			request.setAttribute("privilege", "false");
			request.getRequestDispatcher("/index1.jsp").forward(request, response);
		}
		
	}

}
