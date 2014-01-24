//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////


package com.freshplanet.ane.ANEPaeDae;

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.freshplanet.ane.ANEPaeDae.functions.InitFunction;
import com.freshplanet.ane.ANEPaeDae.functions.IsSupportedFunction;
import com.paedae.android.sdk.PaeDae;

public class ANEPaeDaeExtensionContext extends FREContext 
{
	private static String TAG = "[ANEPaeDae]";
	
	public ANEPaeDaeExtensionContext()
	{
		Log.d(TAG, "Creating Extension Context");
	}
	
	@Override
	public void dispose() 
	{
		Log.d(TAG, "Disposing Extension Context");
		ANEPaeDaeExtension.context = null;
	}

	/**
	 * Registers AS function name to Java Function Class
	 */
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Log.d(TAG, "Registering Extension Functions");
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("isSupported", new IsSupportedFunction());
		functionMap.put("init", new InitFunction());
		// add other functions here
		return functionMap;	
	}
	
	PaeDae.SessionInterface sessionInterface = new PaeDae.SessionInterface() {
		
		@Override
		public void onSessionStarted() {
				Log.d (TAG, "PaeDae session Started");
			// TODO Auto-generated method stub
			
		}
		
		@Override
		public void onSessionFailed() {
			// TODO Auto-generated method stub
			
		}
	};
	
	public	void init (String id)
	{
		PaeDae.getInstance().setSessionInterface(sessionInterface);
//		PaeDae.getInstance().startSession (this, id);
	}	
}
