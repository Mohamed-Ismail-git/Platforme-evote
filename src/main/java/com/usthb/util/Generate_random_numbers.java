package com.usthb.util;

import java.util.Random;

public class Generate_random_numbers {
	public String generate_number() {
	// create instance of Random class
		Random r = new java.util.Random ();
		String s = Long.toString (r.nextLong () & Long.MAX_VALUE, 36);
		return s;
}
}