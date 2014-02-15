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

#import "ANEPaedae.h"
#import "PaeDaeSDK.h"
#import "ANEPaeDaeDelegate.h"

FREContext          ANEPaedaeCtx = nil;
ANEPaeDaeDelegate   *paeDaeDelegate = nil;

@implementation ANEPaedae

#pragma mark - Singleton

static ANEPaedae *sharedInstance = nil;

+ (ANEPaedae *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

@end


#pragma mark - C interface

/* This is a TEST function that is being included as part of this template. 
 *
 * Users of this template are expected to change this and add similar functions 
 * to be able to call the native functions in the ANE from their ActionScript code
 */
DEFINE_ANE_FUNCTION(isSupported)
{
    NSLog(@"Entering isSupported()");

    FREObject fo;

    FREResult aResult = FRENewObjectFromBool(YES, &fo);
    if (aResult == FRE_OK)
    {
        //things are fine
        NSLog(@"Result = %d", aResult);
    }
    else
    {
        //aResult could be FRE_INVALID_ARGUMENT or FRE_WRONG_THREAD, take appropriate action.
        NSLog(@"Result = %d", aResult);
    }
    
    NSLog(@"Exiting isSupported()");
    
    return fo;
}


DEFINE_ANE_FUNCTION(initWithAppId)
{
    uint32_t    strLen;
    PDDEBUG = true;
    
    if (paeDaeDelegate == nil)
    {
        paeDaeDelegate = [[ANEPaeDaeDelegate alloc] init];
    }
    
    NSString    *appID = nil;
    const   uint8_t *idString;
    
    if (FREGetObjectAsUTF8(argv[0], &strLen, &idString) == FRE_OK)
    {
        appID = [NSString stringWithUTF8String:(char*)idString];
    }
    
    NSLog(@"initWithAppId with delegate(): %@", appID);
    
    [[PaeDaeSDK sharedManager] initWithAppId:appID andDelegate:paeDaeDelegate];
    
    return nil;
}

DEFINE_ANE_FUNCTION(showAd)
{
    NSString    *zoneID = nil;
    uint32_t    strLen;
    const   uint8_t *idString;
    
    if (FREGetObjectAsUTF8(argv[0], &strLen, &idString) == FRE_OK)
    {
        zoneID = [NSString stringWithUTF8String:(char*)idString];
    }
    
    NSLog(@"showAd: %@", zoneID);
    
    NSDictionary    *adOptions = [NSDictionary dictionaryWithObjectsAndKeys:zoneID, @"zone_id", nil];
    [[PaeDaeSDK sharedManager] showAdWithOptions:adOptions andDelegate:paeDaeDelegate];
    
    return nil;
}

#pragma mark - ANE setup

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ANEPaeDaeContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");

    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 3;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &isSupported;

    func[1].name = (const uint8_t*) "initWithAppId";
    func[1].functionData = NULL;
    func[1].function = &initWithAppId;

    func[2].name = (const uint8_t*) "showAd";
    func[2].functionData = NULL;
    func[2].function = &showAd;

    *functionsToSet = func;

    ANEPaedaeCtx = ctx;

    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ANEPaeDaeContextFinalizer(FREContext ctx)
{
}

/* ANEPaedaeExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml
 */
void ANEPaedaeExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"Entering ANEPaedaeExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ANEPaeDaeContextInitializer;
    *ctxFinalizerToSet = &ANEPaeDaeContextFinalizer;
    
    NSLog(@"Exiting ANEPaedaeExtInitializer()");
}

/* ANEPaedaeExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml
 */
void ANEPaedaeExtFinalizer(void* extData)
{
}

