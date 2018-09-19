package com.xlx.shuGe;

import android.Manifest;
import android.os.Bundle;
import android.provider.SyncStateContract;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.qq.e.ads.interstitial.AbstractInterstitialADListener;
import com.qq.e.ads.interstitial.InterstitialAD;
import com.qq.e.ads.splash.SplashAD;
import com.qq.e.ads.splash.SplashADListener;
import com.qq.e.comm.util.AdError;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;



public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "xlx.flutter.io/adnet";

  InterstitialAD iad;

  private SplashAD splashAD;
  private ViewGroup container;
  private TextView skipView;
  private ImageView splashHolder;



  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    System.out.print("start application");
    GeneratedPluginRegistrant.registerWith(this);

      checkAndRequestPermission();

        //平台通道
      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                // TODO
                if (call.method.equals("loadInterstitialObj")) {
                    getIad().loadAD();
                } else if(call.method.equals("showInterstitialObj")){
                    getIad().show();
                }else{
                }
              }
            });
  }
    InterstitialAD getIad(){
      if (iad == null){
          iad = new InterstitialAD(this,"1101152570", "8575134060152130849");
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
              }
          });
      }
      return iad;
  }
    private void checkAndRequestPermission() {
        List<String> lackedPermission = new ArrayList<String>();
//    if (!(checkSelfPermission(Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED)) {
        lackedPermission.add(Manifest.permission.READ_PHONE_STATE);
//    }

//    if (!(checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED)) {
        lackedPermission.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
//    }

//    if (!(checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED)) {
        lackedPermission.add(Manifest.permission.ACCESS_FINE_LOCATION);
//    }

        // 权限都已经有了，那么直接调用SDK
        if (lackedPermission.size() == 0) {
            iad = new InterstitialAD(this,"1101152570", "8575134060152130849");

        } else {
            // 请求所缺少的权限，在onRequestPermissionsResult中再看是否获得权限，如果获得权限就可以调用SDK，否则不要调用SDK。
            String[] requestPermissions = new String[lackedPermission.size()];
            lackedPermission.toArray(requestPermissions);
//      requestPermissions(requestPermissions, 1024);
        }
    }






}
