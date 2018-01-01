//
//  ClicktalePlugin.m
//  ClicktaleCordovaPlugin
//
//  Created by Omer Blumenkrunz on 23/04/2017.
//  Copyright © 2017 Clicktale. All rights reserved.
//


#import "ClicktalePlugin.h"
#import <Clicktale/Clicktale.h>

const NSInteger kClicktaleError_Invalid_Arguments  = -2;
const NSInteger kClicktaleError_No_SessionID  = -1;

@interface ClicktalePlugin() <ClicktaleDelegate>
@end

@implementation ClicktalePlugin

- (void)startClicktale:(CDVInvokedUrlCommand*)command
{
    NSString *accessKey = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    NSString *secretKey = [command argumentAtIndex:1 withDefault:@"" andClass:[NSString class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(accessKey == nil || secretKey == nil || [accessKey isEqualToString:@""]  || [secretKey isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        [[Clicktale sharedInstance] setAccessKey:accessKey secretKey:secretKey];
        [[Clicktale sharedInstance] startClicktale];
        [[Clicktale sharedInstance] setDelegate:self];
        [[Clicktale sharedInstance] startPrivacyForWebViews:@[self.webView]];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setDebugLogLevelOn:(CDVInvokedUrlCommand*)command
{
    NSNumber *debugLogLevelOn = [command argumentAtIndex:0 withDefault:[NSNumber numberWithInteger:0] andClass:[NSNumber class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(debugLogLevelOn == nil || ![debugLogLevelOn isKindOfClass:[NSNumber class]])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    if([debugLogLevelOn intValue] == 1)
    {
       [[Clicktale sharedInstance] setLogLevel:CT_LOG_LEVEL_ALL];
    }
    else
    {
      [[Clicktale sharedInstance] setLogLevel:CT_LOG_LEVEL_REQUIRED];
    }

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setVideoTestMode:(CDVInvokedUrlCommand*)command
{
   
    NSNumber *debugIsOn = [command argumentAtIndex:0 withDefault:[NSNumber numberWithInteger:0] andClass:[NSNumber class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(debugIsOn == nil || ![debugIsOn isKindOfClass:[NSNumber class]] )
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    BOOL isOn = NO;
    if([debugIsOn intValue] == 1)
    {
        isOn = YES;
    }
    
    [[Clicktale sharedInstance] setDebugMode:isOn];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setSessionUserID:(CDVInvokedUrlCommand*)command
{
    NSString *userID = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(userID == nil || [userID isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        [[Clicktale sharedInstance] setSessionUserID:userID];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackEvent:(CDVInvokedUrlCommand*)command
{
    NSString *eventName = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(eventName == nil || [eventName isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        [[Clicktale sharedInstance] trackEvent:eventName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackEventAndValue:(CDVInvokedUrlCommand*)command
{
    NSString *eventName  = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    NSString *eventValue = [command argumentAtIndex:1 withDefault:@"" andClass:[NSString class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(eventName == nil || eventValue == nil || [eventName isEqualToString:@""]  || [eventValue isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        [[Clicktale sharedInstance] trackEvent:eventName value:eventValue];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackPageView:(CDVInvokedUrlCommand*)command
{
    NSString *pageName = [command argumentAtIndex:0 withDefault:@"" andClass:[NSString class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(pageName == nil || [pageName isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        [[Clicktale sharedInstance] trackPageView:pageName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)startHidingScreen:(CDVInvokedUrlCommand*)command
{
    [[Clicktale sharedInstance] startHidingScreen];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopHidingScreen:(CDVInvokedUrlCommand*)command
{
    [[Clicktale sharedInstance] stopHidingScreen];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)pauseScreenRecording:(CDVInvokedUrlCommand*)command
{
    [[Clicktale sharedInstance] pauseScreenRecording];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)resumeScreenRecording:(CDVInvokedUrlCommand*)command
{
    [[Clicktale sharedInstance] resumeScreenRecording];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getSessionLink:(CDVInvokedUrlCommand*)command
{
    NSString * sessionLink = [[Clicktale sharedInstance] getSessionLink];
    
    CDVPluginResult* pluginResult = nil;
    
    if(sessionLink == nil || [sessionLink isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_No_SessionID];
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sessionLink];;
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setCrashReporterOff:(CDVInvokedUrlCommand*)command
{
    [[Clicktale sharedInstance] setCrashReporterOff];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) clicktaleDidSessionURLCreated:(NSString *)sessionLink
{
    if (sessionLink != nil)
    {
        NSString *jsonString = [self dictionaryToJSON:@{@"URL":sessionLink}];
        if(jsonString != nil)
        {
            NSString *js = [NSString stringWithFormat:@"cordova.fireDocumentEvent( 'onClicktaleSessionURLCreated' , %@ );", jsonString];
            [self.commandDelegate evalJs:js];
        }
    }
}

- (void) clicktaleDidSessionIDCreated:(NSString *)currentSessionID
{
    if (currentSessionID != nil)
    {
        NSString *jsonString = [self dictionaryToJSON:@{@"SessionID":currentSessionID}];
        if(jsonString != nil)
        {
            NSString *js = [NSString stringWithFormat:@"cordova.fireDocumentEvent( 'onClicktaleSessionIDCreated' , %@ );", jsonString];
            [self.commandDelegate evalJs:js];
        }
    }
    
}

-(NSString *)dictionaryToJSON:(NSDictionary *)dict
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&err];
    
    if(err != nil)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
