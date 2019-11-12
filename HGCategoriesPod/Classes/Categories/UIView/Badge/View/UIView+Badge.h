//
//  UIView+Badge.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGBadgeProtocol.h"

@interface UIView (Badge)<HGBadgeProtocol>

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIFont *badgeFont;
@property (nonatomic, assign) CGRect badgeFrame;
@property (nonatomic, assign) CGPoint badgeCenterOffset;
@property (nonatomic, assign) HGBadgeAnimType aniType;

@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;

- (void)showBadge;

- (void)showBadgeWithStyle:(HGBadgeStyle)style value:(NSInteger)value animationType:(HGBadgeAnimType)aniType;

- (void)clearBadge;

- (void)resumeBadge;

@end
