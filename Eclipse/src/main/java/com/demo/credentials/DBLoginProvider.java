package com.demo.credentials;


public class DBLoginProvider implements LoginProvider{

	public boolean isAllowed(Credentials credentials) {
		if (credentials.getLogin().equalsIgnoreCase("user1")){
			return true;
		}
		return false;
	}
}
