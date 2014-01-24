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

package com.freshplanet.ane.ANEPaeDae.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Example function.
 *
 * Create a new class for each function in your API. Don't forget to add them in
 * ANEPaeDaeExtensionContext.getFunctions().
 */
public class IsSupportedFunction implements FREFunction 
{
	private static String TAG = "[ANEPaeDae] IsSupported -";
	
	public FREObject call(FREContext context, FREObject[] args) 
	{
		Log.d(TAG, "true");
		try
		{
			return FREObject.newObject(true);
		}
		catch (FREWrongThreadException exception)
		{
			Log.d(TAG, exception.getLocalizedMessage());
			return null;
		}
	}
}
