//
//  UIBarButtonItem+Badge.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UIBarButtonItem+Badge.h"
#import <objc/runtime.h>

#define kActualView     [self getActualBadgeSuperView]

@implementation UIBarButtonItem (Badge)

#pragma mark -- public methods

- (void)showBadge {
    [kActualView showBadge];
}

- (void)showBadgeWithStyle:(BzBadgeStyle)style
                     value:(NSInteger)value
             animationType:(BzBadgeAnimType)aniType {
    [kActualView showBadgeWithStyle:style value:value animationType:aniType];
}

- (void)clearBadge {
    [kActualView clearBadge];
}

- (void)resumeBadge {
    [kActualView resumeBadge];
}

#pragma mark -- private method

- (UIView *)getActualBadgeSuperView {
    return [self valueForKeyPath:@"_view"];
}

#pragma mark -- setter/getter

- (UILabel *)badge {
    return kActualView.badge;
}

- (void)setBadge:(UILabel *)label {
    [kActualView setBadge:label];
}

- (UIFont *)badgeFont {
    return kActualView.badgeFont;
}

- (void)setBadgeFont:(UIFont *)badgeFont {
    [kActualView setBadgeFont:badgeFont];
}

- (UIColor *)badgeBgColor {
    return [kActualView badgeBgColor];
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    [kActualView setBadgeBgColor:badgeBgColor];
}

- (UIColor *)badgeTextColor {
    return [kActualView badgeTextColor];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    [kActualView setBadgeTextColor:badgeTextColor];
}

- (BzBadgeAnimType)aniType {
    return [kActualView aniType];
}

- (void)setAniType:(BzBadgeAnimType)aniType
{
    [kActualView setAniType:aniType];
}

- (CGRect)badgeFrame {
    return [kActualView badgeFrame];
}

- (void)setBadgeFrame:(CGRect)badgeFrame {
    [kActualView setBadgeFrame:badgeFrame];
}

- (CGPoint)badgeCenterOffset {
    return [kActualView badgeCenterOffset];
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOffset {
    [kActualView setBadgeCenterOffset:badgeCenterOffset];
}

- (NSInteger)badgeMaximumBadgeNumber {
    return [kActualView badgeMaximumBadgeNumber];
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    [kActualView setBadgeMaximumBadgeNumber:badgeMaximumBadgeNumber];
}

@end
