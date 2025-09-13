package com.client.hooks;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.openqa.selenium.remote.DesiredCapabilities;

import com.nimble.enumerator.Platform;
import com.nimble.enumerator.PlatformName;
import com.nimble.exception.UnsupportedPlatformException;
import com.nimble.hooks.ICustomHooks;

import io.cucumber.java.Scenario;

public class HooksImpl implements ICustomHooks{

	private static final Logger log = Logger.getLogger(HooksImpl.class);
	

//	private static String platform = null;
//	private static String  platformName = null;
//	private static String platform_version = null;
	private static String env = null;
	private static String tags = null;


	
	@Override
	public void initialize() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void beforeScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void beforeSuccessScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void beforeFailedScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterSuccessScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterFailedScenario(Scenario s) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void terminate() {
		// TODO Auto-generated method stub
		
	}

	
	@Override
	public Map<String, Object> setDesiredCapabilities() {
		return getProperties();
	}

	@Override
	public Map<String, String> storeEnvironmentProperties() {
		Map<String,String> _map = new HashMap<String, String>();
		_map.put("cucubmerTags", tags);
		
		return _map;
	}
	
	private Map<String, Object> getProperties(){

		//**** Below variables to be used when Runtime variables are implemented ****/
		tags = System.getProperty("cucumber.filter.tags");
    
		Map<String, Object> capabilitiesMap = null;
		DesiredCapabilities _capabilities= new DesiredCapabilities();
		
		_capabilities.setCapability("platformName", System.getProperty("platform.name"));
		_capabilities.setCapability("deviceName", System.getProperty("device.name") );
		_capabilities.setCapability("platformVersion", System.getProperty("platform.version"));
		_capabilities.setCapability("noReset", true);
		_capabilities.setCapability("fullReset", false);
		_capabilities.setCapability("newCommandTimeout", 180000);
		
		
		switch (System.getProperty("platform.name").toLowerCase()) {
		case "android":

			//_capabilities.setCapability("appPackage", "ae.ahb.digital.cit");
			//_capabilities.setCapability("appActivity", "ae.ahb.digital.appstartup.SplashActivity");
			_capabilities.setCapability("appPackage", System.getProperty("app.package"));
			_capabilities.setCapability("appActivity", System.getProperty("app.activity"));
			_capabilities.setCapability("automationName", "UiAutomator2");
			//_capabilities.setCapability("autoGrantPermissions", true);
			_capabilities.setCapability("autoAcceptAlerts", true);
			_capabilities.setCapability("appium:forceAppLaunch", true);
			//_capabilities.setCapability("appium:settings[enableMultiWindows]", true);
			log.info("Capabilities: " + _capabilities);
			capabilitiesMap = _capabilities.asMap();
			break;

		case "ios":
			//String path = "src/test/resources/iOS/" + env;
			//File appDir = new File(path);
			//File appName = new File(appDir, "sampleApp.app");
			//Build should be present in Resource folder of the directory
			//_capabilities.setCapability("platformVersion", "17.4");
			_capabilities.setCapability("automationName", "XCUITest");
			//_capabilities.setCapability("app", appName.getAbsolutePath());
			//_capabilities.setCapability("udid", "5F5DA3D3-3965-4A10-B294-5ED5D659C637");
//			_capabilities.setCapability("bundleId", "com.apple.Preferences");
			_capabilities.setCapability("bundleId", "com.apple.Preferences");
			//_capabilities.setCapability("bundleId", "ae.ahbdigital.cit");
			log.info("Capabilities: " + _capabilities);
			capabilitiesMap = _capabilities.asMap();
			break;
		}


		return capabilitiesMap;

	}
	
	@Override
	public String setUrl() {
		
		if ("web".equalsIgnoreCase(System.getProperty("platform")))
			return System.getProperty("url");
		if ("mobile".equalsIgnoreCase(System.getProperty("platform")))
			return "http://0.0.0.0:4723/wd/hub";
		
		throw new UnsupportedPlatformException(System.getProperty("platform") + "is not supported.");

	}

	@Override
	public Platform setPlatform() {
		if ("web".equalsIgnoreCase(System.getProperty("platform")))
			return Platform.WEB;
		if ("mobile".equalsIgnoreCase(System.getProperty("platform")))
			return Platform.MOBILE;
        if ("server".equalsIgnoreCase(System.getProperty("platform")))
            return Platform.SERVER;

		throw new UnsupportedPlatformException(System.getProperty("platform") + "is not supported.");
	}

	@Override
	public PlatformName setPlatformName() {
		
		if (System.getProperty("platform.name") == null)
			throw new RuntimeException("platform.name is the mandatory environment variable.");
		
		switch (System.getProperty("platform.name").toLowerCase()) {
			case "ios":
				return PlatformName.IOS;
			case "android":
				return PlatformName.ANDROID;
			case "chrome":
				return PlatformName.CHROME;
			case "edge":
				return PlatformName.EDGE;
			case "safari":
				return PlatformName.SAFARI;
			case "firefox":
				return PlatformName.FIREFOX;
		}
		
		throw new UnsupportedPlatformException(System.getProperty("platform") + "is not supported.");
	}

	@Override
	public String setLicenseKey() {
		return "19D162-47FBA7-4545AE-B77271-310981-87B7D2";
//		return null;
	}

}
