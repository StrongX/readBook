import 'package:flutter/services.dart';

class AdNet{
  static const platform = const MethodChannel('xlx.flutter.io/adnet');
  static load()async{
    await platform.invokeMethod('loadInterstitialObj');

  }
  static show()async{
    await platform.invokeMethod('showInterstitialObj');
  }
}