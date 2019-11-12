//
//  UIImage+Tool.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
+(UIImage *) createImageWithColor:(UIColor *) color;

+(UIImage *) createImageWithColor:(UIColor *) color rect:(CGRect)rect;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)getImageFromView:(UIView *)view;
+ (UIImage *)deepCopy:(UIImage *)image;
@end

