//
//  UIImage+colorful.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
