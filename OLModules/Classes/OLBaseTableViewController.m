//
//  OLBaseTableViewController.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/22.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLBaseTableViewController.h"
#import "OLCommonHeader.h"
#import "MJRefresh.h"

static CGFloat const kCellHeight = 45.0;

@interface OLBaseTableViewController ()

@end

@implementation OLBaseTableViewController

- (void)configureTableView:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.ol_width,self.view.ol_height) style:style];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView:[self tableViewStyle]];
    [self baseSetupSubviews];
}

- (void)baseSetupSubviews
{
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = kCellHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0.00001;
    self.tableView.sectionHeaderHeight = 0.00001;
    self.tableView.tableHeaderView = self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ol_width, 0.0001)];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.view addSubview:self.tableView];
    NSArray * cells = [self registerTableViewCells];
    [cells enumerateObjectsUsingBlock:^(NSString* cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:[NSClassFromString(cell) class] forCellReuseIdentifier:cell];
    }];
}


- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (NSArray *)registerTableViewCells {
    return nil;
}

#pragma mark - 下拉刷新与下拉加载更多
/** 同时集成上拉刷新与下拉加载更多*/
- (void)addRefreshControl
{
    [self addHeaderRefreshControl];
    [self addFooterRefreshControl];
}

- (void)addHeaderRefreshControl
{
    MJRefreshNormalHeader *header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataList)];
    
    UIStatusBarStyle barStyle = [self preferredStatusBarStyle];
    if (barStyle == UIStatusBarStyleLightContent) {
        header.stateLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        header.lastUpdatedTimeLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    }
    self.tableView.mj_header = header;
}

- (void)addFooterRefreshControl
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataList)];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
}

- (void)loadNewDataList
{
    _currentPage = 1;
    [self loadDataListWithPage:_currentPage];
}

- (void)loadMoreDataList
{
    _currentPage += 1;
    [self loadDataListWithPage:_currentPage];
}

- (void)loadDataListWithPage: (NSInteger)page{
}

- (void)showNoMoreDataWithOffset:(CGFloat)offset {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
    });
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointZero;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"common_empty"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"暂无数据" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor blackColor]}];
    return title;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.isFinished;
}

#pragma mark - lazy loading
- (NSMutableArray *)dataSourceList
{
    if (!_dataSourceList) {
        _dataSourceList = [NSMutableArray array];
    }
    return _dataSourceList;
}

@end
