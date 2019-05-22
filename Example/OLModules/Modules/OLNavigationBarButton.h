//
//  OLNavigationBarButton.h
//  OLModule_Example
//
//  Created by LiYang on 2019/5/21.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 相对于标题的位置
// 如果没有标题则该属性无效
typedef NS_ENUM(NSInteger , OLPositionStyle)
{
    // 文字与图片居中
    OLPositionStyleCenter = 0,
    // 文字在左 图片在右
    OLPositionStyleLeft = 1,
    // 文字在下 图片在上
    OLPositionStyleBottom = 2,
    // 文字在右 图片在左
    OLPositionStyleRight = 3,
    // 文字在上 图片在下
    OLPositionStyleTop = 4,
};

@interface OLNavigationBarButton : UIControl

// 角标相关
@property (nonatomic,copy,readwrite) NSString *badgeValue;
@property (nonatomic,assign,readwrite) UIEdgeInsets offsetEdgeInsets; // 角标相对于右上角的偏移距离
@property (nonatomic,assign) UIEdgeInsets badgeAddingEdgeInsets; // 由于背景需要比文字大一些,额外增加的背景尺寸大小
@property (nonatomic,strong) NSDictionary *badgeAttributes; // 角标文字的绘制属性 默认9号字体,白色
@property (nonatomic,strong) UIColor *badgeBackgroundColor; // 角标背景颜色 默认为红色

- (void)setTitle:(NSString *)title forState:(UIControlState)controlState;
- (void)setImage:(UIImage *)image forState:(UIControlState)controlState;
- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)controlState;
- (void)setTextAttributes:(NSDictionary *)textAttributes forState:(UIControlState)controlState;
- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)controlState;
- (void)setTextFont:(UIFont *)textFont forState:(UIControlState)controlState;

@property (nonatomic) OLPositionStyle titlePositionType;
@property (nonatomic) UIEdgeInsets titleEdgeInsets;
@property (nonatomic) UIEdgeInsets imageEdgeInsets;
@property (nonatomic) UIEdgeInsets contentEdgeInsets;

// 计算大约的尺寸
- (CGSize)approximatelySize;


@end

NS_ASSUME_NONNULL_END
