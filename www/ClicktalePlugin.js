
/**
 * ClicktalePlugin.js
 *
 * Clicktale Cordova plugin.
 *
 */

var exec = require('cordova/exec');

//region types
exports.REGION_EUROPE = "EUROPE";
exports.REGION_US = "US";

exports.start = function (region, projectId, applicationId, success, error) {
    exec(success, error, "ClicktalePlugin", "start", [region, projectId, applicationId]);
};


exports.pauseScreenRecording = function (success, error) {
    exec(success, error, "ClicktalePlugin", "pauseScreenRecording", []);
};


exports.resumeScreenRecording = function (success, error) {
    exec(success, error, "ClicktalePlugin", "resumeScreenRecording", []);
};


exports.isScreenRecording = function (success, error) {
    exec(success, error, "ClicktalePlugin", "isScreenRecording", []);
};


exports.startPageView = function (pageName, pageTitle, success, error) {
    exec(success, error, "ClicktalePlugin", "startPageView", [pageName, pageTitle]);
};


exports.addDynamicAction = function (actionName, success, error) {
    exec(success, error, "ClicktalePlugin", "addDynamicAction", [actionName]);
};


exports.blockScreenRecording = function (success, error) {
    exec(success, error, "ClicktalePlugin", "blockScreenRecording", []);
};


exports.unblockScreenRecording = function (success, error) {
    exec(success, error, "ClicktalePlugin", "unblockScreenRecording", []);
};


exports.isScreenRecordingBlocked = function (success, error) {
    exec(success, error, "ClicktalePlugin", "isScreenRecordingBlocked", []);
};


exports.optOut = function (success, error) {
    exec(success, error, "ClicktalePlugin", "optOut", []);
};


exports.optIn = function (success, error) {
    exec(success, error, "ClicktalePlugin", "optIn", []);
};


exports.isOptOut = function (success, error) {
    exec(success, error, "ClicktalePlugin", "isOptOut", []);
};


exports.getVisitLink = function (success, error) {
    exec(success, error, "ClicktalePlugin", "getVisitLink", []);
};


exports.getVisitorId = function (success, error) {
    exec(success, error, "ClicktalePlugin", "getVisitorId", []);
};


exports.getVisitId = function (success, error) {
    exec(success, error, "ClicktalePlugin", "getVisitId", []);
};


exports.setDebugMode = function (enabled, success, error) {
    exec(success, error, "ClicktalePlugin", "setDebugMode", [enabled]);
};


exports.saveVideoToDevice = function (enabled, success, error) {
    exec(success, error, "ClicktalePlugin", "saveVideoToDevice", [enabled]);
};

exports.useOSLogging = function (enabled, success, error) {
    exec(success, error, "ClicktalePlugin", "useOSLogging", [enabled]);
};


