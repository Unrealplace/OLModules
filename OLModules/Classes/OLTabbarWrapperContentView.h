//
//  OLTabbarWrapperContentView.h
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OLTabbarWrapper.h"

@interface OLTabbarWrapperContentView : UIControl

@property (nonatomic,strong,readonly) UIVisualEffectView *backgroundView;
@property (nonatomic,strong,readonly) OLTabbarWrapper *wrapper;

@property (nonatomic,copy) void (^ wrapperTapedHandler)(void);

/**
 自定义控件的尺寸
 如果控件宽度为‘0’, 则这个控件的宽度与其他同为‘0’宽度的控件平分剩余的宽度
 如果控件高度为‘0’, 则这个控件的高度与‘Tabbar’的高度相同
 */
@property (nonatomic) CGSize wrapperSize;

/**
 自定义控件中的图片尺寸
 */
@property (nonatomic) CGSize wrapperImageSize;

/**
 设置实例的部分边上的圆弧半径
 适用于特殊的形状，例如只有左右上半部分两边有圆弧，而下班部分没有
 */
- (void)resetCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;
- (void)resetContentCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;

/**
 设置实例的不同状态下的图片与文字
 如果文字不存在, 则图片会充满整个控件
 图片可以是NSString或者UIImage格式
 */
- (void)setWrapperImage:(id)image withText:(NSString *)text controlState:(OLTabbarWrapperState)state;

/**
 设置实例的不同状态下的字体的样式
 默认字体大小‘12’
 */
- (void)setWrapperTextAttributes:(NSDictionary *)attributes controlState:(OLTabbarWrapperState)state;

/**
 设置实例的不同状态下的背景颜色
 */
- (void)setWrapperBackgroundColor:(UIColor *)backgroundColor controlState:(OLTabbarWrapperState)state;

- (void)setWrapperBadgeViewValue:(NSInteger)badgeValue;
- (void)setWrapperBadgeViewSize:(CGSize)size;
- (void)setWrapperBadgeEdgeInsets:(UIEdgeInsets)edgeInsets;
- (void)setWrapperBadgeViewType:(OLTabbarBadgeType)type;
@end

