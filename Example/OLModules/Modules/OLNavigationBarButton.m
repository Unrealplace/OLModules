//
//  OLNavigationBarButton.m
//  OLModule_Example
//
//  Created by LiYang on 2019/5/21.
//  Copyright © 2019 Unrealplace. All rights reserved.
//

#import "OLNavigationBarButton.h"

@implementation OLNavigationBarButton
{
    // 角标圆弧大小
    CGFloat _radius;
    
    NSMutableDictionary *_backgroundImageDictionary;
    NSMutableDictionary *_imageDictionary;
    NSMutableDictionary *_titleDictionary;
    NSMutableDictionary *_textAttribuesDictionary;
    UIControlState _controlState;
    
    NSDictionary *_defaultTextAttributes;
    NSMutableDictionary *_innerTextAttributes;
    
    CGRect _titleRect;
    CGRect _imageRect;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _backgroundImageDictionary = [NSMutableDictionary new];
    _imageDictionary = [NSMutableDictionary new];
    _titleDictionary = [NSMutableDictionary new];
    _textAttribuesDictionary = [NSMutableDictionary new];
    _innerTextAttributes = [NSMutableDictionary new];
    
    _titleRect = CGRectZero;
    _imageRect = CGRectZero;
    
    _offsetEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 1);
    _badgeAddingEdgeInsets = UIEdgeInsetsMake(0, 3, 1, 3);
    _badgeBackgroundColor = [UIColor redColor];
    _badgeAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                         NSFontAttributeName : [UIFont systemFontOfSize:9.0f]};
    
    _defaultTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                               NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                               };
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue.integerValue > 99) {
        badgeValue = @"99+";
    }
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (CGSize)approximatelySize
{
    [self _configureBarButton];
    
    NSString *title = [self _fetchTitleWithControlState:_controlState];
    UIImage *image = [self _fetchImageWithControlState:_controlState];
    
    if (title && !image) {
        return _titleRect.size;
    } else if (!title && image) {
        return _imageRect.size;
    } else {
        switch (_titlePositionType)
        {
                case OLPositionStyleTop:
            {
                return CGSizeMake(MAX(CGRectGetWidth(_titleRect), CGRectGetWidth(_imageRect)) + _contentEdgeInsets.left + _contentEdgeInsets.right,
                                  _titleEdgeInsets.top + CGRectGetHeight(_titleRect) + _titleEdgeInsets.bottom + _imageEdgeInsets.top + CGRectGetHeight(_imageRect) + _imageEdgeInsets.bottom + _contentEdgeInsets.top + _contentEdgeInsets.bottom);
            }
                break;
                case OLPositionStyleLeft:
            {
                return CGSizeMake(_titleEdgeInsets.left + CGRectGetWidth(_titleRect) + _titleEdgeInsets.right + _imageEdgeInsets.left + CGRectGetWidth(_imageRect) + _imageEdgeInsets.right + _contentEdgeInsets.left + _contentEdgeInsets.right,
                                  MAX(CGRectGetHeight(_titleRect), CGRectGetHeight(_imageRect)) + _contentEdgeInsets.top + _contentEdgeInsets.bottom);
            }
                break;
                case OLPositionStyleRight:
            {
                return CGSizeMake(_titleEdgeInsets.left + CGRectGetWidth(_titleRect) + _titleEdgeInsets.right + _imageEdgeInsets.left + CGRectGetWidth(_imageRect) + _imageEdgeInsets.right + _contentEdgeInsets.left + _contentEdgeInsets.right,
                                  MAX(CGRectGetHeight(_titleRect), CGRectGetHeight(_imageRect)) + _contentEdgeInsets.top + _contentEdgeInsets.bottom);
            }
                break;
                case OLPositionStyleBottom:
            {
                return CGSizeMake(MAX(CGRectGetWidth(_titleRect), CGRectGetWidth(_imageRect)) + _contentEdgeInsets.left + _contentEdgeInsets.right,
                                  _titleEdgeInsets.top + CGRectGetHeight(_titleRect) + _titleEdgeInsets.bottom + _imageEdgeInsets.top + CGRectGetHeight(_imageRect) + _imageEdgeInsets.bottom + _contentEdgeInsets.top + _contentEdgeInsets.bottom);
            }
                break;
            default:
                break;
        }
    }
    
    return CGSizeMake(44.0f, 44.0f);
}

- (void)_configureBarButton
{
    NSString *title = [self _fetchTitleWithControlState:_controlState];
    UIImage *image = [self _fetchImageWithControlState:_controlState];
    NSDictionary *textAttributes = [self _fetchTextAttributesWithControlState:_controlState];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    // 绘制文字
    if (title)
    {
        _innerTextAttributes = [NSMutableDictionary new];
        if (textAttributes)
        {
            _innerTextAttributes = textAttributes.mutableCopy;
            if (![_innerTextAttributes objectForKey:NSForegroundColorAttributeName]) {
                 [_innerTextAttributes setObject:[_defaultTextAttributes objectForKey:NSForegroundColorAttributeName] forKey:NSForegroundColorAttributeName];
            }
            
            if (![_innerTextAttributes objectForKey:NSFontAttributeName])
            {
                [_innerTextAttributes setObject:[_defaultTextAttributes objectForKey:NSFontAttributeName] forKey:NSFontAttributeName];
            }
        }
        else
        {
            _innerTextAttributes = _defaultTextAttributes.mutableCopy;
        }
        
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                               options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:_innerTextAttributes
                                               context:nil].size;
        
        _titleRect = CGRectMake((width - titleSize.width) / 2,
                                (height - titleSize.height) / 2,
                                titleSize.width,
                                titleSize.height);
        
        switch (_titlePositionType)
        {
                case OLPositionStyleTop:
            {
                _titleRect = CGRectMake(_titleRect.origin.x,
                                        0,
                                        _titleRect.size.width,
                                        _titleRect.size.height);
            }
                break;
                case OLPositionStyleLeft:
            {
                _titleRect = CGRectMake(0,
                                        _titleRect.origin.y,
                                        _titleRect.size.width,
                                        _titleRect.size.height);
            }
                break;
                case OLPositionStyleRight:
            {
                _titleRect = CGRectMake(width - titleSize.width,
                                        _titleRect.origin.y,
                                        _titleRect.size.width,
                                        _titleRect.size.height);
            }
                break;
                case OLPositionStyleBottom:
            {
                _titleRect = CGRectMake(_titleRect.origin.x,
                                        height - titleSize.height,
                                        _titleRect.size.width,
                                        _titleRect.size.height);
            }
                break;
            default:
                break;
        }
        
        _titleRect = CGRectMake(_titleRect.origin.x - _titleEdgeInsets.right + _titleEdgeInsets.left,
                                _titleRect.origin.y - _titleEdgeInsets.bottom + _titleEdgeInsets.top,
                                _titleRect.size.width,
                                _titleRect.size.height);
    }
    
    // 绘制图片
    if (image)
    {
        _imageRect = CGRectMake((width - image.size.width) / 2,
                                (height - image.size.height) / 2,
                                image.size.width,
                                image.size.height);
        
        if (title)
        {
            switch (_titlePositionType)
            {
                    case OLPositionStyleTop:
                {
                    _imageRect = CGRectMake(_imageRect.origin.x - _imageEdgeInsets.right + _imageEdgeInsets.left,
                                            CGRectGetMaxY(_titleRect) - _imageEdgeInsets.bottom + _imageEdgeInsets.top,
                                            _imageRect.size.width,
                                            _imageRect.size.height);
                }
                    break;
                    case OLPositionStyleLeft:
                {
                    _imageRect = CGRectMake(CGRectGetMaxX(_titleRect) - _imageEdgeInsets.right + _imageEdgeInsets.left,
                                            CGRectGetMinY(_imageRect) - _imageEdgeInsets.bottom + _imageEdgeInsets.top,
                                            _imageRect.size.width,
                                            _imageRect.size.height);
                }
                    break;
                    case OLPositionStyleRight:
                {
                    _imageRect = CGRectMake(CGRectGetMinX(_titleRect) - _imageRect.size.width - _imageEdgeInsets.right + _imageEdgeInsets.left,
                                            _imageRect.origin.y - _imageEdgeInsets.bottom + _imageEdgeInsets.top,
                                            _imageRect.size.width,
                                            _imageRect.size.height);
                }
                    break;
                    case OLPositionStyleBottom:
                {
                    _imageRect = CGRectMake(_imageRect.origin.x - _imageEdgeInsets.right + _imageEdgeInsets.left,
                                            CGRectGetMinY(_titleRect) - _imageRect.size.height - _imageEdgeInsets.bottom + _imageEdgeInsets.top,
                                            _imageRect.size.width,
                                            _imageRect.size.height);
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *backgroundImage = [self _fetchBackgroundImageWithControlState:_controlState];
    NSString *title = [self _fetchTitleWithControlState:_controlState];
    UIImage *image = [self _fetchImageWithControlState:_controlState];
    if (_controlState == UIControlStateHighlighted) {
//        image = [image imageByApplyingAlpha:0.4f];
    }
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    [self _configureBarButton];
    
    // 绘制背景图片
    if (backgroundImage)
    {
        [backgroundImage drawInRect:self.bounds];
    }
    
    // 绘制文字
    if (title)
    {
        [title drawInRect:_titleRect withAttributes:_innerTextAttributes];
    }
    
    // 绘制图片
    if (image)
    {
        [image drawInRect:_imageRect];
    }
    
    if (self.badgeValue)
    {
        CGSize calculatedBadgeValueSize = [self.badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                        options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:_badgeAttributes
                                                                        context:nil].size;
        CGSize badgeValueSize = CGSizeMake(calculatedBadgeValueSize.width + _badgeAddingEdgeInsets.left + _badgeAddingEdgeInsets.right,
                                           calculatedBadgeValueSize.height + _badgeAddingEdgeInsets.top + _badgeAddingEdgeInsets.bottom);
        _radius = badgeValueSize.height / 2;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2.0f);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        
        CGFloat x = width - _offsetEdgeInsets.right - badgeValueSize.width;
        
        CGContextMoveToPoint(context, x + _radius, _offsetEdgeInsets.top);
        // 上右顶点
        CGContextAddArcToPoint(context,
                               width - _offsetEdgeInsets.right,
                               _offsetEdgeInsets.top,
                               width - _offsetEdgeInsets.right,
                               _offsetEdgeInsets.top + badgeValueSize.height - _radius,
                               _radius);
        // 下右顶点
        CGContextAddArcToPoint(context,
                               width - _offsetEdgeInsets.right,
                               _offsetEdgeInsets.top + badgeValueSize.height,
                               x + _radius,
                               _offsetEdgeInsets.top + badgeValueSize.height,
                               _radius);
        
        // 左下顶点
        CGContextAddArcToPoint(context,
                               x,
                               _offsetEdgeInsets.top + badgeValueSize.height,
                               x,
                               _offsetEdgeInsets.top + _radius,
                               _radius);
        
        // 左上顶点
        CGContextAddArcToPoint(context,
                               x,
                               _offsetEdgeInsets.top,
                               x + _radius,
                               _offsetEdgeInsets.top,
                               _radius);
        
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        
        // 图形绘制完成后绘制文字
        [self.badgeValue drawInRect:CGRectMake(x + _badgeAddingEdgeInsets.left,
                                               _offsetEdgeInsets.top + _badgeAddingEdgeInsets.top,
                                               badgeValueSize.width,
                                               badgeValueSize.height)
                     withAttributes:_badgeAttributes];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)controlState
{
    if (backgroundImage)
    {
        [_backgroundImageDictionary setObject:backgroundImage forKey:@(controlState)];
    }
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)controlState
{
    if (image)
    {
        [_imageDictionary setObject:image forKey:@(controlState)];
    }
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)controlState
{
    if (title)
    {
        [_titleDictionary setObject:title forKey:@(controlState)];
    }
    [self setNeedsDisplay];
}

- (void)setTextAttributes:(NSDictionary *)textAttributes forState:(UIControlState)controlState
{
    if (textAttributes)
    {
        [_textAttribuesDictionary setObject:textAttributes forKey:@(controlState)];
    }
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)controlState
{
    if (textColor)
    {
        NSMutableDictionary *attributes = nil;
        if (![_textAttribuesDictionary.allKeys containsObject:@(controlState)])
        {
            attributes = [NSMutableDictionary new];
        }
        else
        {
            attributes = [_textAttribuesDictionary objectForKey:@(controlState)];
        }
        
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        [self setTextAttributes:attributes forState:controlState];
    }
}

- (void)setTextFont:(UIFont *)textFont forState:(UIControlState)controlState
{
    if (textFont)
    {
        NSMutableDictionary *attributes = nil;
        if (![_textAttribuesDictionary.allKeys containsObject:@(controlState)])
        {
            attributes = [NSMutableDictionary new];
        }
        else
        {
            attributes = [_textAttribuesDictionary objectForKey:@(controlState)];
        }
        
        [attributes setObject:textFont forKey:NSFontAttributeName];
        [self setTextAttributes:attributes forState:controlState];
    }
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected && _controlState == UIControlStateSelected) return;
    if (!selected && _controlState == UIControlStateNormal) return;
    
    _controlState = selected ? UIControlStateSelected : UIControlStateNormal;
    [self setNeedsDisplay];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_controlState != UIControlStateSelected) {
        _controlState = UIControlStateHighlighted;
        [self setNeedsDisplay];
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_controlState == UIControlStateHighlighted) {
        _controlState = UIControlStateNormal;
        [self setNeedsDisplay];
    }
}

- (NSString *)_fetchTitleWithControlState:(UIControlState)controlState
{
    return [self contentsOfDictionary:_titleDictionary controlState:controlState];
}

- (UIImage *)_fetchImageWithControlState:(UIControlState)controlState
{
    return [self contentsOfDictionary:_imageDictionary controlState:controlState];
}

- (NSDictionary *)_fetchTextAttributesWithControlState:(UIControlState)controlState
{
    return [self contentsOfDictionary:_textAttribuesDictionary controlState:controlState];
}

- (UIImage *)_fetchBackgroundImageWithControlState:(UIControlState)controlState
{
    return [self contentsOfDictionary:_backgroundImageDictionary controlState:controlState];
}

- (id)contentsOfDictionary:(NSDictionary *)dictionary controlState:(UIControlState)controlState
{
    if ([dictionary.allKeys containsObject:@(controlState)])
    {
        return [dictionary objectForKey:@(controlState)];
    }
    
    if ([dictionary.allKeys containsObject:@(UIControlStateNormal)])
    {
        return [dictionary objectForKey:@(UIControlStateNormal)];
    }
    
    return nil;
}
@end
