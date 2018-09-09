package com.example.demo;

import android.os.Bundle;
import android.util.Log;

import com.qq.e.ads.interstitial.AbstractInterstitialADListener;
import com.qq.e.ads.interstitial.InterstitialAD;
import com.qq.e.comm.util.AdError;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;



public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "xlx.flutter.io/adnet";

  InterstitialAD iad;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    iad = new InterstitialAD(this,"1101152570", "8575134060152130849");

    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                // TODO
                if (call.method.equals("loadInterstitialObj")) {
                    iad.setADListener(new AbstractInterstitialADListener() {

                        @Override
                        public void onNoAD(AdError error) {
                            Log.i(
                                    "AD_DEMO",
                                    String.format("LoadInterstitialAd Fail, error code: %d, error msg: %s",
                                            error.getErrorCode(), error.getErrorMsg()));
                        }

                        @Override
                        public void onADReceive() {
                            Log.i("AD_DEMO", "onADReceive");
                            iad.show();
                        }
                    });
                    iad.loadAD();

                } else if(call.method.equals("showInterstitialObj")){
                    iad.setADListener(new AbstractInterstitialADListener() {

                        @Override
                        public void onNoAD(AdError error) {
                            Log.i(
                                    "AD_DEMO",
                                    String.format("LoadInterstitialAd Fail, error code: %d, error msg: %s",
                                            error.getErrorCode(), error.getErrorMsg()));
                        }

                        @Override
                        public void onADReceive() {
                            iad.showAsPopupWindow();
                        }
                    });
                    iad.loadAD();
                }else{
                }
              }
            });
  }
}
