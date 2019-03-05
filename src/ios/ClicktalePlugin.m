//
//  ClicktalePlugin.m
//  ClicktaleCordovaPlugin
//
//  Created by Omer Blumenkrunz on 23/04/2017.
//  Copyright © 2017 Clicktale. All rights reserved.
//


#import "ClicktalePlugin.h"
#import <Clicktale/Clicktale.h>

#import <WebKit/WebKit.h>

const NSInteger kClicktaleError_Invalid_Arguments  = -2;
const NSInteger kClicktaleError_No_SessionID  = -1;


const NSString* kRegionTypeEurope = @"EUROPE";
const NSString* kRegionTypeUS = @"US";


@interface ClicktalePlugin() <ClicktaleDelegate>
@end

@implementation ClicktalePlugin


- (BOOL)isValidRegion:(NSString *)region
{
    return ([region isEqualToString:[NSString stringWithFormat:@"%@",kRegionTypeEurope]] ||
            [region isEqualToString:[NSString stringWithFormat:@"%@",kRegionTypeUS]]);
}

- (NSInteger)toNativeRegionType: (NSString *)region
{
    if (region)
    {
        if([region isEqualToString:[NSString stringWithFormat:@"%@",kRegionTypeEurope]]) { return CTRegionEurope; }
        if([region isEqualToString:[NSString stringWithFormat:@"%@",kRegionTypeUS]])     { return CTRegionUnitedStates; }
    }
    
    return -1;
}

/*! @brief Initialization of SDK */
- (void)start:(CDVInvokedUrlCommand *)command
{
    NSString *region         = [command argumentAtIndex:0];
    NSNumber *projectId      = [command argumentAtIndex:1];
    NSNumber *applicationId  = [command argumentAtIndex:2];
    
    CDVPluginResult *pluginResult = nil;
    CTRegion ctRegoin = CTRegionUnitedStates;
    
    if( region == nil || projectId == nil || applicationId == nil || ![self isValidRegion:region])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        switch ([self toNativeRegionType:region])
        {
            case CTRegionEurope:
                ctRegoin = CTRegionEurope;
                break;
            case CTRegionUnitedStates:
                ctRegoin = CTRegionUnitedStates;
                break;
        }
        
        [Clicktale setDelegate:self];
        [Clicktale saveVideoToDevice:YES];
        [Clicktale setConsoleLogLevelTo:CTConsoleLogLevelInfo];
        
        [Clicktale start:ctRegoin :[projectId intValue] :[applicationId intValue]];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/*!
 @brief Pause Screen Recording
 Method should be called on an active visit, otherwise it will be ignored
 */
- (void)pauseScreenRecording:(CDVInvokedUrlCommand *)command
{
    [Clicktale pauseScreenRecording];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Resume Screen Recording
 Method should be called on an active visit, otherwise it will be ignored
 */
- (void)resumeScreenRecording:(CDVInvokedUrlCommand *)command
{
    [Clicktale resumeScreenRecording];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Check if screen is currently being recorded
 @return true if screen is currently recorded
 */
- (void)isScreenRecording:(CDVInvokedUrlCommand*)command
{
    BOOL isScreenRecording = [Clicktale isScreenRecording];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isScreenRecording];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Starts a new page view (screen) with the given name and optionally the page title.
 
 This method should be used when Automatic Page Detection is disabled.
 If this method is called when Automatic Page Detection is enabled,
 it will be ignored.
 
 @param pageName Page name.
 @param pageTitle Page title.
 */
- (void)startPageView:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = nil;
    
    NSString *pageName  = [command argumentAtIndex:0];
    
    //optional parameter
    NSString *pageTitle = [command argumentAtIndex:1];
    pageTitle = pageTitle.length > 0 ? pageTitle : nil;
    
    if (pageName == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
        
        [Clicktale startPageViewWithNamed:pageName titled:pageTitle];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Adds a dynamic action done by the user on the current page view.
 E.G. "Clicked on Logout"
 
 @param actionName The action name to attach to a pageView.
 */
- (void)addDynamicAction:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
    
    NSString *actionName  = [command argumentAtIndex:0];
    
    if (actionName == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
        
        [Clicktale addDynamicAction:actionName];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief When called, a Black screen will be shown in the video from now on.
 
 To continue recording actual content, call unblockScreenRecording()
 
 NOTE: This method should be called on an active visit,
 otherwise it will be ignored.
 */
- (void)blockScreenRecording:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [Clicktale blockScreenRecording];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Return to record actual screen content after a call to blockScreenRecording()
 
 NOTE: This method should be called on an active visit,
 otherwise it will be ignored.
 */
- (void)unblockScreenRecording:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [Clicktale unblockScreenRecording];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief Check if screen recording is currently blocked
 
 @return true if screen is currently hidden
 */
- (void)isScreenRecordingBlocked:(CDVInvokedUrlCommand*)command
{
    BOOL isScreenRecordingBlocked = [Clicktale isScreenRecordingBlocked];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isScreenRecordingBlocked];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



/*! @brief Offers the option to opt out from being recorded and tracked */
- (void)optOut:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [Clicktale setOptOut:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief Offers the option to opt in from being recorded and tracked */
- (void)optIn:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [Clicktale setOptOut:FALSE];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief The current optout state (default is NO). */
- (void)isOptOut:(CDVInvokedUrlCommand*)command
{
    BOOL isOptOut = [Clicktale isOptOut];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isOptOut];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*!
 @brief A link for playing back the currently recorded visit.
 
 Used for integrations that require supplying a link for playback.
 */
- (void)getVisitLink:(CDVInvokedUrlCommand*)command
{
    NSString *visitLink = (NSString *)[Clicktale visitLink];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:visitLink];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief The current visitor Id */
- (void)getVisitorId:(CDVInvokedUrlCommand*)command
{
    double visitorIdentifier = [Clicktale visitorIdentifier];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:visitorIdentifier];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief The current visit Id
 
 Visit ID will be -1 if SDK was not started yet.
 */
- (void)getVisitId:(CDVInvokedUrlCommand*)command
{
    double visitIdentifier = [Clicktale visitorIdentifier];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:visitIdentifier];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief Sets the console log level
 
 @param isDebugMode - whether or not to print debug logs to console
 */
- (void)setDebugMode:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
    
    NSNumber *isDebugMode = (NSNumber *)[command argumentAtIndex:0];
    
    if (isDebugMode == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        if ([isDebugMode boolValue])
        {
            [Clicktale setConsoleLogLevelTo: CTConsoleLogLevelInfo];
        }
        else
        {
            [Clicktale setConsoleLogLevelTo: CTConsoleLogLevelSevere];
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



/*! @brief This flag is meant to be used by the app developer, for debug purposes.
 
 It takes the SDK to store the generated video in the device camera roll
 in addition to uploading it to the server
 */
- (void)saveVideoToDevice:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
    
    NSNumber *saveVideoToDevice = (NSNumber *)[command argumentAtIndex:0];
    
    if (saveVideoToDevice == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
        
        [Clicktale saveVideoToDevice:[saveVideoToDevice boolValue]];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*! @brief This flag is meant to be used by the app developer, for debug purposes.
 
 It tells the SDK to use the new OSLog logging system
 */
- (void)useOSLogging:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
    
    NSNumber *useOSLogging = (NSNumber *)[command argumentAtIndex:0];
    
    if (useOSLogging == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
        
        [Clicktale useOSLogging:[useOSLogging boolValue]];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSString *)dictionaryToJSON:(NSDictionary *)dict
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&err];
    
    if(err != nil)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - ClicktaleDelegate methods

- (void)clicktaleVisitDidStartSuccessfullyFor:(int64_t)visitID visitLink:(NSString * _Nullable)link
{
    if (link != nil)
    {
        NSString *jsonString = [self dictionaryToJSON:@{@"URL":link}];
        if(jsonString != nil)
        {
            NSString *js = [NSString stringWithFormat:@"cordova.fireDocumentEvent('visitStartedSuccessfully' , %@ );", jsonString];
            [self.commandDelegate evalJs:js];
        }
    }
}

- (void)clicktaleVisitDidFailToStart
{
    NSString *js = @"cordova.fireDocumentEvent('visitFailed');";
    [self.commandDelegate evalJs:js];
}

- (void)clicktaleVisitDidEndFor:(int64_t)visitID
{
    NSString *strVisitId = [NSString stringWithFormat:@"%lld", visitID];
    NSString *jsonString = [self dictionaryToJSON:@{@"SessionID": strVisitId}];
    if(jsonString != nil)
    {
        NSString *js = [NSString stringWithFormat:@"cordova.fireDocumentEvent('visitEnded' , %@ );", jsonString];
        [self.commandDelegate evalJs:js];
    }
}


@end
