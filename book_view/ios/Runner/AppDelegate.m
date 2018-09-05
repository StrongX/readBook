#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

NSString * const gdtAppId = @"1107804384";


@implementation AppDelegate
{
    GDTMobInterstitial *_interstitialObj;
    GDTSplashAd *splash;
}
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    FlutterViewController *vc = [FlutterViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* adnetChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"xlx.flutter.io/adnet"
                                            binaryMessenger:controller];
    
    [adnetChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        if ([call.method isEqualToString:@"loadInterstitialObj"]) {
            [self loadInterstitialObj];
        }
        if ([call.method isEqualToString:@"showInterstitialObj"]) {
            [self showInterstitialObj];
        }
        
    }];
    
    
    _interstitialObj = [[GDTMobInterstitial alloc]initWithAppId:gdtAppId placementId:@"7020638951313258"];
    _interstitialObj.delegate = self; //设置委托
    _interstitialObj.isGpsOn = NO; //【可选】设置GPS开关
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //开屏广告
        //开屏广告初始化并展示代码
        splash = [[GDTSplashAd alloc] initWithAppId:gdtAppId placementId:@"1090234941828184"];
        splash.delegate = self; //设置代理
        UIImage *splashImage = [UIImage imageNamed:@"SplashNormal"];
        if (IS_IPHONEX) {
            splashImage = [UIImage imageNamed:@"SplashX"];
        } else if ([UIScreen mainScreen].bounds.size.height == 480) {
            splashImage = [UIImage imageNamed:@"SplashSmall"];
        }
        splash.backgroundImage = splashImage;
        splash.fetchDelay = 3; //开发者可以设置开屏拉取时间，超时则放弃展示
        //［可选］拉取并展示全屏开屏广告
        [splash loadAdAndShowInWindow:self.window];

    }
    
    
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void)showInterstitialObj{
    [_interstitialObj presentFromRootViewController:self.window.rootViewController];

}
-(void)loadInterstitialObj{
    [_interstitialObj loadAd];
}
////////////////////////////查屏广告回调
//广告预加载成功回调
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}
// 广告预加载失败回调
-(void)interstitialFailToLoadAd:(GDTMobInterstitial *)interstitial error:(NSError *)error{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
    NSLog(@"error:%@",error);
}
// 插屏广告将要展示回调
- (void)interstitialWillPresentScreen:(GDTMobInterstitial *)interstitial{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}
// 插屏广告视图展示成功回调
- (void)interstitialDidPresentScreen:(GDTMobInterstitial *)interstitial{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}

////////////////////////全屏广告回调
//开屏广告成功展示
-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}
//开屏广告展示失败
-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
    splash = nil;
}
//应用进入后台时回调
- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}
//开屏广告点击回调
- (void)splashAdClicked:(GDTSplashAd *)splashAd{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
}
//开屏广告关闭回调
- (void)splashAdClosed:(GDTSplashAd *)splashAd{
    NSLog(@"cmd:%@",NSStringFromSelector(_cmd));
    splash = nil;

}
@end
