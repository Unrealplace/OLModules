//
//  OLNavigationBar.h
//  OLModule_Example
//
//  Created by LiYang on 2019/5/21.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OLNavigationBar : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSDictionary *titleAttributes;

@property (nonatomic,strong,readwrite) UIView *centeralNavigationView;
@property (nonatomic,strong,readwrite) NSArray *leftNavigationBarButtons;
@property (nonatomic,strong,readwrite) NSArray *rightNavigationBarButtons;

- (void)showCentralView;
- (void)hideCentralView;

@end

NS_ASSUME_NONNULL_END
