package com.clicktale.cordova;

import android.util.Log;

import com.clicktale.clicktalesdk.Clicktale;
import com.clicktale.clicktalesdk.ClicktaleCallback;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class ClicktalePlugin extends CordovaPlugin implements ClicktaleCallback {
    private static final String TAG = "clicktale-plugin";

    private static final int ERROR_CODE_UNKNOWN_ERROR = -1;
    private static final int ERROR_CODE_INVALID_ARGS = -2;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        android.util.Log.d(TAG, "execute() called with: " + "action = [" + action + "], args = [" + args + "], callbackContext = [" + callbackContext + "]");
        try {
            if (action.equals("startClicktale")) {
                this.start(args, callbackContext);
                return true;
            } else if (action.equals("setDebugLogLevelOn")) {
                this.setDevMode(args, callbackContext);
                return true;
            } else if (action.equals("setVideoTestMode")) {
                this.setVideoTestMode(args, callbackContext);
                return true;
            } else if (action.equals("setSessionUserID")) {
                this.setUserID(args, callbackContext);
                return true;
            } else if (action.equals("trackEvent")) {
                this.logEvent(args, callbackContext);
                return true;
            } else if (action.equals("trackEventAndValue")) {
                this.logEventAndValue(args, callbackContext);
                return true;
            } else if (action.equals("trackPageView")) {
                this.logPageView(args, callbackContext);
                return true;
            } else if (action.equals("startHidingScreen")) {
                this.startHidingScreen(args, callbackContext);
                return true;
            } else if (action.equals("stopHidingScreen")) {
                this.stopHidingScreen(args, callbackContext);
                return true;
            } else if (action.equals("pauseScreenRecording")) {
                this.pauseScreenRecording(args, callbackContext);
                return true;
            } else if (action.equals("resumeScreenRecording")) {
                this.resumeScreenRecording(args, callbackContext);
                return true;
            } else if (action.equals("getSessionLink")) {
                this.getSessionLink(args, callbackContext);
                return true;
            } else if (action.equals("setCrashReporterOff")) {
                this.setCrashReporterOff(args, callbackContext);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
        }

        return false;
    }

    private void start(final JSONArray args, final CallbackContext callbackContext) {
        try {
            String accessKey = args.optString(0, null);
            String secretKey = args.optString(1, null);

            if (accessKey == null || secretKey == null) {
                Log.e(TAG, "start: invalid access key or secret key");
                callbackContext.error(ERROR_CODE_INVALID_ARGS);
                return;
            }
            Clicktale.start(ClicktalePlugin.this.cordova.getActivity(), this, accessKey, secretKey);
            callbackContext.success();
        } catch (Exception e) {
            e.printStackTrace();
            callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
        }
    }


    private void setDevMode(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    boolean devMode = args.optBoolean(0);
                    Clicktale.setDevMode(devMode);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void setVideoTestMode(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    boolean videoTest = args.optBoolean(0);
                    Clicktale.setVideoTestMode(videoTest);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void setUserID(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String userId = args.optString(0, null);

                    if (userId == null) {
                        Log.e(TAG, "setSessionUserID: invalid user ID");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.setUsedId(userId);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void logEvent(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String event = args.optString(0, null);

                    if (event == null) {
                        Log.e(TAG, "logEvent: invalid event name");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.logEvent(event);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void logEventAndValue(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String event = args.optString(0, null);
                    String value = args.optString(1, null);

                    if (event == null || value == null) {
                        Log.e(TAG, "logEvent: invalid event name or event value");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.logEvent(event, value);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void logPageView(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String pageName = args.optString(0, null);

                    if (pageName == null) {
                        Log.e(TAG, "trackPageView: invalid page name");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.logPageView(pageName);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void startHidingScreen(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.startHidingScreen();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void stopHidingScreen(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.stopHidingScreen();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void pauseScreenRecording(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.pauseScreenRecording();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void resumeScreenRecording(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.resumeScreenRecording();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void getSessionLink(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String link = Clicktale.getSessionLink();
                    callbackContext.success(link);
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void setCrashReporterOff(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.setCrashReporterOff();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    @Override
    public void onSessionURLCreated(String sessionLink) {
        if (sessionLink == null) {
            return;
        }
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("URL", sessionLink);
        JSONObject _json = new JSONObject(map);

        final String json = _json.toString();
        webView.getView().post(new Runnable() {
            public void run() {
                webView.loadUrl("javascript:cordova.fireDocumentEvent('onClicktaleSessionURLCreated'," + json + ");");
            }
        });
    }

    @Override
    public void onSessionIDCreated(String sessionID) {
        if (sessionID == null) {
            return;
        }
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("SessionID", sessionID);
        JSONObject _json = new JSONObject(map);

        final String json = _json.toString();
        webView.getView().post(new Runnable() {
            public void run() {
                webView.loadUrl("javascript:cordova.fireDocumentEvent('onClicktaleSessionIDCreated'," + json + ");");
            }
        });
    }

}

