//
//  GDTNativeAd.h
//  GDTMobApp
//
//  Created by GaoChao on 14/11/6.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "GDTSDKDefines.h"

extern NSString* const GDTNativeAdDataKeyTitle;
extern NSString* const GDTNativeAdDataKeyDesc;
extern NSString* const GDTNativeAdDataKeyIconUrl;
extern NSString* const GDTNativeAdDataKeyImgUrl;
extern NSString* const GDTNativeAdDataKeyAppRating;
extern NSString* const GDTNativeAdDataKeyAppPrice;
extern NSString* const GDTNativeAdDataKeyImgList;

@interface GDTNativeAdData : NSObject

/*
 *  广告内容字典
 *  详解：[必选]开发者调用LoadAd成功之后从该属性中获取广告数据
 *       广告数据以字典的形式存储，开发者目前可以通过如下键获取数据
 *          1. GDTNativeAdDataKeyTitle      标题
 *          2. GDTNativeAdDataKeyDesc       描述
 *          3. GDTNativeAdDataKeyIconUrl    图标Url
 *          4. GDTNativeAdDataKeyImgUrl     大图Url
 *          5. GDTNativeAdDataKeyAppRating  应用类广告的星级
 *          6. GDTNativeAdDataKeyAppPrice   应用类广告的价格
 *          7. GDTNativeAdDataKeyImgList    三小图广告的图片集合
 */
@property (nonatomic, retain, readonly) NSDictionary *properties;
/*
 *  判断两个原生广告数据对象是否相等
 */
- (BOOL)equalsAdData:(GDTNativeAdData *)data;
/*
 *  获取该原生广告是否为应用类广告
 */
- (BOOL)isAppAd;
/*
 *  获取该原生广告是否为三小图广告，当为三小图广告时，可以通过GDTNativeAdDataKeyImgList获取三张图片资源供渲染
 */
- (BOOL)isThreeImgsAd;

@end

@class GDTNativeAd;

@protocol GDTNativeAdDelegate <NSObject>

/**
 *  原生广告加载广告数据成功回调，返回为GDTNativeAdData对象的数组
 */
- (void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray;

/**
 *  原生广告加载广告数据失败回调
 */
- (void)nativeAdFailToLoad:(NSError *)error;

@optional
/**
 *  原生广告点击之后将要展示内嵌浏览器或应用内AppStore回调
 */
- (void)nativeAdWillPresentScreen;

/**
 *  原生广告点击之后应用进入后台时回调
 */
- (void)nativeAdApplicationWillEnterBackground;

/**
 * 原生广告点击以后，内置AppStore或是内置浏览器被关闭时回调
 */
- (void)nativeAdClosed;

@end

@interface GDTNativeAd : NSObject<SKStoreProductViewControllerDelegate>

/*
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 *  委托对象
 */
@property (nonatomic, weak) id<GDTNativeAdDelegate> delegate;

/**
 *  构造方法
 *  详解：appId - 媒体 ID
 *       placementId - 广告位 ID
 */
- (instancetype)initWithAppId:(NSString *)appId placementId:(NSString *)placementId;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求,在获得广告数据后回调delegate
 *  @param adCount 一次拉取广告的个数
 */
- (void)loadAd:(int)adCount;

/**
 *  广告数据渲染完毕即将展示时调用方法
 *  详解：[必选]广告数据渲染完毕，即将展示时需调用本方法。
 *      @param nativeAdData 广告渲染的数据对象
 *      @param view         渲染出的广告结果页面
 */
- (void)attachAd:(GDTNativeAdData *)nativeAdData toView:(UIView *)view;

/**
 *  广告点击调用方法
 *  详解：当用户点击广告时，开发者需调用本方法，系统会弹出内嵌浏览器、或内置AppStore、
 *      或打开系统Safari，来展现广告目标页面
 *      @param nativeAdData 用户点击的广告数据对象
 */
- (void)clickAd:(GDTNativeAdData *)nativeAdData;

#pragma mark - DEPRECATED
- (instancetype)initWithAppkey:(NSString *)appkey placementId:(NSString *)placementId GDT_DEPRECATED_MSG_ATTRIBUTE("use initWithAppId:placementId: instead.");

@end
