//
//  UIView+OLExtension.h
//  OLModule_Example
//
//  Created by LiYang on 2019/5/20.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (OLExtension)

@property (nonatomic, assign) CGFloat ol_x;
@property (nonatomic, assign) CGFloat ol_y;
@property (nonatomic, assign) CGFloat ol_centerX;
@property (nonatomic, assign) CGFloat ol_centerY;
@property (nonatomic, assign) CGFloat ol_width;
@property (nonatomic, assign) CGFloat ol_height;
@property (nonatomic, assign) CGSize  ol_size;

@end

NS_ASSUME_NONNULL_END
