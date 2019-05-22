//
//  OLBaseViewController.h
//  OLModule_Example
//
//  Created by LiYang on 2019/5/17.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class OLNavigationBarButton;
@class OLNavigationBar;

@interface OLBaseViewController : UIViewController

/** 默认的返回按钮 */
@property (nonatomic, strong, readonly)OLNavigationBarButton *backNavigationBarButton;
/** 自定义的导航栏 */
@property (nonatomic, strong, readonly)OLNavigationBar *customNavigationBar;
/** 背景图片 */
@property (nonatomic, strong)UIImage *backgroundBlurImage;
/** 导航栏标题（自定义导航栏和大标题导航栏的文字都用这个） */
@property (nonatomic, copy)NSString *navigationTitle;
/** 导航栏的背景色 */
@property (nonatomic, strong)UIColor *backgroundColorForCustomNavigationBar;

#pragma mark - 以下方法可供子类重写

//以下方法会在viewDidLoad走完之后按顺序执行
- (void)viewWillAddSubViews;
- (void)viewWillConstraintSubviews;
- (void)viewWillConfigureSubviews;
- (void)viewWillConfigureParameters;
- (void)viewWillRequest;
- (void)viewWillConfigureNotifications;
- (void)viewDidLayoutCustomNavigationBar;

//是否展示上一个页面的高斯模糊背景视图
- (BOOL)isShowBluredBackgroundImageView;
//是否隐藏自定义的导航栏
- (BOOL)isHiddenCustomizedNavigationBar;
//默认返回按钮的点击事件
- (void)backNavigationBarButtonDidClicked;
//导航栏标题文字的属性
- (NSDictionary *)navigationTitleAttributes;
//返回按钮的图片
- (UIImage *)backButtonImage;

@end

NS_ASSUME_NONNULL_END
