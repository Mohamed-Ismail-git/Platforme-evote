package com.usthb.util;

import java.io.DataOutputStream;
import java.net.Socket;

public class Send_vote_secure_server {
	public void SendInformations(String ID, String VOTE){
	    String INFORMATIONS= ID.toString()+" "+VOTE.toString();
	    try{      
	        Socket s=new Socket("faroukserver.ddns.net",59898);  
	        DataOutputStream dout=new DataOutputStream(s.getOutputStream());  
	        dout.writeUTF("l "+INFORMATIONS);  
	        dout.flush();  
	        dout.close();  
	        s.close();  
	        }
	    catch(Exception e)
	        {e.printStackTrace();}  

	}
}
