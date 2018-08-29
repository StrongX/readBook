//
//  GDTNativeExpressAd.h
//  GDTMobApp
//
//  Created by michaelxing on 2017/4/17.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GDTSDKDefines.h"

/**
 *  视频模板广告播放器状态
 *
 *  播放器只可能处于以下状态中的一种
 *
 */
typedef NS_ENUM(NSUInteger, GDTMediaPlayerStatus) {
    GDTMediaPlayerStatusInitial = 0,         // 初始状态
    GDTMediaPlayerStatusLoading = 1,         // 加载中
    GDTMediaPlayerStatusStarted = 2,         // 开始播放
    GDTMediaPlayerStatusPaused = 3,          // 用户行为导致暂停
    GDTMediaPlayerStatusStoped = 4,          // 播放停止
    GDTMediaPlayerStatusError = 5,           // 播放出错
};

@class GDTNativeExpressAdView;
@class GDTNativeExpressAd;

@protocol GDTNativeExpressAdDelegete <NSObject>

@optional
/**
 * 拉取原生模板广告成功
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views;

/**
 * 拉取原生模板广告失败
 */
- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error;

/**
 * 原生模板广告渲染成功, 此时的 nativeExpressAdView.size.height 根据 size.width 完成了动态更新。
 */
- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告渲染失败
 */
- (void)nativeExpressAdViewRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告曝光回调
 */
- (void)nativeExpressAdViewExposure:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告点击回调
 */
- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告被关闭
 */
- (void)nativeExpressAdViewClosed:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 点击原生模板广告以后即将弹出全屏广告页
 */
- (void)nativeExpressAdViewWillPresentScreen:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 点击原生模板广告以后弹出全屏广告页
 */
- (void)nativeExpressAdViewDidPresentScreen:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 全屏广告页将要关闭
 */
- (void)nativeExpressAdViewWillDissmissScreen:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 全屏广告页将要关闭
 */
- (void)nativeExpressAdViewDidDissmissScreen:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告点击之后应用进入后台时回调
 */
- (void)nativeExpressAdViewApplicationWillEnterBackground:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板视频广告 player 播放状态更新回调
 */
- (void)nativeExpressAdView:(GDTNativeExpressAdView *)nativeExpressAdView playerStatusChanged:(GDTMediaPlayerStatus)status;

/**
 * 原生视频模板详情页 WillPresent 回调
 */
- (void)nativeExpressAdViewWillPresentVideoVC:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生视频模板详情页 DidPresent 回调
 */
- (void)nativeExpressAdViewDidPresentVideoVC:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生视频模板详情页 WillDismiss 回调
 */
- (void)nativeExpressAdViewWillDismissVideoVC:(GDTNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生视频模板详情页 DidDismiss 回调
 */
- (void)nativeExpressAdViewDidDismissVideoVC:(GDTNativeExpressAdView *)nativeExpressAdView;

@end

@interface GDTNativeExpressAd : NSObject

/**
 *  委托对象
 */
@property (nonatomic, weak) id<GDTNativeExpressAdDelegete> delegate;


/**
 *  非 WiFi 网络，是否自动播放。默认 NO。loadAd 前设置。
 */

@property (nonatomic, assign) BOOL videoAutoPlayOnWWAN;

/**
 *  自动播放时，是否静音。默认 YES。loadAd 前设置。
 */
@property (nonatomic, assign) BOOL videoMuted;

/**
 *  构造方法
 *  详解：appId - 媒体 ID
 *       placementId - 广告位 ID
 *       adSize - 广告展示的宽高
 */
- (instancetype)initWithAppId:(NSString *)appId placementId:(NSString *)placementId adSize:(CGSize)size;

- (void)loadAd:(NSInteger)count;

#pragma mark - DEPRECATED
- (instancetype)initWithAppkey:(NSString *)appkey placementId:(NSString *)placementId adSize:(CGSize)size GDT_DEPRECATED_MSG_ATTRIBUTE("use initWithAppId:placementId:adSize instead.");

@end
