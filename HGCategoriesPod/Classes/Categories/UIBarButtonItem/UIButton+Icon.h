//
//  UIButton+Icon.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FONT_NORMAL             ([UIFont systemFontOfSize:15.0])
#define COLOR_MAIN_BLACK        ([UIColor blackColor])
#define FONT_NORMAL_13          ([UIFont systemFontOfSize:13.0])
#define FONT_WITH_SIZE(s)       ([UIFont systemFontOfSize:s])

@interface UIButton (Icon)

- (void)iconTheme;

- (void)iconThemeForBottom;

- (id)initWithTitle:(NSString *)title titleColor:(UIColor*)titleColor disableTitleColor:(UIColor*)disableTitleColor target:(id)target action:(SEL)action;

@end
