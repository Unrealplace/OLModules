//
//  OLTabBarViewController.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTabBarViewController.h"
#import "OLBaseViewController.h"

@interface OLTabBarViewController ()

@end

@implementation OLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray * vcArrarys = @[].mutableCopy;
//    NSMutableArray * ItemArrarys = @[].mutableCopy;
//    for (int i = 0; i < tabArrays.count; i++) {
//        NSString * title = tabArrays[i];
//        NSString * vcClass = [self controllerFromTitle:title];
//        PGBaseViewController * vc  = [NSClassFromString(vcClass) new];
//        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
//        [vcArrarys addObject:navVC];
//
//        PGTabbarWrapperContentView *item = [[PGTabbarWrapperContentView alloc] init];
//        [item setWrapperImage:[UIImage imageNamed:[self getNormalImageFromTitle:title]] withText:title controlState:0];
//        [item setWrapperImage:[UIImage imageNamed:[self getSelctImageFromTitle:title]] withText:title controlState:PGTabbarWrapperStateSelected];
//        [item setWrapperTextAttributes:@{NSForegroundColorAttributeName : [UIColor union_colorWithHex:0x7c858a],
//                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f]} controlState:0];
//        [item setWrapperTextAttributes:@{NSForegroundColorAttributeName : [UIColor union_colorWithHex:0xef5657],
//                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f]} controlState:PGTabbarWrapperStateSelected];
//        [item setBackgroundColor:[UIColor clearColor]];
//        [ItemArrarys addObject:item];
//
//    }
//
//    self.viewControllers = vcArrarys;
//    self.selectedIndex  = 0;
//    self.vcTabbar = [PGTabbar registWithWrappers:ItemArrarys
//                                     forDelegate:self];
//    [self.vcTabbar reloadAllWrappers];
//    [self.tabBar addSubview:self.vcTabbar];
//
//    self.tabBar.translucent = NO; //这里可以改yes
//    self.tabBar.barTintColor = [UIColor union_colorWithHex:0xfafafa]; //这里可以改成clear
//
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
