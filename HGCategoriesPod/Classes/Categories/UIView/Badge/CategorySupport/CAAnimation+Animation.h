//
//  CAAnimation+Animation.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BzAxis)
{
    BzAxisX = 0,
    BzAxisY,
    BzAxisZ
};

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface CAAnimation (Animation)
+(CABasicAnimation *)opacityForever_Animation:(float)time;

+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;

+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(BzAxis)axis repeatCount:(int)repeatCount;

+(CABasicAnimation *)scaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale durTimes:(float)time rep:(float)repeatTimes;

+(CAKeyframeAnimation *)shake_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj;

+(CAKeyframeAnimation *)bounce_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj;
@end
