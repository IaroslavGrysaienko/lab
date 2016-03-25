package com.demo.credentials;

public class BasicLoginProvider implements LoginProvider{

	public boolean isAllowed(Credentials credentials) {
		if (credentials.getLogin().equalsIgnoreCase("user2")){
			return true;
		}
		return false;
	}

}
