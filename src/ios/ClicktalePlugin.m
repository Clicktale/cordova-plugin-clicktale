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

const NSInteger kClicktaleRegion_US  = 1;
const NSInteger kClicktaleRegion_EU  = 2;


@interface ClicktalePlugin() <ClicktaleDelegate>
@end

@implementation ClicktalePlugin

- (void)startClicktaleForRegion:(CDVInvokedUrlCommand*)command
{
    NSNumber *projectId      = [command argumentAtIndex:0 withDefault:@"" andClass:[NSNumber class]];
    NSNumber *applicationId  = [command argumentAtIndex:1 withDefault:@"" andClass:[NSNumber class]];
    NSNumber *region         = [command argumentAtIndex:2 withDefault:@"" andClass:[NSNumber class]];
    
    CDVPluginResult* pluginResult = nil;
    CT_REGION ctRegoin = CT_REGION_US;
    
    if(applicationId == nil || projectId == nil || region == nil || [applicationId intValue] == 0 || [projectId intValue] == 0 || [region intValue] == 0)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
    }
    else
    {
        if([region intValue] == kClicktaleRegion_US || [region intValue] == kClicktaleRegion_EU)
        {
            if([region intValue] == kClicktaleRegion_US)
            {
                ctRegoin = CT_REGION_US;
            }
            else if([region intValue] == kClicktaleRegion_EU)
            {
                ctRegoin = CT_REGION_EU;
            }
            
            [[Clicktale sharedInstance] setProjectId:projectId applicationId:applicationId];
            [[Clicktale sharedInstance] startClicktaleForRegion:ctRegoin];
            [[Clicktale sharedInstance] setDelegate:self];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
        }
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

- (void)setOptOut:(CDVInvokedUrlCommand*)command
{
    NSNumber *isOptOut = [command argumentAtIndex:0 withDefault:[NSNumber numberWithInteger:0] andClass:[NSNumber class]];
    
    CDVPluginResult* pluginResult = nil;
    
    if(isOptOut == nil || ![isOptOut isKindOfClass:[NSNumber class]])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsNSInteger:kClicktaleError_Invalid_Arguments];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    if([isOptOut boolValue] == YES)
    {
        [[Clicktale sharedInstance] setOptOut:YES];
    }
    else
    {
        [[Clicktale sharedInstance] setOptOut:NO];
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isOptOut:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[[Clicktale sharedInstance] isOptOut]];
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
