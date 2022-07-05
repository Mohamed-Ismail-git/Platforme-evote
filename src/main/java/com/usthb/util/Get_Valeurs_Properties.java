package com.usthb.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;

import org.apache.log4j.Logger;

public class Get_Valeurs_Properties {

		String result = "";
		InputStream inputStream;
		//static final Logger LOGGER = Logger.getLogger(Get_Valeurs_Properties.class);
		public HashMap<String, String> getPropValues() throws IOException {
			HashMap<String, String> config=new HashMap<String,String>();
			try {
				Properties prop = new Properties();			
				String propFileName = "config.properties";
	 
				inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
				if (inputStream != null) {
					prop.load(inputStream);
				} else {
					//LOGGER.info("property file '" + propFileName + "' not found in the classpath ");
					throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
				}
	 
				Date time = new Date(System.currentTimeMillis());
	 
				// get the property value and print it out
			//	String cle_chiffrement_client = prop.getProperty("cle_chiffrement_client").trim();
				String cle_publique = prop.getProperty("cle_publique").trim();

	           // config.put("cle_chiffrement_client", cle_chiffrement_client);
	            config.put("cle_publique", cle_publique);

				result = "Fichier config chargé avec succès " ;
				//LOGGER.info("Fichier config de la plateforme 'config.properties' chargé avec succès ");

			} catch (Exception e) {
				System.out.println("Exception: " + e);
				//LOGGER.info("Exception: " + e);
			} finally {
				inputStream.close();
			}
			return config;
		}
}
