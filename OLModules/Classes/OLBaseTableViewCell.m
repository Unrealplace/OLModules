//
//  OLBaseTableViewCell.m
//  OLModule_Example
//
//  Created by LiYang on 2019/5/17.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLBaseTableViewCell.h"

@implementation OLBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUI];
    return self;
}

- (void)setUI{}

- (void)configureCellWithModel:(id _Nullable)model{};

- (void)hiddenBottomLine:(BOOL)isHidden {
    self.bottomLine.hidden = isHidden;
}



@end
