//
//  OLBaseTableViewCell.h
//  OLModule_Example
//
//  Created by LiYang on 2019/5/17.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OLBaseTableViewCell : UITableViewCell

@property(nonatomic, strong)UIView *bottomLine;

- (void)setUI;
- (void)hiddenBottomLine:(BOOL)isHidden;
- (void)configureCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
