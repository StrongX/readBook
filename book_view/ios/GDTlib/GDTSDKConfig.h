//
//  GDTSDKConfig.h
//  GDTMobApp
//
//  Created by GaoChao on 14/8/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDTSDKDefines.h"

@interface GDTSDKConfig : NSObject
/**
 * 提供给聚合平台用来设定SDK 流量分类
 */
+ (void)setSdkSrc:(NSString *)sdkSrc;

/**
 * 查看SDK流量来源
 */
+ (NSString *)sdkSrc;



/**
 * 获取 SDK 版本
 */

+ (NSString *)sdkVersion;



#pragma mark - DEPRECATED

/**
 *  打开HTTPS开关
 *  详解：默认提供 HTTPS 资源，此方法废弃，请尽早删除。
 *
 */
+ (void)setHttpsOn GDT_DEPRECATED_MSG_ATTRIBUTE("");

@end
