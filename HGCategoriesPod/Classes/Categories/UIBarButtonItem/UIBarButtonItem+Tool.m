//
//  UIBarButtonItem+Tool.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UIBarButtonItem+Tool.h"
#import "UIButton+Icon.h"

@implementation UIBarButtonItem (Tool)

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item target:(id)target action:(SEL)action {
    UIImage *img = [self barButtonItemThemeIcon:item];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, 40, 40);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btn setImage:img forState:UIControlStateNormal];
    //    [btn setImage:img_h forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithBarButtonThemeWithImageName:(NSString *)imageName hight:(NSString *)highImageName target:(id)target action:(SEL)action {
    UIImage *img = [UIImage imageNamed:imageName];
    UIImage *imgHight = [UIImage imageNamed:highImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width + 30, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:imgHight forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    //CGFloat fs = 0.0;
    //CGSize s = [title sizeWithFont:FONT_NORMAL minFontSize:10.0 actualFontSize:&fs forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:FONT_NORMAL, NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, title_r.size.width + 30, title_r.size.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithTitle:(NSString *)title titleColor:(UIColor*)titleColor target:(id)target action:(SEL)action {
    //CGFloat fs = 0.0;
    //CGSize s = [title sizeWithFont:FONT_NORMAL minFontSize:10.0 actualFontSize:&fs forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:FONT_NORMAL, NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0.0f, 0.0f, title_r.size.width + 20.0, title_r.size.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0.0f, 0.0f, CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
    btn.titleLabel.font = FONT_NORMAL;
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item title:(NSString *)title target:(id)target action:(SEL)action {
    UIImage *img = [self barButtonItemThemeIcon:item];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0], NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width + 10 + title_r.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn iconTheme];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (UIImage *)barButtonItemThemeIcon:(UIBarButtonThemeItem)item {
    UIImage *img = nil;
    
    switch (item)
    {
        case UIBarButtonThemeItemOK:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemBack:
            img = [UIImage imageNamed:@"common_nav_back"];
            break;
            
        case UIBarButtonThemeItemRegBack:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemSave:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemList:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemFilter:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemAdd:
            img = [UIImage imageNamed:@""];
            break;
            
        case UIBarButtonThemeItemSettings:
            img = [UIImage imageNamed:@"address_personal_info"];
            break;
            
        case UIBarButtonThemeItemMore:
            img = [UIImage imageNamed:@"common_nav_more"];
            break;
    }
    
    return img;
}

- (id)initWithTitle:(NSString *)title colorEnable:(UIColor *)enableColor colorDisable:(UIColor *)disableColor target:(id)target action:(SEL)action {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:FONT_NORMAL, NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, title_r.size.width + 30, title_r.size.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:enableColor forState:UIControlStateNormal];
    [btn setTitleColor:enableColor forState:UIControlStateHighlighted];
    [btn setTitleColor:disableColor forState:UIControlStateDisabled];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

@end
