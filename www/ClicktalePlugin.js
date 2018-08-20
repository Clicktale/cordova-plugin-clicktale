/**
 * ClicktalePlugin.js
 *
 * Clicktale Cordova plugin.
 *
 * Author: Omer Blumenkrunz
 */

var exec = require('cordova/exec');

exports.startClicktale = function(accessKey, secretKey, success, error) {
    exec(success, error, "ClicktalePlugin", "startClicktale", [accessKey,secretKey]);
};

exports.startClicktaleForRegion = function(projectId, applicationId,region, success, error) {
       exec(success, error, "ClicktalePlugin", "startClicktaleForRegion", [projectId,applicationId,region]);
};

exports.setDebugLogLevelOn = function(logLevelOn, success, error) {
    exec(success, error, "ClicktalePlugin", "setDebugLogLevelOn", [logLevelOn]);
};

exports.setVideoTestMode = function(videoTestModeOn, success, error) {
    exec(success, error, "ClicktalePlugin", "setVideoTestMode", [videoTestModeOn]);
};

exports.setSessionUserID = function(userID, success, error) {
    exec(success, error, "ClicktalePlugin", "setSessionUserID", [userID]);
};

exports.setOptOut = function(isOptOut, success, error) {
    exec(success, error, "ClicktalePlugin", "setOptOut", [isOptOut]);
};

exports.isOptOut = function(success, error) {
        exec(success, error, "ClicktalePlugin", "isOptOut", []);
};

exports.trackEvent = function(eventName, success, error) {
    exec(success, error, "ClicktalePlugin", "trackEvent", [eventName]);
};

exports.trackPageView = function(pageName, success, error) {
    exec(success, error, "ClicktalePlugin", "trackPageView", [pageName]);
};

exports.startHidingScreen = function(success, error) {
    exec(success, error, "ClicktalePlugin", "startHidingScreen", []);
};

exports.stopHidingScreen = function(success, error) {
    exec(success, error, "ClicktalePlugin", "stopHidingScreen", []);
};

exports.pauseScreenRecording = function(success, error) {
    exec(success, error, "ClicktalePlugin", "pauseScreenRecording", []);
};

exports.resumeScreenRecording = function(success, error) {
    exec(success, error, "ClicktalePlugin", "resumeScreenRecording", []);
};

exports.getSessionLink = function(success, error) {
    exec(success, error, "ClicktalePlugin", "getSessionLink", []);
};

exports.setCrashReporterOff = function(success, error) {
    exec(success, error, "ClicktalePlugin", "setCrashReporterOff", []);
};
