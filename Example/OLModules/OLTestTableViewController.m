//
//  OLTestTableViewController.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/22.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTestTableViewController.h"

@interface OLTestTableViewController ()

@end

@implementation OLTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}



@end
