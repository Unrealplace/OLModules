//
//  OLTestViewController.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/22.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTestViewController.h"
#import "OLTestTableViewController.h"

@interface OLTestViewController ()

@end

@implementation OLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backgroundColorForCustomNavigationBar = [UIColor redColor];
    self.navigationTitle = @"hello";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    OLTestTableViewController *test = [[OLTestTableViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
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
