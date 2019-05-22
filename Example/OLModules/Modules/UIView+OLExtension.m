//
//  UIView+OLExtension.m
//  OLModule_Example
//
//  Created by LiYang on 2019/5/20.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "UIView+OLExtension.h"

@implementation UIView (OLExtension)


- (void)setOl_x:(CGFloat)ol_x{
    CGRect frame = self.frame;
    frame.origin.x = ol_x;
    self.frame = frame;
}

- (CGFloat)ol_x
{
    return self.frame.origin.x;
}

- (void)setOl_y:(CGFloat)ol_y {
    CGRect frame = self.frame;
    frame.origin.y = ol_y;
    self.frame = frame;
}

- (CGFloat)ol_y
{
    return self.frame.origin.y;
}

- (void)setOl_centerX:(CGFloat)ol_centerX {
    CGPoint center = self.center;
    center.x = ol_centerX;
    self.center = center;
}


- (CGFloat)ol_centerX
{
    return self.center.x;
}

- (void)setOl_centerY:(CGFloat)ol_centerY {
    CGPoint center = self.center;
    center.y = ol_centerY;
    self.center = center;
}

- (CGFloat)ol_centerY
{
    return self.center.y;
}

- (void)setOl_width:(CGFloat)ol_width {
    CGRect frame = self.frame;
    frame.size.width = ol_width;
    self.frame = frame;
}

- (CGFloat)ol_width
{
    return self.frame.size.width;
}

- (void)setOl_height:(CGFloat)ol_height
{
    CGRect frame = self.frame;
    frame.size.height = ol_height;
    self.frame = frame;
}

- (CGFloat)ol_height
{
    return self.frame.size.height;
}

- (void)setOl_size:(CGSize)ol_size
{
    CGRect frame = self.frame;
    frame.size = ol_size;
    self.frame = frame;
}

- (CGSize)ol_size
{
    return self.frame.size;
}

@end
