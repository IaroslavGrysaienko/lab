package com.demo;

import java.util.HashMap;
import java.util.Map;

import com.demo.credentials.BasicLoginProvider;
import com.demo.credentials.Credentials;
import com.demo.credentials.LoginProvider;
import com.demo.credentials.DBLoginProvider;

public class LoginManager {
	private Map<String,LoginProvider> providers;
	
	public LoginManager(){
		providers = new HashMap<String, LoginProvider>();
		providers.put("db", new DBLoginProvider());
		providers.put("basic", new BasicLoginProvider());
	}
	
	public boolean tryLogin(String login, String password, String providerID){
		LoginProvider provider = providers.get(providerID);
		if (provider == null){
			throw new ProviderException();
		}
		providers.get("db").isAllowed(new Credentials(login, password));
		return provider.isAllowed(new Credentials(login, password));

	}
}
