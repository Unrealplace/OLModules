//
//  OLTabbarWraper.m
//  OLModules_Example
//
//  Created by LiYang on 2019/5/23.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLTabbarWrapper.h"
static CGFloat const SSTW_BADGEVALUE_PADDING = 3;
static CGFloat const SSTW_BADGEVALUE_DEFAULT_SIZE = 18;

@interface OLTabbarWrapper()
@property (nonatomic,strong) NSMutableDictionary *imageStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *textStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *attributesStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *backgroundColorStyleSheet;
@property (nonatomic) CGRect rectImage;
@property (nonatomic) CGRect rectText;
@property (nonatomic) NSInteger badgeValue;

@property (nonatomic) OLTabbarWrapperState wrapperState;

@end

@implementation OLTabbarWrapper

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    
    _wrapperState = OLTabbarWrapperStateNormal;
    _imageStyleSheet = [[NSMutableDictionary alloc] init];
    _textStyleSheet = [[NSMutableDictionary alloc] init];
    _attributesStyleSheet = [[NSMutableDictionary alloc] init];
    _backgroundColorStyleSheet = [[NSMutableDictionary alloc] init];
    
    _rectImage = CGRectMake(0, 0, 25, 25);
    _badgeEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 5);
    _badgeFillColor = [UIColor redColor];
    _badgeAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                         NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    return self;
}

- (void)resetCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners
{
    CGRect rect = CGRectMake(0, 0, _wrapperSize.width, _wrapperSize.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = rect;
    mask.path = maskPath.CGPath;
    self.layer.mask = mask;
    self.clipsToBounds = YES;
}

- (void)resetWrapperBadgeValue:(NSInteger)badgeValue
{
    if (badgeValue == _badgeValue) return;
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    if (selected && _wrapperState == OLTabbarWrapperStateSelected) return;
    if (!selected && _wrapperState == OLTabbarWrapperStateNormal) return;
    
    _wrapperState = selected ? OLTabbarWrapperStateSelected : OLTabbarWrapperStateNormal;
    
    [self setNeedsDisplay];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_wrapperState != OLTabbarWrapperStateSelected)
    {
        _wrapperState = OLTabbarWrapperStateHighlight;
        [self setNeedsDisplay];
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_wrapperState != OLTabbarWrapperStateSelected)
    {
        _wrapperState = OLTabbarWrapperStateNormal;
        [self setNeedsDisplay];
    }
}

- (void)setWrapperImage:(id)image withText:(NSString *)text controlState:(OLTabbarWrapperState)state
{
    if (image)
    {
        [_imageStyleSheet setObject:image forKey:OLTabbarWrapperStateString(state)];
    }
    
    if (text)
    {
        [_textStyleSheet setObject:text forKey:OLTabbarWrapperStateString(state)];
    }
}

- (void)setWrapperTextAttributes:(NSDictionary *)attributes controlState:(OLTabbarWrapperState)state
{
    if (!attributes || attributes.allKeys.count == 0) return;
    [_attributesStyleSheet setObject:attributes forKey:OLTabbarWrapperStateString(state)];
}

- (void)setWrapperBackgroundColor:(UIColor *)backgroundColor controlState:(OLTabbarWrapperState)state
{
    if (!backgroundColor) return;
    [_backgroundColorStyleSheet setObject:backgroundColor forKey:OLTabbarWrapperStateString(state)];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    [[self wrapperDisplayBackgroundColor] setFill];
    UIRectFill(self.bounds);
    
    UIImage *image = [self wrapperDisplayImage];
    NSString *text = [self wrapperDisplayText];
    
    _rectImage = CGRectMake(0, 4, 21.0f, 21.0f);
    
    if (!text && image)
    {
        // 只包含图片则居中全部显示
        if (CGSizeEqualToSize(CGSizeZero, _wrapperImageSize))
        {
            _wrapperImageSize = image.size;
        }
        _rectImage = CGRectMake((w - _wrapperImageSize.width) / 2,
                                (h - _wrapperImageSize.height) / 2,
                                _wrapperImageSize.width,
                                _wrapperImageSize.height);
    }
    else
    {
        // 包含图片与文字
        _rectImage = CGRectMake((w - _rectImage.size.width) / 2,
                                8,
                                _rectImage.size.width,
                                _rectImage.size.height);
    }
    
    // 设置图片
    if (image)
    {
        [image drawInRect:_rectImage];
    }
    
    // 设置文字
    if (text)
    {
        NSMutableDictionary *attributes = [[self wrapperDisplayAttributes] mutableCopy];
        UIFont *font = [attributes objectForKey:NSFontAttributeName];
        UIColor *textColor = [attributes objectForKey:NSForegroundColorAttributeName];
        
        if (!font)
        {
            font = [self defaultDisplayFont];
            [attributes setObject:font forKey:NSFontAttributeName];
        }
        
        if (!text) {
            textColor = [self defaultDisplayTextColor];
            [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        }
        
        CGSize stringSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                               options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil].size;
        
        [text drawInRect:CGRectMake((w - stringSize.width) / 2,
                                    CGRectGetMaxY(_rectImage) + 1,
                                    stringSize.width,
                                    stringSize.height)
          withAttributes:attributes];
    }
    
    // 角标
    if (_badgeValue > 0)
    {
        NSString *badgeValue = [NSString stringWithFormat:@"%d",(int)_badgeValue];
        CGSize size = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                               options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[self wrapperBadgeFontValue]}
                                               context:nil].size;
        
        CGSize badgeSize = size;
        
        if (CGSizeEqualToSize(_badgeSize, CGSizeZero))
        {
            if (size.height + 2 * SSTW_BADGEVALUE_PADDING < SSTW_BADGEVALUE_DEFAULT_SIZE)
            {
                badgeSize.height = SSTW_BADGEVALUE_DEFAULT_SIZE;
            }
            
            if (size.width + 2 * SSTW_BADGEVALUE_PADDING < SSTW_BADGEVALUE_DEFAULT_SIZE)
            {
                badgeSize.width = SSTW_BADGEVALUE_DEFAULT_SIZE;
            }
            
            if (badgeSize.width < badgeSize.height)
            {
                badgeSize.width = badgeSize.height;
            }
            
            switch (_badgeType)
            {
                case OLTabbarBadgeTypeColor:
                {
                    badgeSize = CGSizeMake(10, 10);
                }
                    break;
                case OLTabbarBadgeTypeNumber:
                {
                    badgeSize = CGSizeMake(badgeSize.width + 2 * SSTW_BADGEVALUE_PADDING,
                                           badgeSize.height + 2 * SSTW_BADGEVALUE_PADDING);
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            badgeSize = _badgeSize;
        }
        
        CGRect badgeRect = CGRectMake(w - badgeSize.width - _badgeEdgeInsets.right,
                                      _badgeEdgeInsets.top,
                                      badgeSize.width,
                                      badgeSize.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, _badgeFillColor.CGColor);
        CGContextFillEllipseInRect(context, badgeRect);
        
        switch (_badgeType)
        {
            case OLTabbarBadgeTypeColor:
            {
                
            }
                break;
            case OLTabbarBadgeTypeNumber:
            {
                CGRect textRect = CGRectMake(CGRectGetMinX(badgeRect) + (CGRectGetWidth(badgeRect) - size.width) / 2,
                                             CGRectGetMinY(badgeRect) + (CGRectGetHeight(badgeRect) - size.height) / 2,
                                             size.width,
                                             size.height);
                [badgeValue drawInRect:textRect
                        withAttributes:_badgeAttributes];
            }
                break;
            default:
                break;
        }
    }
}

- (UIFont *)wrapperBadgeFontValue
{
    if (_badgeAttributes && [_badgeAttributes.allKeys containsObject:NSFontAttributeName])
    {
        return [_badgeAttributes objectForKey:NSFontAttributeName];
    }
    else if ([_badgeAttributes.allKeys containsObject:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)])
    {
        return [_badgeAttributes objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    }
    return [UIFont systemFontOfSize:14];
}

- (UIColor *)wrapperDisplayBackgroundColor
{
    if ([_backgroundColorStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(_wrapperState)])
    {
        return [_backgroundColorStyleSheet objectForKey:OLTabbarWrapperStateString(_wrapperState)];
    }
    else if ([_backgroundColorStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)])
    {
        return [_backgroundColorStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    }
    return [UIColor clearColor];
}

- (UIImage *)wrapperDisplayImage
{
    if ([_imageStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(_wrapperState)])
    {
        id image = [_imageStyleSheet objectForKey:OLTabbarWrapperStateString(_wrapperState)];
        if ([image isKindOfClass:[NSString class]])
        {
            return [UIImage imageNamed:image];
        }
        return image;
    }
    else if ([_imageStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)])
    {
        id image = [_imageStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
        if ([image isKindOfClass:[NSString class]])
        {
            return [UIImage imageNamed:image];
        }
        return image;
    }
    return nil;
}

- (NSString *)wrapperDisplayText
{
    if ([_textStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(_wrapperState)])
    {
        return [_textStyleSheet objectForKey:OLTabbarWrapperStateString(_wrapperState)];
    }
    else if ([_textStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)])
    {
        return [_textStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    }
    return nil;
}

- (NSDictionary *)wrapperDisplayAttributes
{
    if ([_attributesStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(_wrapperState)])
    {
        return [_attributesStyleSheet objectForKey:OLTabbarWrapperStateString(_wrapperState)];
    }
    else if ([_attributesStyleSheet.allKeys containsObject:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)])
    {
        return [_attributesStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    }
    return nil;
}

- (UIFont *)defaultDisplayFont
{
    NSDictionary *styleSheet = [_attributesStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    if ([styleSheet.allKeys containsObject:NSFontAttributeName])
    {
        return [styleSheet objectForKey:NSFontAttributeName];
    }
    return [UIFont systemFontOfSize:12];
}

- (UIColor *)defaultDisplayTextColor
{
    NSDictionary *styleSheet = [_attributesStyleSheet objectForKey:OLTabbarWrapperStateString(OLTabbarWrapperStateNormal)];
    if ([styleSheet.allKeys containsObject:NSForegroundColorAttributeName])
    {
        return [styleSheet objectForKey:NSForegroundColorAttributeName];
    }
    return [UIColor blackColor];
}

@end
