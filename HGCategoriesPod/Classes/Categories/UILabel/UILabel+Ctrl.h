//
//  UILabel+Ctrl.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Layout.h"

typedef void(^TouchResponse)(NSString* subStr,NSRange range);

@interface UILabel (Ctrl)

//针对NSRange设置属性
- (void)setAttribute:(NSString*)name value:(id)value range:(NSRange)range;
//针对内容设置属性
- (void)setAttribute:(NSString*)name value:(id)value SubStr:(id)str;

//粗体
- (void)setBoldFontToRange:(NSRange)range;
- (void)setBoldFontToString:(NSString *)string;

- (void)setTouchResponse:(TouchResponse)touch;

@end

