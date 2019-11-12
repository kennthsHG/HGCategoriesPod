//
//  UIView+Badge.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>
#import "CAAnimation+Animation.h"

#define kBzBadgeDefaultFont                                     ([UIFont boldSystemFontOfSize:9])

#define kBzBadgeDefaultMaximumBadgeNumber                       99

@implementation UIView (Badge)

#pragma mark -- public methods

- (void)showBadge {
    [self showBadgeWithStyle:BzBadgeStyleRedDot value:0 animationType:BzBadgeAnimTypeNone];
}

- (void)showBadgeWithStyle:(BzBadgeStyle)style value:(NSInteger)value animationType:(BzBadgeAnimType)aniType {
    self.aniType = aniType;
    switch (style) {
        case BzBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case BzBadgeStyleNumber:
            [self showNumberBadgeWithValue:value];
            break;
        case BzBadgeStyleNew:
            [self showNewBadge];
            break;
        default:
            break;
    }
    if (aniType != BzBadgeAnimTypeNone) {
        [self beginAnimation];
    }
}

- (void)clearBadge {
    self.badge.hidden = YES;
}

- (void)resumeBadge {
    if (self.badge && self.badge.hidden == YES) {
        self.badge.hidden = NO;
    }
}

#pragma mark -- private methods

- (void)showRedDotBadge {
    [self badgeInit];
    if (self.badge.tag != BzBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = BzBadgeStyleRedDot;
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
    }
    self.badge.hidden = NO;
}

- (void)showNewBadge {
    [self badgeInit];
    if (self.badge.tag != BzBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = BzBadgeStyleNew;
        
        CGRect frame = self.badge.frame;
        frame.size.width = 22;
        frame.size.height = 13;
        self.badge.frame = frame;
        
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.font = kBzBadgeDefaultFont;
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3;
    }
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithValue:(NSInteger)value {
    if (value < 0) {
        return;
    }
    [self badgeInit];
    self.badge.hidden = (value == 0);
    self.badge.tag = BzBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value > self.badgeMaximumBadgeNumber ?
                       [NSString stringWithFormat:@"%@+", @(self.badgeMaximumBadgeNumber)] :
                       [NSString stringWithFormat:@"%@", @(value)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

//懒加载
- (void)badgeInit {
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    
    if (nil == self.badge) {
        CGFloat redotWidth = 8;
        CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redotWidth, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = BzBadgeStyleRedDot; //默认为红色的点
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
        self.badge.layer.masksToBounds = YES;
        self.badge.hidden = NO;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}

#pragma mark --  other private methods
- (void)adjustLabelWidth:(UILabel *)label {
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

#pragma mark -- animation

- (void)beginAnimation {
    switch(self.aniType) {
        case BzBadgeAnimTypeBreathe:
            [self.badge.layer addAnimation:[CAAnimation opacityForever_Animation:1.4]
                                    forKey:kBadgeBreatheAniKey];
            break;
        case BzBadgeAnimTypeShake:
            [self.badge.layer addAnimation:[CAAnimation shake_AnimationRepeatTimes:CGFLOAT_MAX
                                                                          durTimes:1
                                                                            forObj:self.badge.layer]
                                    forKey:kBadgeShakeAniKey];
            break;
        case BzBadgeAnimTypeScale:
            [self.badge.layer addAnimation:[CAAnimation scaleFrom:1.4
                                                          toScale:0.6
                                                         durTimes:1
                                                              rep:MAXFLOAT]
                                    forKey:kBadgeScaleAniKey];
            break;
        case BzBadgeAnimTypeBounce:
            [self.badge.layer addAnimation:[CAAnimation bounce_AnimationRepeatTimes:CGFLOAT_MAX
                                                                           durTimes:1
                                                                             forObj:self.badge.layer]
                                    forKey:kBadgeBounceAniKey];
            break;
        case BzBadgeAnimTypeNone:
        default:
            break;
    }
}


- (void)removeAnimation {
    if (self.badge) {
        [self.badge.layer removeAllAnimations];
    }
}


#pragma mark -- setter/getter
- (UILabel *)badge {
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label {
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont {
    id font = objc_getAssociatedObject(self, &badgeFontKey);
    return font == nil ? kBzBadgeDefaultFont : font;
}

- (void)setBadgeFont:(UIFont *)badgeFont {
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.font = badgeFont;
    }
}

- (UIColor *)badgeBgColor {
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.backgroundColor = badgeBgColor;
    }
}

- (UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.textColor = badgeTextColor;
    }
}

- (BzBadgeAnimType)aniType {
    id obj = objc_getAssociatedObject(self, &badgeAniTypeKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return BzBadgeAnimTypeNone;
}

- (void)setAniType:(BzBadgeAnimType)aniType {
    NSNumber *numObj = @(aniType);
    objc_setAssociatedObject(self, &badgeAniTypeKey, numObj, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        [self removeAnimation];
        [self beginAnimation];
    }
}

- (CGRect)badgeFrame {
    id obj = objc_getAssociatedObject(self, &badgeFrameKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 4) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        CGFloat width = [obj[@"width"] floatValue];
        CGFloat height = [obj[@"height"] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame {
    NSDictionary *frameInfo = @{@"x" : @(badgeFrame.origin.x), @"y" : @(badgeFrame.origin.y),
                                @"width" : @(badgeFrame.size.width), @"height" : @(badgeFrame.size.height)};
    objc_setAssociatedObject(self, &badgeFrameKey, frameInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.frame = badgeFrame;
    }
}

- (CGPoint)badgeCenterOffset {
    id obj = objc_getAssociatedObject(self, &badgeCenterOffsetKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    } else
        return CGPointZero;
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOff {
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, &badgeCenterOffsetKey, cenerInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + badgeCenterOff.x, badgeCenterOff.y);
    }
}

- (NSInteger)badgeMaximumBadgeNumber {
    id obj = objc_getAssociatedObject(self, &badgeMaximumBadgeNumberKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]]) {
        return [obj integerValue];
    }
    else
        return kBzBadgeDefaultMaximumBadgeNumber;
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    NSNumber *numObj = @(badgeMaximumBadgeNumber);
    objc_setAssociatedObject(self, &badgeMaximumBadgeNumberKey, numObj, OBJC_ASSOCIATION_RETAIN);
}
@end
