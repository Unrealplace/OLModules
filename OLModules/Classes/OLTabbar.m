//
//  OLTabbar.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTabbar.h"

@interface OLTabbar()
@property (nonatomic,strong) OLTabbarWrapperContentView *selectedWrapper;
@end

@implementation OLTabbar

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    _selectedIndex = 0;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    _selectedIndex = 0;
    return self;
}


/**
 注册代理 和 wrappers items
 
 */
+ (OLTabbar *)registWithWrappers:(NSArray *)wrappers forDelegate:(id)delegate {
    OLTabbar *obj = [[OLTabbar alloc] init];
    obj.delegate = delegate;
    obj.wrappers = wrappers;
    return obj;
}

//要调用一下 设置功能
- (void)reloadAllWrappers {
    [self configureWrappers];
    [self reloadAllWrappersSize];
}

// 设置每个 item
- (void)configureWrappers {
    for (int i = 0; i < _wrappers.count; i ++) {
        OLTabbarWrapperContentView *wrapper = [_wrappers objectAtIndex:i];
        [wrapper setTag:i];
        [self addSubview:wrapper];
        
        UITapGestureRecognizer *taped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedAction:)];
        [wrapper addGestureRecognizer:taped];
        
        UITapGestureRecognizer *taped2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapedAction:)];
        taped2.numberOfTapsRequired = 2;
        [wrapper addGestureRecognizer:taped2];
        
        if (i == 0) {
            [self wrapperContentViewActionHandler:wrapper];
        }
    }
}

- (void)selectAtIndex:(NSInteger)index {
    if (index >= 0 && index < _wrappers.count) {
        for (OLTabbarWrapperContentView *view in _wrappers) {
            if (view.tag == index) {
                [self wrapperContentViewActionHandler:view];
                break;
            }
        }
    }
}

- (void)doubleTapedAction:(UITapGestureRecognizer *)taped {
    OLTabbarWrapperContentView *view = (OLTabbarWrapperContentView *)taped.view;
    if ([self.delegate respondsToSelector:@selector(tabbar:wrapperDoubleClickedAtIndex:)]) {
        [self.delegate tabbar:self wrapperDoubleClickedAtIndex:view.tag];
    }
}

- (void)tapedAction:(UITapGestureRecognizer *)taped {
    OLTabbarWrapperContentView *view = (OLTabbarWrapperContentView *)taped.view;
    [self wrapperContentViewActionHandler:view];
}

- (void)wrapperContentViewActionHandler:(OLTabbarWrapperContentView *)sender {
    if ([self.delegate respondsToSelector:@selector(tabbar:wrapperClickedAtIndex:)]) {
        BOOL succ = [self.delegate tabbar:self wrapperClickedAtIndex:sender.tag];
        if (succ) {
            if (self.selectedWrapper != sender) {
                self.selectedWrapper.wrapper.selected = NO;
                self.selectedWrapper = sender;
                sender.wrapper.selected = YES;
            }
        }
    }
}

- (void)reloadAllWrappersSize
{
    CGFloat totalWidth = 0;
    
    for (OLTabbarWrapperContentView *wrapper in _wrappers) {
        CGSize size = CGSizeMake(wrapper.wrapperSize.width != 0 ? wrapper.wrapperSize.width : [self generalWidth],
                                 wrapper.wrapperSize.height != 0 ? wrapper.wrapperSize.height : [self generalHeight]);
        [wrapper setFrame:CGRectMake(totalWidth, [self generalHeight] - size.height, size.width, size.height)];
        totalWidth += size.width;
    }
}

- (CGFloat)generalWidth
{
    if (!_wrappers || _wrappers.count == 0) return 0;
    
    CGFloat customWidth = 0;
    NSUInteger number = 0;
    for (OLTabbarWrapperContentView *wrapper in _wrappers) {
        if (wrapper.wrapperSize.width != 0.0f) {
            customWidth += wrapper.wrapperSize.width;
            number ++;
        }
    }
    
    return ([UIScreen mainScreen].bounds.size.width - customWidth) / (_wrappers.count - number);
}

- (CGFloat)generalHeight
{
    return 49.0f;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (OLTabbarWrapperContentView *wrapper in _wrappers) {
            CGPoint tempoint = [wrapper convertPoint:point fromView:self];
            if (CGRectContainsPoint(wrapper.bounds, tempoint)) {
                view = wrapper;
            }
        }
    }
    return view;
}

@end
