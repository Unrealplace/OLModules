//
//  OLNavigationBar.m
//  OLModule_Example
//
//  Created by LiYang on 2019/5/21.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLNavigationBar.h"
#import "OLNavigationBarButton.h"
#import "Masonry.h"

@interface OLNavigationBar ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation OLNavigationBar

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)showCentralView {
    UIView *centralView = _centeralNavigationView ? _centeralNavigationView : _titleLabel;
    if (centralView.alpha == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            centralView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideCentralView {
    UIView *centralView = _centeralNavigationView ? _centeralNavigationView : _titleLabel;
    if (centralView.alpha == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            centralView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
    [self configureCenterViews];
}

- (void)setRightNavigationBarButtons:(NSArray *)rightNavigationBarButtons
{
    if (_rightNavigationBarButtons)
    {
        for (OLNavigationBarButton *barButton in _rightNavigationBarButtons)
        {
            [barButton removeFromSuperview];
        }
    }
    
    _rightNavigationBarButtons = rightNavigationBarButtons;
    [self configureRightBarButtons];
}

- (void)setLeftNavigationBarButtons:(NSArray *)leftNavigationBarButtons
{
    if (_leftNavigationBarButtons)
    {
        for (OLNavigationBarButton *barButton in _leftNavigationBarButtons)
        {
            [barButton removeFromSuperview];
        }
    }
    
    _leftNavigationBarButtons = leftNavigationBarButtons;
    [self configureLeftBarButtons];
}

- (void)setCenteralNavigationView:(UIView *)centeralNavigationView
{
    if (!centeralNavigationView)
    {
        [_centeralNavigationView removeFromSuperview];
    }
    
    _centeralNavigationView = centeralNavigationView;
    [self configureCenterViews];
}

- (void)configureLeftBarButtons
{
    if (_leftNavigationBarButtons && _leftNavigationBarButtons.count > 0)
    {
        __block OLNavigationBarButton *leftBarButton = nil;
        
        [_leftNavigationBarButtons enumerateObjectsUsingBlock:^(OLNavigationBarButton *navigationBarButton, NSUInteger idx, BOOL * stop) {
            [self addSubview:navigationBarButton];
            [navigationBarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(navigationBarButton.contentEdgeInsets.top - navigationBarButton.contentEdgeInsets.bottom);
                if (CGRectEqualToRect(CGRectZero, navigationBarButton.frame))
                {
                    CGSize navigationSize = [navigationBarButton approximatelySize];
                    make.size.mas_equalTo(CGSizeMake(navigationSize.width, 44.0f));
                }
                else
                {
                    make.size.mas_equalTo(navigationBarButton.frame.size);
                }
                
                if (leftBarButton == nil)
                {
                    make.left.equalTo(self).offset(navigationBarButton.contentEdgeInsets.left);
                }
                else
                {
                    make.left.equalTo(leftBarButton.mas_right).offset(navigationBarButton.contentEdgeInsets.left);
                }
            }];
            leftBarButton = navigationBarButton;
        }];
    }
}

- (void)configureCenterViews
{
    if (_centeralNavigationView)
    {
        if (self.titleLabel)
        {
            [self.titleLabel removeFromSuperview];
        }
        
        [self addSubview:_centeralNavigationView];
        [_centeralNavigationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(_centeralNavigationView.frame.size);
        }];
    }
    
    if (!self.centeralNavigationView)
    {
        [self addSubview:self.titleLabel];
        self.titleLabel.text = self.title;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(44.0f);
        }];
    }
}

- (void)configureRightBarButtons
{
    if (_rightNavigationBarButtons && _rightNavigationBarButtons.count > 0)
    {
        __block OLNavigationBarButton *rightBarButton = nil;
        
        [_rightNavigationBarButtons enumerateObjectsUsingBlock:^(OLNavigationBarButton *navigationBarButton, NSUInteger idx, BOOL * stop) {
            [self addSubview:navigationBarButton];
            [navigationBarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(navigationBarButton.contentEdgeInsets.top - navigationBarButton.contentEdgeInsets.bottom);
                if (CGRectEqualToRect(CGRectZero, navigationBarButton.frame))
                {
                    CGSize navigationSize = [navigationBarButton approximatelySize];
                    make.size.mas_equalTo(CGSizeMake(navigationSize.width, 44.0f));
                }
                else
                {
                    make.size.mas_equalTo(navigationBarButton.frame.size);
                }
                
                if (rightBarButton == nil)
                {
                    make.right.equalTo(self).offset(- navigationBarButton.contentEdgeInsets.right);
                }
                else
                {
                    make.right.equalTo(rightBarButton.mas_left).offset(- navigationBarButton.contentEdgeInsets.right);
                }
            }];
            rightBarButton = navigationBarButton;
        }];
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        if (_titleAttributes && [_titleAttributes objectForKey:NSFontAttributeName]) {
            _titleLabel.font = [_titleAttributes objectForKey:NSFontAttributeName];
        } else {
            _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }
        if (_titleAttributes && [_titleAttributes objectForKey:NSForegroundColorAttributeName]) {
            _titleLabel.textColor = [_titleAttributes objectForKey:NSForegroundColorAttributeName];
        } else {
            _titleLabel.textColor = [UIColor blackColor];
        }
    }
    
    return _titleLabel;
}
@end
