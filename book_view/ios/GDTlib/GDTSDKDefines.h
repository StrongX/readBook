//
//  GDTSDKDefines.h
//  GDTMobApp
//
//  Created by royqpwang on 2017/11/6.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined(__has_attribute)
#if __has_attribute(deprecated)
#define GDT_DEPRECATED_MSG_ATTRIBUTE(s) __attribute__((deprecated(s)))
#define GDT_DEPRECATED_ATTRIBUTE __attribute__((deprecated))
#else
#define GDT_DEPRECATED_MSG_ATTRIBUTE(s)
#define GDT_DEPRECATED_ATTRIBUTE
#endif
#else
#define GDT_DEPRECATED_MSG_ATTRIBUTE(s)
#define GDT_DEPRECATED_ATTRIBUTE
#endif

#define IS_IPHONEX (([[UIScreen mainScreen] nativeBounds].size.height-2436)?NO:YES)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
