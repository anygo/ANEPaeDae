package com.freshplanet.ane.ANEPaeDae.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.ANEPaeDae.ANEPaeDaeExtension;
import com.freshplanet.ane.ANEPaeDae.BaseFunction;

public class InitFunction extends BaseFunction 
{
	private static String TAG = "[ANEPaeDae] Init -";
	
	public FREObject call(FREContext context, FREObject[] args) 
	{
		super.call (context, args);
		
		String id = getStringFromFREObject (args[0]);
		ANEPaeDaeExtension.context.init (id);
		
		return null;
	}
}
