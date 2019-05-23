//
//  OLTabBarViewController.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTabBarViewController.h"
#import "OLTabbarWrapperContentView.h"
#import "OLTabbar.h"

@interface OLTabBarViewController ()
@property (nonatomic,strong) OLTabbar *vcTabbar;

@end

@implementation OLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray * tabArrays = @[].mutableCopy;
    NSMutableArray * vcArrarys = @[].mutableCopy;
    NSMutableArray * ItemArrarys = @[].mutableCopy;
    for (int i = 0; i < tabArrays.count; i++) {
        NSString * title = tabArrays[i];
        NSString * vcClass = [self controllerFromTitle:title];
        UIViewController * vc  = [NSClassFromString(vcClass) new];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [vcArrarys addObject:navVC];

        OLTabbarWrapperContentView *item = [[OLTabbarWrapperContentView alloc] init];
        [item setWrapperImage:[UIImage imageNamed:[self getNormalImageFromTitle:title]] withText:title controlState:0];
        [item setWrapperImage:[UIImage imageNamed:[self getSelctImageFromTitle:title]] withText:title controlState:OLTabbarWrapperStateSelected];
        [item setWrapperTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f]} controlState:0];
        [item setWrapperTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f]} controlState:OLTabbarWrapperStateSelected];
        [item setBackgroundColor:[UIColor clearColor]];
        [ItemArrarys addObject:item];

    }

    self.viewControllers = vcArrarys;
    self.selectedIndex  = 0;
    self.vcTabbar = [OLTabbar registWithWrappers:ItemArrarys
                                     forDelegate:self];
    [self.vcTabbar reloadAllWrappers];
    [self.tabBar addSubview:self.vcTabbar];

    self.tabBar.translucent = NO; //这里可以改yes
    self.tabBar.barTintColor = [UIColor whiteColor]; //这里可以改成clear

    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
   
}

- (NSString*)controllerFromTitle:(NSString*)title {
    if ([title isEqualToString:@"首页"]) {
        return @"PGFirstViewController";
    }else if ([title isEqualToString:@"报表"]){
        return @"PGReportFormViewController";
    }else if ([title isEqualToString:@"管理"]){
        return @"PGManageViewController";
    }else if ([title isEqualToString:@"我的"]){
        return @"PGMyViewController";
    }
    return @"";
}

- (NSString*)getNormalImageFromTitle:(NSString*)title {
    if ([title isEqualToString:@"首页"]) {
        return @"main_notselected";
    }else if ([title isEqualToString:@"报表"]){
        return @"report_notselected";
    }else if ([title isEqualToString:@"管理"]){
        return @"manager_notselected";
    }else if ([title isEqualToString:@"我的"]){
        return @"my_notselected";
    }
    return @"";
}

- (NSString*)getSelctImageFromTitle:(NSString*)title {
    if ([title isEqualToString:@"首页"]) {
        return @"main_select";
    }else if ([title isEqualToString:@"报表"]){
        return @"report_select";
    }else if ([title isEqualToString:@"管理"]){
        return @"manager_select";
    }else if ([title isEqualToString:@"我的"]){
        return @"my_select";
    }
    return @"";
}

- (BOOL)tabbar:(OLTabbar *)aTabbar wrapperClickedAtIndex:(NSInteger)index {
    
    self.selectedIndex  = index;
    
    return YES;
}

@end
