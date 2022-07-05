package com.usthb.controller;

import javax.servlet.*;

import com.usthb.util.Get_Valeurs_Properties;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
public class CharsetFilter implements Filter {

    private String encoding;
	//static final Logger LOGGER = Logger.getLogger(CharsetFilter.class);

    public void init(FilterConfig config) throws ServletException {
        encoding = config.getInitParameter("requestEncoding");
        if (encoding == null) encoding = "UTF-8";
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain next)
            throws IOException, ServletException {
        // Respect the client-specified character encoding
        // (see HTTP specification section 3.4.1)
        if (null == request.getCharacterEncoding()) {
            request.setCharacterEncoding(encoding);
        }

        // Set the default response content type and encoding
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.err.println("mise en place de l'encodage à UTF-8 dans la plateforme");
    	//LOGGER.info("Mise de l'encodage à UTF-8 dans la plateforme ");
        next.doFilter(request, response);
        
    }

    public void destroy() {
    }
}