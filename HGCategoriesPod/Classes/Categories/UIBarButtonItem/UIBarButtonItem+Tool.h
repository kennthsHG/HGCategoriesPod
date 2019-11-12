//
//  UIBarButtonItem+Tool.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIBarButtonThemeItemOK,
    UIBarButtonThemeItemBack,
    UIBarButtonThemeItemRegBack,
    UIBarButtonThemeItemSave,
    UIBarButtonThemeItemList,
    UIBarButtonThemeItemFilter,
    UIBarButtonThemeItemAdd,
    UIBarButtonThemeItemSettings,
    UIBarButtonThemeItemMore
} UIBarButtonThemeItem;

@interface UIBarButtonItem (Tool)

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item
                           target:(id)target
                           action:(SEL)action;

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item
                           title:(NSString *)title
                          target:(id)target action:(SEL)action;

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action;

- (id)initWithTitle:(NSString *)title
         titleColor:(UIColor *)titleColor
             target:(id)target
             action:(SEL)action;

- (id) initWithImage:(UIImage *)image
             target:(id)target
             action:(SEL)action;

- (id)initWithBarButtonThemeWithImageName:(NSString *)imageName
                                    hight:(NSString *)highImageName
                                   target:(id)target action:(SEL)action;

- (id)initWithTitle:(NSString *)title
        colorEnable:(UIColor *)enableColor
       colorDisable:(UIColor *)disableColor
             target:(id)target
             action:(SEL)action;

@end
