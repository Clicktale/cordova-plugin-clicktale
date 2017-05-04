//
//  ClicktalePlugin.h
//  ClicktaleCordovaPlugin
//
//  Created by Omer Blumenkrunz on 23/04/2017.
//  Copyright © 2017 Clicktale. All rights reserved.
//


#import <Cordova/CDV.h>

@interface ClicktalePlugin : CDVPlugin

- (void)startClicktale:(CDVInvokedUrlCommand*)command;
- (void)setDebugLogLevelOn:(CDVInvokedUrlCommand*)command;
- (void)setVideoTestMode:(CDVInvokedUrlCommand*)command;
- (void)setSessionUserID:(CDVInvokedUrlCommand*)command;
- (void)trackEvent:(CDVInvokedUrlCommand*)command;
- (void)trackEventAndValue:(CDVInvokedUrlCommand*)command;
- (void)trackPageView:(CDVInvokedUrlCommand*)command;
- (void)startHidingScreen:(CDVInvokedUrlCommand*)command;
- (void)stopHidingScreen:(CDVInvokedUrlCommand*)command;
- (void)pauseScreenRecording:(CDVInvokedUrlCommand*)command;
- (void)resumeScreenRecording:(CDVInvokedUrlCommand*)command;
- (void)getSessionLink:(CDVInvokedUrlCommand*)command;
- (void)setCrashReporterOff:(CDVInvokedUrlCommand*)command;

@end
