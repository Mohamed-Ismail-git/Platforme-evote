package com.usthb.bean;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/*classe pour la carte d'identité*/
public class Carte_id {

	private int id;   /*id de la colonne dans la base de données*/
	private String id_carte;  /*id de la carte d'identité*/
	//private int vote_status;  /* a t'il déjà voté ou pas*/
	private int ability;  /* a t'il le droit de voter ou pas*/
	//private String pin;
	private static SecretKeySpec secretKey;
	  private static byte[] key;
	public Carte_id() {
	
	}
	
	public Carte_id(int id, String id_carte, int ability) {
		super();
		this.id = id;
		this.id_carte = id_carte;
		this.ability = ability;
	}
	

	public int getAbility() {
		return ability;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getId_carte() {
		return id_carte;
	}

	public void setId_carte(String id_carte) {
		this.id_carte = id_carte;
	}


	public int isAbility() {
		return ability;
	}

	public void setAbility(int ability) {
		this.ability = ability;
	}
	public static String encrypt(String strToEncrypt) 
	{
		try {
            // getInstance() method is called with algorithm SHA-512
            MessageDigest md = MessageDigest.getInstance("SHA-512");
  
            // digest() method is called
            // to calculate message digest of the input string
            // returned as array of byte
            byte[] messageDigest = md.digest(strToEncrypt.getBytes());
  
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
  
            // Convert message digest into hex value
            String hashtext = no.toString(16);
  
            // Add preceding 0s to make it 32 bit
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
  
            // return the HashText
            return hashtext;
        }
  
        // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
	}
}
