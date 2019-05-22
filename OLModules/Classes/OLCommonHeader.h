//
//  OLCommonHeader.h
//  OLModule
//
//  Created by LiYang on 2019/5/20.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#ifndef OLCommonHeader_h
#define OLCommonHeader_h

#import "UIView+OLExtension.h"

//1. 日志输出宏定义
#ifdef DEBUG
// 调试状态
#define PGString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define PGLog(...) printf("%s: %s 第%d行: %s\n\n",__TIME__, [PGString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
// 发布状态
#define PGLog(...)
#endif

//颜色相关
#define kGlobalBg HexColor(0xF9F9F9)//背景色
#define kGlobalTintColor HexColor(0x2088FF)//主题色
#define kNavigationTitleColor HexColor(0x282828)//导航标题色
#define kPlaceholderTextColor HexColor(0x999999)//文本输入框占位文字颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r, g, b) RGBAColor(r,g,b,1.0)
#define kGlobalDividerColor HexColor(0xE4E4E4)//分割线颜色
#define kGlobalCellSelectedBg RGBAColor(237, 233, 218, 0.2)//cell选中状态背景色
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]




//字体
#define kGlobalRegularFont @"PingFangSC-Regular"
#define kGlobalMediumFont @"PingFangSC-Medium"



//动画时间
#define kAnimateTime 0.25

#define isIphoneX (kStatusBarHeight > 20)//iphonex系列手机判断

//经纬度
#define kCurrentLat
#define kCurrentLon
#define MyLat @""
#define MyLon @""

// 定义高度
#define kSignleHeight 1/[[UIScreen mainScreen] scale]
#define kScreenAdjustWidthValue(x) [UIScreen mainScreen].bounds.size.width / 375.0f * x
#define kScreenAdjustHeightValue(x) [UIScreen mainScreen].bounds.size.height / 667.0f * x

#define kUIScreenSize [UIScreen mainScreen].bounds.size
#define kUIScreenWidth kUIScreenSize.width
#define kUIScreenHeight (kUIScreenSize.height - (kSafeBottomHeight))
#define kSafeBottomHeight (isIphoneX ? 34:0)

#define kGlobalHeight kUIScreenSize.height

// 弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabbarHeight 49.0
#define kNavigationBarHeight (kStatusBarHeight + kNavBarHeight)
#define kBottomHeight (kStatusBarHeight > 20 ? 34:0)



#endif /* OLCommonHeader_h */
