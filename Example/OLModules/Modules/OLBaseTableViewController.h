//
//  OLBaseTableViewController.h
//  OLModules_Example
//
//  Created by LiYang on 2019/5/22.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLBaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"
NS_ASSUME_NONNULL_BEGIN

@interface OLBaseTableViewController : OLBaseViewController<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
}



@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceList;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic, assign) BOOL isFinished;//w网络请求完成后刷新emptyview



- (void)configureTableView:(UITableViewStyle)style;

- (UITableViewStyle)tableViewStyle;

- (NSArray *)registerTableViewCells;

/**
 同时集成上拉刷新与下拉加载更多
 */
- (void)addRefreshControl;
/**
 只集成上拉刷新
 */
- (void)addHeaderRefreshControl;
/**
 只集成下拉加载更多
 */
- (void)addFooterRefreshControl;

/**
 有刷新控件的情况下通过该方法加载数据
 */
- (void)loadDataListWithPage: (NSInteger)page;

/**
 显示自定义无更多数据的时候的底部偏移
 
 */
- (void)showNoMoreDataWithOffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
