package com.clicktale.cordova;

import android.util.Log;

import com.clicktale.clicktalesdk.Clicktale;
import com.clicktale.clicktalesdk.ClicktaleCallback;
import com.clicktale.clicktalesdk.Region;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class ClicktalePlugin extends CordovaPlugin implements ClicktaleCallback {
    private static final String TAG = "clicktale-plugin";

    private static final int ERROR_CODE_UNKNOWN_ERROR = -1;
    private static final int ERROR_CODE_INVALID_ARGS = -2;
    private boolean isDestroyed;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        android.util.Log.d(TAG, "execute() called with: " + "action = [" + action + "], args = [" + args + "], callbackContext = [" + callbackContext + "]");
        try {

            switch (action) {

                case "start":
                    this.start(args, callbackContext);
                    return true;
                case "pauseScreenRecording":
                    this.pauseScreenRecording(args, callbackContext);
                    return true;
                case "resumeScreenRecording":
                    this.resumeScreenRecording(args, callbackContext);
                    return true;
                case "isScreenRecording":
                    this.isScreenRecording(callbackContext);
                    return true;
                case "startPageView":
                    this.startPageView(args, callbackContext);
                    return true;
                case "addDynamicAction":
                    this.addDynamicAction(args, callbackContext);
                    return true;
                case "blockScreenRecording":
                    this.blockScreenRecording(callbackContext);
                    return true;
                case "unblockScreenRecording":
                    this.unblockScreenRecording(callbackContext);
                    return true;
                case "isScreenRecordingBlocked":
                    this.isScreenRecordingBlocked(callbackContext);
                    return true;
                case "optOut":
                    this.setOptOut(true, callbackContext);
                    return true;
                case "optIn":
                    this.setOptOut(false, callbackContext);
                    return true;
                case "isOptOut":
                    this.isOptOut(callbackContext);
                    return true;
                case "getVisitLink":
                    this.getVisitLink(callbackContext);
                    return true;
                case "getVisitorId":
                    this.getVisitorId(callbackContext);
                    return true;
                case "getVisitId":
                    this.getVisitId(callbackContext);
                    return true;
                case "setDebugMode":
                    this.setDebugMode(args, callbackContext);
                    return true;
                case "saveVideoToDevice":
                    this.saveVideoToDevice(args, callbackContext);
                    return true;

                case "useOSLogging":

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
            long projectId = args.optLong(1);
            long applicationId = args.optLong(2);

            Region region = Region.EUROPE.name().equals(args.optString(0)) ? Region.EUROPE :
                    Region.US.name().equals(args.optString(0)) ? Region.US : null;

            if (region == null) {
                android.util.Log.w(TAG, "Error starting Clicktale with Region: " + String.valueOf(args.optString(0)));
                return;
            }

            if (projectId == 0 || applicationId == 0) {
                android.util.Log.w(TAG, "Error starting Clicktale with applictionId: " + String.valueOf(applicationId) + "and projectId: " + String.valueOf(projectId));
                return;
            }

            Clicktale.start(region, projectId, applicationId);
            Clicktale.addClicktaleCallback(ClicktalePlugin.this);
            callbackContext.success();
        } catch (Exception e) {
            e.printStackTrace();
            callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
        }
    }

    private void setDebugMode(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    boolean devMode = args.optBoolean(0);
                    Clicktale.setDebugMode(devMode);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void saveVideoToDevice(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    boolean videoTest = args.optBoolean(0);
                    Clicktale.saveVideoToDevice(videoTest);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void addDynamicAction(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    String actionName = args.optString(0, null);

                    if (actionName == null) {
                        Log.e(TAG, "addDynamicAction: invalid actionName name");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.addDynamicAction(actionName);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void startPageView(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    String pageName = args.optString(0, null);
                    String pageTitle = args.optString(1, null);

                    if (pageName == null) {
                        Log.e(TAG, "startPageView: invalid page name");
                        callbackContext.error(ERROR_CODE_INVALID_ARGS);
                        return;
                    }

                    Clicktale.startPageView(pageName, pageTitle);
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void blockScreenRecording(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.blockScreenRecording();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void unblockScreenRecording(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.unblockScreenRecording();
                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void pauseScreenRecording(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
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
        cordova.getActivity().runOnUiThread(new Runnable() {
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

    private void isScreenRecording(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, Clicktale.isScreenRecording()));
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void isScreenRecordingBlocked(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, Clicktale.isScreenRecordingBlocked()));
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void getVisitLink(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    String link = Clicktale.getVisitLink();
                    callbackContext.success(link);
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void getVisitorId(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    long visitorId = Clicktale.getVisitorId();
                    String id = String.valueOf(visitorId);
                    callbackContext.success(id);
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void getVisitId(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    String id = String.valueOf(Clicktale.getVisitId());
                    callbackContext.success(id);
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void setOptOut(final boolean isOptOut, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    Clicktale.setOptOutState(isOptOut);

                    if (!isOptOut) {
                        Clicktale.addClicktaleCallback(ClicktalePlugin.this);
                    }

                    callbackContext.success();
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    private void isOptOut(final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, Clicktale.getOptOutState()));
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackContext.error(ERROR_CODE_UNKNOWN_ERROR);
                }
            }
        });
    }

    @Override
    public void onStart() {
        isDestroyed = false;
    }

    @Override
    public void onDestroy() {
        isDestroyed = true;
    }

    @Override
    public void visitStartedSuccessfully(String visitLink, long visitId) {
        if (visitLink == null || isDestroyed) {
            return;
        }
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("visitLink", visitLink);
        map.put("visitId", String.valueOf(visitId));
        JSONObject _json = new JSONObject(map);

        final String json = _json.toString();
        webView.getView().post(new Runnable() {
            public void run() {
                webView.loadUrl("javascript:cordova.fireDocumentEvent('visitStartedSuccessfully'," + json + ");");
            }
        });
    }

    @Override
    public void visitFailed() {
        webView.getView().post(new Runnable() {
            public void run() {
                webView.loadUrl("javascript:cordova.fireDocumentEvent('visitFailed', {});");
            }
        });
    }

    @Override
    public void visitEnded(long visitId) {
        if (isDestroyed) {
            return;
        }
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("visitId", String.valueOf(visitId));
        JSONObject _json = new JSONObject(map);

        final String json = _json.toString();
        webView.getView().post(new Runnable() {
            public void run() {
                webView.loadUrl("javascript:cordova.fireDocumentEvent('visitEnded'," + json + ");");
            }
        });
    }
}

