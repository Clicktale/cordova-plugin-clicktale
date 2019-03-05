//
//  ClicktalePlugin.h
//  ClicktaleCordovaPlugin
//
//  Created by Omer Blumenkrunz on 23/04/2017.
//  Copyright © 2017 Clicktale. All rights reserved.
//


#import <Cordova/CDV.h>

@interface ClicktalePlugin : CDVPlugin

/*! @brief Initialization of SDK */
- (void)start:(CDVInvokedUrlCommand*)command;


/*!
 @brief Pause Screen Recording
 Method should be called on an active visit, otherwise it will be ignored
 */
- (void)pauseScreenRecording:(CDVInvokedUrlCommand*)command;


/*!
 @brief Resume Screen Recording
 Method should be called on an active visit, otherwise it will be ignored
 */
- (void)resumeScreenRecording:(CDVInvokedUrlCommand*)command;


/*!
 @brief Check if screen is currently being recorded
 @return true if screen is currently recorded
 */
- (void)isScreenRecording:(CDVInvokedUrlCommand*)command;


/*!
 @brief Starts a new page view (screen) with the given name and optionally the page title.
 
 This method should be used when Automatic Page Detection is disabled.
 If this method is called when Automatic Page Detection is enabled,
 it will be ignored.
 
 @param pageName Page name.
 @param pageTitle Page title.
 */
- (void)startPageView:(CDVInvokedUrlCommand*)command;


/*!
 @brief Adds a dynamic action done by the user on the current page view.
 E.G. "Clicked on Logout"
 
 @param actionName The action name to attach to a pageView.
 */
- (void)addDynamicAction:(CDVInvokedUrlCommand*)command;


/*!
 @brief When called, a Black screen will be shown in the video from now on.
 
 To continue recording actual content, call unblockScreenRecording()
 
 NOTE: This method should be called on an active visit,
 otherwise it will be ignored.
 */
- (void)blockScreenRecording:(CDVInvokedUrlCommand*)command;



/*!
 @brief Return to record actual screen content after a call to blockScreenRecording()
 
 NOTE: This method should be called on an active visit,
 otherwise it will be ignored.
 */
- (void)unblockScreenRecording:(CDVInvokedUrlCommand*)command;


/*!
 @brief Check if screen recording is currently blocked
 
 @return true if screen is currently hidden
 */
- (void)isScreenRecordingBlocked:(CDVInvokedUrlCommand*)command;



/*! @brief Offers the option to opt out from being recorded and tracked */
- (void)optOut:(CDVInvokedUrlCommand*)command;



/*! @brief Offers the option to opt in from being recorded and tracked */
- (void)optIn:(CDVInvokedUrlCommand*)command;



/*! @brief The current optout state (default is NO). */
- (void)isOptOut:(CDVInvokedUrlCommand*)command;



/*!
 @brief A link for playing back the currently recorded visit.
 
 Used for integrations that require supplying a link for playback.
 */
- (void)getVisitLink:(CDVInvokedUrlCommand*)command;



/*! @brief The current visitor Id */
- (void)getVisitorId:(CDVInvokedUrlCommand*)command;


/*! @brief The current visit Id
 
 Visit ID will be -1 if SDK was not started yet.
 */
- (void)getVisitId:(CDVInvokedUrlCommand*)command;



/*! @brief Sets the console log level
 
 @param isDebugMode - whether or not to print debug logs to console
 */
- (void)setDebugMode:(CDVInvokedUrlCommand*)command;



/*! @brief This flag is meant to be used by the app developer, for debug purposes.
 
 It takes the SDK to store the generated video in the device camera roll
 in addition to uploading it to the server
 */
- (void)saveVideoToDevice:(CDVInvokedUrlCommand*)command;



/*! @brief This flag is meant to be used by the app developer, for debug purposes.
 
 It tells the SDK to use the new OSLog logging system
 */
- (void)useOSLogging:(CDVInvokedUrlCommand*)command;

@end
