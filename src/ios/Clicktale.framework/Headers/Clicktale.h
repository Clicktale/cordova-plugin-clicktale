//
//  Clicktale.h
//  Clicktale
//
//  Created by Omer Blumenkrunz on 22/12/2016.
//  Copyright (c) 2017 Clicktale, Inc. All rights reserved.
//  Version : 2.1.14

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CLLocation;
@class WKWebView;

typedef enum CT_LOG_LEVEL
{
    CT_LOG_LEVEL_NONE,
    CT_LOG_LEVEL_WARNING,
    CT_LOG_LEVEL_INFO,
    CT_LOG_LEVEL_ALL,
    CT_LOG_LEVEL_REQUIRED
}CT_LOG_LEVEL;


typedef enum CT_QUALITY
{
    CT_QUALITY_LOW,
    CT_QUALITY_LOW_PLUS,
    CT_QUALITY_MEDIUM,
    CT_QUALITY_MEDIUM_PLUS,
    CT_QUALITY_HIGH,
    CT_QUALITY_HIGH_PLUS,
    CT_QUALITY_HD
}CT_QUALITY;


#define kCTClicktaleBackgroundDataFlushFinish  @"ClicktaleBackgroundDataFlushFinish"

@protocol ClicktaleDelegate <NSObject>
@optional

/**
 SDK did start running,
 you can now track events and screen recording will start
 */
- (void) clicktaleDidStart;

/**
 SDK did fail to start
 */
- (void) clicktaleDidFail;

/**
 Current session ID
 
 @param currentSessionID  NSString Session ID.
 */
- (void) clicktaleDidSessionIDCreated:(NSString *)currentSessionID;

/**
 Current session dashboard URL
 
 @param sessionLink  NSString dashboard URL.
 */
- (void) clicktaleDidSessionURLCreated:(NSString *)sessionLink;

@end


@interface Clicktale : NSObject

#pragma mark - Properties
#pragma mark ----------------------

@property(nonatomic, strong) NSString *accessKey;
@property(nonatomic, strong) NSString *secretKey;
@property(nonatomic, strong) NSDictionary *userDefinedDictionary;
@property(nonatomic, strong) NSString *userID;

@property(nonatomic, readonly) NSString *SDKVersion;
@property(nonatomic, assign) CT_LOG_LEVEL logLevel;
@property(nonatomic, assign) int dispatchInterval;
@property(nonatomic, assign) id<ClicktaleDelegate> delegate;


#pragma mark Initialization methods
#pragma mark ----------------------
/* Returns the default singleton instance.
 
 @return Clicktale shared instance
 */
+ (Clicktale *) sharedInstance;

/**
 *Sets Clicktale Access Key and Secret Key
 *
 *@param access_key NSString Application Access Key.
 *@param secretKey  NSString Application Secret Key.
 
 @see [Getting Started](http://apps-docs.clicktale.com/ios/getting-started.html)

 */
-(void)setAccessKey:(NSString *)access_key secretKey:(NSString *)secretKey;

/**
 Starts SDK to record and track all events.
 
 @see [Getting Started](http://apps-docs.clicktale.com/ios/getting-started.html)

 */
-(void)startClicktale;

/**
 Sets a UserID, so you can easily find sessions in the dashboard
 
 @param userID NSString The custom userID you want to set.
 
 @see [Using Events](http://apps-docs.clicktale.com/ios/using-events.html)
 
 */
-(void)setSessionUserID:(NSString *)userID;

/**
 Sets a user defined dictionary for every session.
 
 @param dict NSDictionary The custom data you want to set for this session.
 */
-(void)setPreDefinedDictionaryForSession:(NSDictionary *)dict;

/**
 Pause Screen Recording

 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)pauseScreenRecording;

/**
 Resume Screen Recording
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)resumeScreenRecording;

/**
 Check if screen is Recorded
 
 @return BOOL is screen recorded
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(BOOL)isScreenRecorded;


#pragma mark Tracking methods
#pragma mark ----------------------


/**
 A custom track page method.
 You have to set the page's name.
 
 @param name NSString Page name.
 
 @see [Using Events](http://apps-docs.clicktale.com/ios/using-events.html)

 */
-(void)trackPageView:(NSString *)name;

/**
 A simple track event method.
 Log your custom events with this function
 
 @param event NSString event name.
 
 @see [Using Events](http://apps-docs.clicktale.com/ios/using-events.html)

 */
-(void)trackEvent:(NSString *)event;

/**
 A custom track event method.
 Log your custom events with values with this function
 
 @param event NSString event name.
 @param value NSString event's value.
 
 @see [Using Events](http://apps-docs.clicktale.com/ios/using-events.html)

 */
-(void)trackEvent:(NSString *)event value:(NSString *)value;

/**
 A custom track event method.
 Log geo location with this function
 
 @param location CLLocation laction data.
 
 @see [Advanced Features](http://apps-docs.clicktale.com/ios/advanced-features.html)

 */
-(void)trackGeoLocation:(CLLocation *)location;

/**
 Bind a WKWebView (UIWebView not supported) to SDK in order to receive and track events.
 Use the following JavaScript in your page to trigger events:
 Clicktale.TrackEvent('event name here');
 Clicktale.TrackEventAndValue('event name here','event value here');
 Clicktale.TrackPageView('page name here');
 
 @param webView WKWebView to bind and recive events from.
 
 @see [Using Events](http://apps-docs.clicktale.com/ios/using-events.html)

 */
-(void)bindWebViewForEventTracking:(WKWebView *)webView;

#pragma mark Privacy methods
#pragma mark ----------------------

/**
 Start hiding all of the screen
 A Black screen will be showen in the video
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)startHidingScreen;

/**
 Stop Hiding all of the screen
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopHidingScreen;

/**
 Check if screen is hidden
 
 @return BOOL is screen hidden
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(BOOL)isScreenHidden;

/**
 Start hiding UIView & UITextField collection
 
 @param views NSArray array of views you want to hide.
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)startPrivacyForViews:(NSArray <UIView *> *)views;

/**
 Stop hiding  UIView & UITextField
 
 @param views NSArray array of views you want to stop hiding.
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopPrivacyForViews:(NSArray <UIView *> *)views;

/**
 Stop hiding All  UIView & UITextField collection
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopPrivacyForAllViews;

/**
 Start hiding WebViews collection (UIWebView Or WKWebView)
 that has elements with ClassName 'ctHidden' and zoom is NOT enabled
 
 @param views NSArray array of WebViews you want to hide.
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)startPrivacyForWebViews:(NSArray *)views;

/**
 Stop hiding WebViews
 
 @param views NSArray array of views you want to stop hiding.
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopPrivacyForWebViews:(NSArray *)views;

/**
 Stop hiding All WebViews collection
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopPrivacyForAllWebViews;

/**
 Stop hiding All UIViews and UITextfields and WebViews collection you added
 
 @see [Privacy](http://apps-docs.clicktale.com/ios/privacy.html)

 */
-(void)stopPrivacyForAll;

#pragma mark Util methods
#pragma mark ----------------------


/**
 Current session dashboard URL
 
 @return NSString  dashboard URL.
 
 @see [Data Integrations](http://apps-docs.clicktale.com/integrations/about-integrations.html)

 */
-(NSString *)getSessionLink;

/**
 Current session ID
 
 @return NSString Session ID.
 */
-(NSString *)getSessionID;

/**
 Check for are access keys set.
 
 @return BOOL is the application access Key set
 */
-(BOOL)isAccessKeysSet;

/**
 SDK has a stopwatch, so it returns current seconds for current session.
 If a session ends, stopwatch will be reset.
 */
-(NSTimeInterval)getRunTime;

/**
 Set Debug Mode on/off
 When debug mode on,the SDK will save videos to Photos Album before uploading it to server
 (1 second after application goes to background)
 
 @param on BOOL YES- Debug mode on/ NO- Debug mode off - default is NO
 
 @see [Advanced Features](http://apps-docs.clicktale.com/ios/advanced-features.html)

 */
-(void)setDebugMode:(BOOL)on;


/**
 Sets Crash reporting off
 Call this method before startClicktale if you don't want
 the SDK to collect crash reports or you use different crash reporting mechanism
 (By default the Crash reporter is on)
 
 @see [Advanced Features](http://apps-docs.clicktale.com/ios/advanced-features.html)

 */
-(void)setCrashReporterOff;

/**
 Sends data to Clicktale in background fetch.
 In order to improve data and video delivery to Clicktale
 you can call this method from background fetch method in your AppDelegate:
 
 Objective-C:
 - (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

 Swift:
 optional func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
 
 Be sure to enable background fetching and to check Background fetch in the Capabilities tab, and in addition call:

 Objective-C:
 [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
 
 Swift:
 UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)

 In your AppDelegate at:
 
 Objective-C:
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

 Swift:
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


 @param completionHandler The Background Fetch completionHandler you recived from performFetchWithCompletionHandler
 
 Upon data transfer complete we will call the completion handler.
 If nil is passed instead of the completion handler, Clicktale will not call it and then you should call the completionHandler yourself,
 Clicktale will post a notification upon finish of the logic. Notification name is kCTClicktaleBackgroundDataFlushFinish.
 
 @see [Advanced Features](http://apps-docs.clicktale.com/ios/advanced-features.html)
 
 */
-(void)flushDataInBackgroundWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

@end
