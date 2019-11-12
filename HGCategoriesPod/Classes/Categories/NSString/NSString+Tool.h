//
//  NSString+Tool.h
//  BoZhanToolKit
//
//  Created by lisaiqiang on 16/7/20.
//  Copyright © 2016年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? YES : NO )

@interface NSString (Tool)
+(NSString *)currentAppVersion;

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithNumber:(NSNumber *) number;
+(NSString *) jsonStringWithObject:(id) object;

@end

#pragma mark - NSString 校验

@interface NSString (Validation)

-(BOOL)isBlank;
-(BOOL)isValid;
- (NSString *)removeWhiteSpacesFromString;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)addString:(NSString *)string link:(NSString *)link;
- (NSString *)removeSubString:(NSString *)subString;
- (NSString *)removeAllSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;

- (NSString *)md5;


+(NSString *)stringFromDateYYMM:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date;
+(NSString *)stringFromDateAndHHmm:(NSDate *)date;
+ (NSString *)stringFromDateMMdd:(NSDate *)date;
+ (NSString *)stringFromDateFormatterWithyyyyMMddhhmmss:(NSDate *)date;
+(NSString *)stringFromDateAndHHmm:(NSDate *)date withHHmm:(NSString*)HHmmStr;

+ (NSString *)stringFromDateSp:(long)dateSp;

+ (NSString *)stringFromDateFormatterWithyyyyMMdd:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithyyyyMM:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithMM:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithdd:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithyyyy:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithMMdd:(long)dateSp;
+ (NSString *)stringFromDateFormatterWithMMddHHmm:(long)dateSp;

+ (NSString *)stringFromDateWithWeekSp:(long)dateSp;

+ (NSString *)ageFromDateString:(NSString *)dateString;

+ (NSArray *)imagesArrayFromString:(NSString *)arrayString;

+ (CGFloat)stringHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing;

/**
 *  获取时间差
 *
 *  @param theDate 需要计算的时间
 *
 *  @return 时间差
 */
+ (NSString *)intervalSinceNow:(NSString*) theDate;

+ (NSDate *)convertDateFromString:(NSString*)dateString;

+ (NSDate *)convertDateFromyyyyMMddhhmmssString:(NSString*)dateString;

//判断是否为整形：
+ (BOOL)isPureIntValue:(NSString*)string;

//判断是否为浮点形：
+ (BOOL)isPureFloatValue:(NSString*)string;

+ (BOOL) isValidateMobile:(NSString *)mobile;

+ (BOOL) isValidatePassWord:(NSString*)password;

//转换按KB转
+ (NSString*) changeStrSizWithKB:(NSInteger)size;

//转换按B转
+ (NSString*) changeStrSizWithB:(NSInteger)size;


@end

#pragma mark - NSString 校验 block形式

@interface NSString (BlockHelper)

@property (nonatomic, readonly) NSString *(^add)();

@property (nonatomic, readonly) NSString *(^addFormat)(NSString *format, ...);

@property (nonatomic, readonly) NSString *(^addInt)(NSInteger input);

@property (nonatomic, readonly) NSString *(^addFloat)(CGFloat input);

@property (nonatomic, readonly) NSInteger (^indexOf)(NSString *string);

@property (nonatomic, readonly) BOOL (^isContains)(NSString *string);

@property (nonatomic, readonly) NSString *(^replace)(NSString *targetString,NSString *withString);

@property (nonatomic, readonly) BOOL (^isEqualTo)(NSString *string);

@property (nonatomic, readonly) BOOL (^isEqualToIgnoreCase)(NSString *string);

@property (nonatomic, readonly) BOOL (^isEmail)();
@property (nonatomic, readonly) BOOL (^isURL)();
@property (nonatomic, readonly) BOOL (^isCellPhoneNumber)();
@property (nonatomic, readonly) BOOL (^isNumber)();
@property (nonatomic, readonly) BOOL (^isIntegerNumber)();
@property (nonatomic, readonly) BOOL (^isDecimalNumber)();

@property (nonatomic, readonly) BOOL (^isMatch)(NSString *regexString);

@property (nonatomic, readonly) NSString *(^strim)();

@property (nonatomic, readonly) NSString *(^urlEncode)();

@property (nonatomic, readonly) NSString *(^urlDecode)();

@property (nonatomic, readonly) NSDictionary *(^paramsInUrl)();
@property (nonatomic, readonly) NSString *(^paramInUrlWithKey)(NSString *key);

@property (nonatomic, readonly) NSString *(^base64EncodedString)();
@property (nonatomic, readonly) NSString *(^base64DecodedString)();
@property (nonatomic, readonly) NSData *(^base64DecodedData)();

@end

@interface NSAttributedString (ParagraphStyle)

+ (CGFloat)contentHeightWithText:(NSString *)text
                           width:(CGFloat)width
                        fontSize:(CGFloat)fontSize
                     lineSpacing:(CGFloat)lineSpacing;

@end

typedef NS_ENUM(NSUInteger, WPImageURLDPIType) {
    WPImageURLDPIHigh, // 标清
    WPImageURLDPIMiddle, // 中等缩略图
    WPImageURLDPISmall, // 小缩略图
    WPImageURLDPIOrign, // 原图
};

@interface NSString (ImageURL)
//图片显示规则:
//所有的图片在列表页中展示100*100的缩略图即:原图片名称+_2+.图片类型
//所有图片点击查看大图时加载原图。
// 根据参数选择URL
- (NSString *)thumbUrlWithDPIType:(WPImageURLDPIType)type;

// 1.同大小品质降低缩略图,生成规则:原图片名称+_+.图片类型
- (NSString *)thumbUrlSameDpi;
// 2.400*400缩略图,生成规则:原图片名称+_1+.图片类型
- (NSString *)thumbUrlMiddleDpi;
// 3.100*100缩略图,生成规则:原图片名称+_2+.图片类型
- (NSString *)thumbUrlSmallDpi;

@end
