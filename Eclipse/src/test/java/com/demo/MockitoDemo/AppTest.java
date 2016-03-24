package com.demo.MockitoDemo;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import com.demo.LoginManager;
import com.demo.ProviderException;
import com.demo.credentials.BasicLoginProvider;
import com.demo.credentials.Credentials;
import com.demo.credentials.LoginProvider;
import com.demo.credentials.DBLoginProvider;

/**
 * Unit test for simple App.
 */

@RunWith(MockitoJUnitRunner.class)
public class AppTest {

	@Mock
	private BasicLoginProvider basicProvider;

	@Mock
	private DBLoginProvider dbProvider;

	@Mock
	private Map<String, LoginProvider> providers;

	@InjectMocks
	private LoginManager manager;

	@Before
	public void setUp() {
		// We need to use mock's instead of
		// original providers, which are initialized in LoginManager's
		// constructor
		when(providers.get("basic")).thenReturn(basicProvider);
		when(providers.get("db")).thenReturn(dbProvider);
	}

	@Test(expected = ProviderException.class)
	public void loginWithInvalidProviderShouldRiseException() {
		manager.tryLogin("any", "any", "errorProvider");
	}

	@Test
	public void onlyBasicLoginProviderShouldBeCalled() {
		manager.tryLogin("any", "any", "basic");
		// Check if basicProvider handled login
		verify(basicProvider).isAllowed(new Credentials("any", "any"));
		// but not db provider
		verify(dbProvider, never()).isAllowed(any(Credentials.class));
		// same as previous
		verifyZeroInteractions(dbProvider);
	}
	
	@Test
	public void onlyDBLoginProviderShouldBeCalled() {
		manager.tryLogin("any", "any", "db");
		// Check if db handled login
		verify(dbProvider).isAllowed(new Credentials("any", "any"));
		// but not basic provider
		verifyZeroInteractions(basicProvider);
	}

}
