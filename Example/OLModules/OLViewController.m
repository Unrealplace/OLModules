//
//  OLViewController.m
//  OLModules
//
//  Created by Unrealplace on 05/21/2019.
//  Copyright (c) 2019 Unrealplace. All rights reserved.
//

#import "OLViewController.h"
#import "OLTestViewController.h"

@interface OLViewController ()

@end

@implementation OLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    OLTestViewController *test = [OLTestViewController new];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
