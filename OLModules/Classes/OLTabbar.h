//
//  OLTabbar.h
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLTabbarWrapperContentView.h"

@protocol OLTabbarDelegate;

@interface OLTabbar : UIView

// 所有要使用的 wrapper item
@property (nonatomic,strong) NSArray<OLTabbarWrapperContentView *> *wrappers;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,weak) id<OLTabbarDelegate> delegate;


/**
 注册所有要使用的wrapper items 并设置代理
 */
+ (OLTabbar *)registWithWrappers:(NSArray *)wrappers forDelegate:(id)delegate;

// 设置完内部控件后，必须调用该方法刷新控件
- (void)reloadAllWrappers;

- (void)selectAtIndex:(NSInteger)index;

@end

@protocol OLTabbarDelegate <NSObject>

@optional;

/**
 单击一个item的代理方法
 */
- (BOOL)tabbar:(OLTabbar *)aTabbar wrapperClickedAtIndex:(NSInteger)index;

/**
 双击一个item的代理方法
 */
- (void)tabbar:(OLTabbar *)aTabbar wrapperDoubleClickedAtIndex:(NSInteger)index;
@end

