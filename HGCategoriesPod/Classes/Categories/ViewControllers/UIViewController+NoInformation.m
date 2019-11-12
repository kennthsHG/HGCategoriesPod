//
//  UIViewController+NoInformation.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UIViewController+NoInformation.h"
#import <objc/runtime.h>

@implementation UIViewController (NoInformation)

static const char *NoInformationKey = "noInformation";
static const char *InformationTextKey = "informationText";
static const char *TipViewKey = "tipView";
static const char *InformationLabelKey = "informationLabel";

- (BOOL)hasNoInformation {
    NSNumber *noInformation = objc_getAssociatedObject(self, NoInformationKey);
    return [noInformation boolValue];
}

- (void)setNoInformation:(BOOL)noInformation {
    objc_setAssociatedObject(self, NoInformationKey, @(noInformation), OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tipView.hidden = !noInformation;
//    noInformation?[self.view bringSubviewToFront:self.tipView]:[self.view sendSubviewToBack:self.tipView];
//    noInformation?[self.tipView.superview bringSubviewToFront:self.tipView]:[self.tipView.superview sendSubviewToBack:self.tipView];
}

- (NSString *)informationText {
    NSString *text = objc_getAssociatedObject(self, InformationTextKey);
    if (nil == text) {
        return @"暂无相关数据"; // 记录/数据为空哦~
    }
    return text;
}

- (void)setInformationText:(NSString *)informationText {
    objc_setAssociatedObject(self, InformationTextKey, informationText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.informationLabel.text = self.informationText;
}

- (void)setTopOffset:(CGFloat)TopOffset{
    self.tipView.frame = CGRectMake(self.tipView.frame.origin.x, TopOffset, self.tipView.frame.size.width, self.tipView.frame.size.height);
}

- (UIView *)tipView {
    UIView *tipView = objc_getAssociatedObject(self, TipViewKey);
    if (nil == tipView) {
        tipView = [[UIView alloc] initWithFrame:CGRectZero];
        tipView.clipsToBounds = NO;
        tipView.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [self scrollViewInSubViews:self.view];
        scrollView?[scrollView addSubview:tipView]:[self.view addSubview:tipView]; // 如果页面没有 tableView 则加到 self.view 上
        [tipView.superview sendSubviewToBack:tipView];
        tipView.frame = CGRectMake(0, 0, tipView.superview.frame.size.width, tipView.superview.frame.size.height);
        tipView.center = CGPointMake(tipView.superview.center.x, tipView.superview.center.y);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"work_waittodo_prompt_nothing"]];
        [tipView addSubview:imageView];
        CGFloat offset = [self.view.subviews containsObject:tipView.superview] == NO?-44.5:-144.5;
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
        imageView.center = CGPointMake(tipView.superview.center.x, tipView.superview.center.y + offset);
        
        [tipView addSubview:self.informationLabel];
        self.informationLabel.frame = CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 22, imageView.frame.size.width, imageView.frame.size.height);
        imageView.center = CGPointMake(tipView.center.x, imageView.center.y);
        
        objc_setAssociatedObject(self, TipViewKey, tipView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        tipView.hidden = !self.hasNoInformation;
    }
    return tipView;
}

- (UILabel *)informationLabel {
    UILabel *label = objc_getAssociatedObject(self, InformationLabelKey);
    if (nil == label) {
        label = [UILabel new];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        NSString *text = self.informationText;
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
        UIColor *textColor = [UIColor blackColor];
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        objc_setAssociatedObject(self, InformationLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    return label;
}

- (UIScrollView *)scrollViewInSubViews:(UIView *)subView {
    __block UIScrollView *scrollView = nil;
    [subView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            scrollView = obj;
            *stop = YES;
        } else if ([obj isKindOfClass:[UIView class]]) {
            scrollView = [self scrollViewInSubViews:obj];
            if (scrollView) {
                *stop = YES;
            }
        }
    }];
    return scrollView;
}

@end
