package com.demo.credentials;


public interface LoginProvider {
	public boolean isAllowed(Credentials credentials);
}


