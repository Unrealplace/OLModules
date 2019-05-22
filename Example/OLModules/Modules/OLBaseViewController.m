//
//  OLBaseViewController.m
//  OLModule_Example
//
//  Created by LiYang on 2019/5/17.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLBaseViewController.h"
#import "OLNavigationBarButton.h"
#import "OLNavigationBar.h"
#import "OLCommonHeader.h"

@interface OLBaseViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong, readwrite) OLNavigationBarButton *backNavigationBarButton;
@property (nonatomic, strong, readwrite) OLNavigationBar *customNavigationBar;

@end

@implementation OLBaseViewController

#pragma mark - Init Methods

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    KCBaseViewController *viewController = [super allocWithZone:zone];
//
//    @weakify(viewController)
//    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
//     subscribeNext:^(id x) {
//         @strongify(viewController)
//         [viewController viewWillAddSubViews];
//         [viewController viewWillConstraintSubviews];
//         [viewController viewWillConfigureSubviews];
//         [viewController viewWillConfigureParameters];
//         [viewController viewWillRequest];
//         [viewController viewWillConfigureNotifications];
//
//         [viewController layoutCustomNavigationBar];
//         [viewController viewDidLayoutCustomNavigationBar];
//     }];
//
//    return viewController;
//}

#pragma mark - Life Cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"\n @!! %@ dealloc",className);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearanceWhenContainedInInstancesOfClasses:@[self.class]].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self layoutCustomNavigationBar];
    
    //是否隐藏自定义的导航栏
    if (![self isHiddenCustomizedNavigationBar]) {
        NSArray *viewControllers = self.navigationController.viewControllers;
        if (viewControllers.count > 1) {
            self.backNavigationBarButton = [[OLNavigationBarButton alloc] init];
            [self.backNavigationBarButton setImage:[self backButtonImage] forState:0];
            self.backNavigationBarButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4.0f, 0, 0);
            [self.backNavigationBarButton addTarget:self
                                             action:@selector(backNavigationBarButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
            self.customNavigationBar.leftNavigationBarButtons = @[self.backNavigationBarButton];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)layoutCustomNavigationBar {
    //防止pop的时候导航栏闪动
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //是否隐藏导航栏
    BOOL isHiddenCustomizedNavigationBar = [self isHiddenCustomizedNavigationBar];
    
    if (!isHiddenCustomizedNavigationBar) {
        [self.view insertSubview:self.customNavigationBar atIndex:999];
    }
    
}

- (void)viewWillAddSubViews {
    
}

- (void)viewWillConstraintSubviews {
    
}

- (void)viewWillConfigureSubviews {
    
}

- (void)viewWillConfigureParameters {
    
}

- (void)viewWillRequest {
    
}

- (void)viewWillConfigureNotifications {
    
}

- (void)viewDidLayoutCustomNavigationBar {
    
}

#pragma mark - Action Methods

- (void)backNavigationBarButtonDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Setter

- (void)setNavigationTitle:(NSString *)navigationTitle {
    _navigationTitle = navigationTitle;
    
    self.customNavigationBar.title = navigationTitle;
}


- (void)setBackgroundColorForCustomNavigationBar:(UIColor *)backgroundColorForCustomNavigationBar {
    _backgroundColorForCustomNavigationBar = backgroundColorForCustomNavigationBar;
    
    self.customNavigationBar.backgroundColor = backgroundColorForCustomNavigationBar;
}

#pragma mark - Getter

- (CGFloat)navigationBarHeight {
    BOOL statusBarHidden = [self prefersStatusBarHidden];
    if (statusBarHidden) {
        if (isIphoneX) {
            return 24 + 44;
        } else {
            return 44;
        }
    } else {
        if (isIphoneX) {
            return 44 + 44;
        } else {
            return 64;
        }
    }
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.image = _backgroundBlurImage;
    }
    
    return _backgroundImageView;
}

- (OLNavigationBar *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[OLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self navigationBarHeight])];
        _customNavigationBar.backgroundColor = [UIColor whiteColor];
        _customNavigationBar.titleAttributes = [self navigationTitleAttributes];
    }
    
    return _customNavigationBar;
}

- (BOOL)isShowBluredBackgroundImageView {
    return NO;
}

- (BOOL)isHiddenCustomizedNavigationBar {
    return NO;
}

- (UIScrollView *)contentScrollView {
    return nil;
}

- (NSDictionary *)navigationTitleAttributes {
    return @{
             NSForegroundColorAttributeName : [UIColor blackColor],
             NSFontAttributeName : [UIFont systemFontOfSize:17.0f]
             };
}

- (UIImage*)backButtonImage {
    return [UIImage imageNamed:@"nav_ic_back"];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}


@end
