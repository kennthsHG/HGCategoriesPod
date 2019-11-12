//
//  HGBadgeProtocol.h
//  HGCategoriesPod
//
//  Created by 黄纲 on 2019/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"
#define kBadgeBounceAniKey      @"bounce"

static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeMaximumBadgeNumberKey;

typedef NS_ENUM(NSUInteger, HGBadgeStyle) {
    HGBadgeStyleRedDot = 0,
    HGBadgeStyleNumber,
    HGBadgeStyleNew
};

typedef NS_ENUM(NSUInteger, HGBadgeAnimType) {
    HGBadgeAnimTypeNone = 0,
    HGBadgeAnimTypeScale,
    HGBadgeAnimTypeShake,
    HGBadgeAnimTypeBounce,
    HGBadgeAnimTypeBreathe
};

#pragma mark -- protocol definition

@protocol HGBadgeProtocol <NSObject>

@required

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont *badgeFont;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGRect badgeFrame;
@property (nonatomic, assign) CGPoint  badgeCenterOffset;
@property (nonatomic, assign) HGBadgeAnimType aniType;
@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;
- (void)showBadge;

- (void)showBadgeWithStyle:(HGBadgeStyle)style
                     value:(NSInteger)value
             animationType:(HGBadgeAnimType)aniType;

- (void)clearBadge;


NS_ASSUME_NONNULL_END
