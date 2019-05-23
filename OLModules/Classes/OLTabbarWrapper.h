//
//  OLTabbarWraper.h
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , OLTabbarBadgeType)
{
    //显示具体的数字
    OLTabbarBadgeTypeNumber = 0,
    //只显示纯色
    OLTabbarBadgeTypeColor = 1,
};

typedef NS_ENUM(NSInteger , OLTabbarWrapperState)
{
    OLTabbarWrapperStateNormal = 0,
    OLTabbarWrapperStateHighlight = 1 << 0,
    OLTabbarWrapperStateDisable = 1 << 1,
    OLTabbarWrapperStateSelected = 1 << 2,
};

#define OLTWStringify(x) #x

static inline NSString* OLTabbarWrapperStateString(OLTabbarWrapperState state)
{
#define OLTWCASE(x) case OLTabbarWrapperState ## x : return @OLTWStringify(OLTabbarWrapperState ## x ## Key);
    switch (state) {
            OLTWCASE(Normal);
            OLTWCASE(Highlight);
            OLTWCASE(Disable);
            OLTWCASE(Selected);
    }
#undef OLTWCASE
}

@interface OLTabbarWrapper : UIControl

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
 角标相关
 badgeSize：角标的尺寸，默认大小为CGSizeMake(18,18)
 badgeEdgeInsets：角标的内边距，默认大小为UIEdgeInset(5,0,0,5)
 badgeAttributes：当角标类型为时，角标的属性，默认为 ‘白色’, ‘14号字体’
 */
@property (nonatomic) OLTabbarBadgeType badgeType;
@property (nonatomic,strong) UIColor *badgeFillColor;
@property (nonatomic) CGSize badgeSize;
@property (nonatomic) UIEdgeInsets badgeEdgeInsets;
@property (nonatomic,strong) NSDictionary *badgeAttributes;
- (void)resetWrapperBadgeValue:(NSInteger)badgeValue;

/**
 设置实例的部分边上的圆弧半径
 适用于特殊的形状，例如只有左右上半部分两边有圆弧，而下班部分没有
 */
- (void)resetCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;

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

@end

NS_ASSUME_NONNULL_END
