//
//  OLTabbarWrapperContentView.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTabbarWrapperContentView.h"
#import "Masonry.h"

@implementation OLTabbarWrapperContentView

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    //    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //    _backgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //    [self addSubview:_backgroundView];
    //    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self);
    //    }];
    
    _wrapper = [[OLTabbarWrapper alloc] init];
    [self addSubview:_wrapper];
    [_wrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)resetContentCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners
{
    CGRect rect = CGRectMake(0, 0, _wrapperSize.width, _wrapperSize.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = rect;
    mask.path = maskPath.CGPath;
    _backgroundView.layer.mask = mask;
    _backgroundView.clipsToBounds = YES;
}

- (void)setWrapperSize:(CGSize)wrapperSize
{
    _wrapperSize = wrapperSize;
    _wrapper.wrapperSize = wrapperSize;
}

- (void)setWrapperImageSize:(CGSize)wrapperImageSize
{
    _wrapperImageSize = wrapperImageSize;
    _wrapper.wrapperImageSize = wrapperImageSize;
}

- (void)resetCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners
{
    [_wrapper resetCornerRadius:cornerRadius corners:corners];
}

- (void)setWrapperImage:(id)image withText:(NSString *)text controlState:(OLTabbarWrapperState)state
{
    [_wrapper setWrapperImage:image withText:text controlState:state];
}

- (void)setWrapperTextAttributes:(NSDictionary *)attributes controlState:(OLTabbarWrapperState)state
{
    [_wrapper setWrapperTextAttributes:attributes controlState:state];
}

- (void)setWrapperBackgroundColor:(UIColor *)backgroundColor controlState:(OLTabbarWrapperState)state
{
    [_wrapper setWrapperBackgroundColor:backgroundColor controlState:state];
}

- (void)setWrapperBadgeViewValue:(NSInteger)badgeValue
{
    [_wrapper resetWrapperBadgeValue:badgeValue];
}

- (void)setWrapperBadgeViewSize:(CGSize)size
{
    [_wrapper setBadgeSize:size];
}

- (void)setWrapperBadgeEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [_wrapper setBadgeEdgeInsets:edgeInsets];
}

- (void)setWrapperBadgeViewType:(OLTabbarBadgeType)type
{
    [_wrapper setBadgeType:type];
}


@end
