//
//  UIButton+Icon.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UIButton+Icon.h"

@implementation UIButton (Icon)

- (void)iconTheme {
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.titleLabel.font = FONT_NORMAL;
    [self setTitleColor:COLOR_MAIN_BLACK forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)iconThemeForBottom {
    CGSize title_s = [[self titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName:FONT_NORMAL_13}];
    CGFloat total_w = self.titleLabel.frame.origin.x + title_s.width;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.image.size.height+10, self.imageView.image.size.width*-1, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(-16, (total_w-self.imageView.image.size.width-3)/2, 0, 0);
    self.titleLabel.font = FONT_WITH_SIZE(13.0);
    [self setTitleColor:COLOR_MAIN_BLACK forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (id)initWithTitle:(NSString *)title titleColor:(UIColor*)titleColor disableTitleColor:(UIColor*)disableTitleColor target:(id)target action:(SEL)action {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:FONT_NORMAL, NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0.0f, 0.0f, title_r.size.width+20.0, title_r.size.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:disableTitleColor forState:UIControlStateDisabled];
    btn.enabled = YES;
    
    return btn;
}

@end
