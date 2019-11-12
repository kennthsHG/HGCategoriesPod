//
//  NSString+Tool.m
//  BoZhanToolKit
//
//  Created by lisaiqiang on 16/7/20.
//  Copyright © 2016年 lisaiqiang. All rights reserved.
//

#import "NSString+Tool.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Tool)
+(NSString *)currentAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+(NSString *) jsonStringWithNumber:(NSNumber *) number {
    return [NSString stringWithFormat:@"%@", number];
}

+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        value = [NSString jsonStringWithNumber:object];
    }
    return value;
}

@end

@implementation NSString (Validation)

// Checking if String is Empty
-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}
//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]|| [self isEqualToString:@"<null>"]||[self isKindOfClass:[NSNull class]] || self == [NSNull null])  ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}


+ (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}



// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString *)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

- (NSString *)addString:(NSString *)string link:(NSString *)link{
    if(!string || string.length == 0)
        return self;
    return self.length > 0 ? [NSString stringWithFormat:@"%@%@%@",self,link,string] : string;
}
// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

-(NSString *)removeAllSubString:(NSString *)subString
{
    NSString *text = self;
    while ([text containsString:subString])
    {
        NSRange range = [text rangeOfString:subString];
        text =  [text stringByReplacingCharactersInRange:range withString:@""];
    }
    return text;
}

// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@""];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}


// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isVAlidPhoneNumber
{
    NSString *str = self;
    if([self containsString:@"-"]){
        str = [self removeSubString:@"-"];
    }
    NSString *regex = @"^(0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:str];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

- (NSString *)md5 {
    NSString *md5string = [NSString string];
    const char *cStr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)[self length], buffer);
    
    int i;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        md5string = [md5string stringByAppendingString:[NSString stringWithFormat:@"%02x", buffer[i]]];
    
    return md5string;
}


+(NSString *)ageFromDateString:(NSString *)dateString{
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    
    NSInteger birthdayYear = [[dateString substringToIndex:4] integerValue];
    
    NSString *age = [NSString stringWithFormat:@"%zd岁", year - birthdayYear];
    
    return age;
}

+ (CGFloat)stringHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing {
    if (![text isValid]) {
        NSLog(@"无效字符串");
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName:[UIFont fontWithName:@"" size:fontSize],
                                 };
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return textSize.height;
}

+ (NSArray *)imagesArrayFromString:(NSString *)arrayString
{
    if (strIsEmpty(arrayString)) {
        return nil;
    }
    
    if (![arrayString containsString:@","]) {
        return @[arrayString];
    }
    
    return [arrayString componentsSeparatedByString:@","];
}

+(NSString *)stringFromDateYYMM:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateAndHHmm:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateAndHHmm:(NSDate *)date withHHmm:(NSString *)HHmmStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:date],HHmmStr];
    return destDateString;
    
}

+(NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateMMdd:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateFormatterWithyyyyMMddhhmmss:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateSp:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithyyyyMMdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+ (NSString *)stringFromDateFormatterWithyyyyMM:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithMMddHHmm:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithMM:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithyyyy:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)stringFromDateFormatterWithMMdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateWithWeekSp:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday |NSCalendarUnitWeekday)
                                         fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    switch (weekday) {
        case 1:
        {
            return @"周日";
        }
            break;
        case 2:
        {
            return @"周一";
        }
            break;
        case 3:
        {
            return @"周二";
        }
            break;
        case 4:
        {
            return @"周三";
        }
            break;
        case 5:
        {
            return @"周四";
        }
            break;
        case 6:
        {
            return @"周五";
        }
            break;
        case 7:
        {
            return @"周六";
        }
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *)intervalSinceNow:(NSString *) theDate
{
    NSDateFormatter*date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha= now-late;
    
    //发表在一小时之内
    if(cha/3600<1) {
        if(cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    
    //在一小时以上24小以内
    else if(cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    //发表在24以上10天以内
    else if(cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    
    //发表时间大于10天
    else
    {
        /*
         NSArray*array = [theDate componentsSeparatedByString:@" "];
         timeString = [array objectAtIndex:0];
         timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
         */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"MM月dd日 HH:mm"];
        timeString = [formatter stringFromDate:d];
    }
    return timeString;
}

+(NSDate*) convertDateFromString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

+ (NSDate *)convertDateFromyyyyMMddhhmmssString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

//判断是否为整形：
+ (BOOL)isPureIntValue:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为含中文：
+ (BOOL)isHasChineseWithStr:(NSString *)str {
    
    for(int i=0; i< [str length];i++){
        
        int a = [str characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff)
            
        {
            return YES;
        }
    }
    return NO;
    
}

//判断是否为浮点形：
+ (BOOL)isPureFloatValue:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile {
    
    /*
     //手机号以13， 15，18开头，八个 \d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     //    NSLog(@"phoneTest is %@",phoneTest);
     return [phoneTest evaluateWithObject:mobile];
     */
    
    if (![mobile isValid]) {
        return NO;
    }
    
    
    if (![NSString isPureIntValue:mobile]) {
        return NO;
    }
    
    
    if (11 != mobile.length) {
        return NO;
    }
    
    if (![mobile isBeginsWith:@"1"]) {
        return NO;
    }
    
    return YES;
}

+ (BOOL) isValidatePassWord:(NSString *)password{
    
    if (![password isValid]) {
        return NO;
    }
    
    if ([NSString isHasChineseWithStr:password]) {
        return NO;
    }
    
    if (password.length <8 || password.length > 12) {
        return NO;
    }
    
    return YES;
}

//转换按KB转
+ (NSString *) changeStrSizWithKB:(NSInteger)size{
    
    NSString * strSize;
    NSInteger totalMBRead = size;
        
    NSString * nowSize = [NSString stringWithFormat:totalMBRead/1024.0>1?@"%.2fM":@"%.2fK",totalMBRead/1024.0>1?totalMBRead/1024.0:totalMBRead];
    totalMBRead == 0 ? (strSize = @"0K") : (strSize = nowSize);
    
    return  strSize;
}

//转换按B转
+ (NSString *) changeStrSizWithB:(NSInteger)size{
    
    NSString * strSize;
    NSInteger totalMBRead = size / 1024;

    
    NSString * nowSize = [NSString stringWithFormat:totalMBRead/1024.0>1?@"%.2fM":@"%.2fK",totalMBRead/1024.0>1?totalMBRead/1024.0:totalMBRead];
    
    totalMBRead == 0 ? (strSize = @"0K") : (strSize = nowSize);
    
    if (size < 1024) {
        NSString * sizeinterger = [NSString stringWithFormat:@"%ld",(long)size];
        float sizeFloat = [sizeinterger floatValue] / 1024.0;
        strSize = [NSString stringWithFormat:@"%.2fK",sizeFloat];
    }
    
    return  strSize;
}

@end

@interface NSString (Base64)

+ (NSString *)_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)_base64EncodedString;
- (NSString *)_base64DecodedString;
- (NSData *)_base64DecodedData;

@end
@interface NSData (Base64)

+ (NSData *)_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)_base64EncodedString;

@end
@implementation NSString (BlockHelper)

- (NSString *(^)())add {
    NSString * (^ result)(NSString *) = ^(NSString *input) {
        NSString *output = nil;
        
        if ([input isKindOfClass:[NSString class]] || [input isKindOfClass:[NSNumber class]]) {
            output = [NSString stringWithFormat:@"%@%@", self, input];
        }
        
        return output;
    };
    
    return result;
}

- (NSString *(^)(NSString *, ...))addFormat {
    NSString * (^ result)(NSString *, ...) = ^(NSString *format, ...) {
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        return self.add(statement);
    };
    
    return result;
}

- (NSString *(^)(NSInteger))addInt {
    NSString * (^ result)(NSInteger) = ^(NSInteger input) {
        NSString *output = nil;
        output = [NSString stringWithFormat:@"%@%zd", self, input];
        return output;
    };
    
    return result;
}

- (NSString *(^)(CGFloat))addFloat {
    NSString * (^ result)(CGFloat) = ^(CGFloat input) {
        NSString *output = nil;
        output = [NSString stringWithFormat:@"%@%f", self, input];
        return output;
    };
    
    return result;
}

- (NSInteger (^)(NSString *))indexOf {
    NSInteger (^ result)(NSString *) = ^(NSString *input) {
        NSInteger output = NSNotFound;
        output = [self rangeOfString:input].location;
        return output;
    };
    return result;
}

- (BOOL (^)(NSString *))isContains {
    BOOL (^ result)(NSString *) = ^BOOL (NSString *input) {
        return self.indexOf(input) != NSNotFound;
    };
    return result;
}

- (NSString *(^)(NSString *, NSString *))replace {
    NSString * (^ result)(NSString *, NSString *) = ^(NSString *targetString, NSString *withString) {
        NSString *output = [self stringByReplacingOccurrencesOfString:targetString withString:withString];
        return output;
    };
    
    return result;
}

- (BOOL (^)(NSString *))isEqualTo {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^(NSString *input) {
        return [originString isEqualToString:input];
    };
    return result;
}

- (BOOL (^)(NSString *))isEqualToIgnoreCase {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^BOOL (NSString *input) {
        return [originString compare:input options:NSCaseInsensitiveSearch] == NSOrderedSame;
    };
    return result;
}

- (BOOL (^)())isEmail {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        return originString.isMatch(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}");
    };
    return result;
}

- (BOOL (^)())isURL {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        NSString *string = @"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.[a-zA-Z]{2,4})(\\:[0-9]+)?(/[^/][a-zA-Z0-9\\.\\,\?\'\\/\\+&amp;%\\$#\\=~_\\-@]*)*$";
        return originString.isMatch(string);
    };
    return result;
}

- (BOOL (^)())isCellPhoneNumber {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        //TODO: add specific regex string
        return originString.isMatch(@"[1][0-9]{10}");
    };
    return result;
}

- (BOOL (^)())isNumber {
    BOOL (^ result)() = ^() {
        BOOL isValid = NO;
        NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
        isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
        return isValid;
    };
    return result;
}

- (BOOL (^)())isIntegerNumber {
    BOOL (^result)() = ^() {
        return self.isMatch(@"[1-9][0-9]+");
    };
    return result;
}

- (BOOL (^)())isDecimalNumber {
    BOOL (^result)() = ^ () {
        BOOL output = NO;
        NSArray *splits = [self componentsSeparatedByString:@"."];
        if (splits.count == 2) {
            NSString *integer = splits[0];
            NSString *decimals = splits[1];
            output = integer.isIntegerNumber() && decimals.isNumber();
        }else if (splits.count == 1) {
            output = self.isIntegerNumber();
        }
        return output;
    };
    return result;
}

- (BOOL (^)(NSString *))isMatch {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^(NSString *regexString) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
        return [predicate evaluateWithObject:originString];
    };
    return result;
}

- (NSString *(^)())strim {
    NSString * (^ result)() = ^() {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    };
    
    return result;
}

- (NSString *(^)())urlEncode {
    NSString * (^ result)() = ^() {
        return [self _urlEncode];
    };
    
    return result;
}

- (NSString *(^)())urlDecode {
    NSString * (^ result)() = ^() {
        return [self _urlDecode];
    };
    
    return result;
}

- (NSDictionary *(^)())paramsInUrl {
    NSDictionary * (^ result)() = ^() {
        NSMutableDictionary *output = [NSMutableDictionary new];
        NSArray *params = [self componentsSeparatedByString:@"?"];
        
        if (params.count > 1) {
            NSString *paramsString = params[1];
            NSArray *components = [paramsString componentsSeparatedByString:@"&"];
            
            for (NSString *component in components) {
                NSInteger index = component.indexOf(@"=");
                if (index != NSNotFound) {
                    output[[component substringToIndex:index]] = [component substringFromIndex:index+1];
                }else {
                    output[component] = @"";
                }
            }
        }
        
        return output;
    };
    
    return result;
}

- (NSString *(^)(NSString *))paramInUrlWithKey {
    NSString * (^ result)(NSString *) = ^(NSString *key) {
        return self.paramsInUrl()[key];
    };
    
    return result;
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *(^)())base64EncodedString {
    NSString *(^result)() = ^ (){
        NSString *output = [self _base64EncodedString];
        return output;
    };
    return result;
}

- (NSString *(^)())base64DecodedString {
    NSString *(^result)() = ^ (){
        NSString *output = [self _base64DecodedString];
        return output;
    };
    return result;
}

- (NSData *(^)())base64DecodedData {
    NSData *(^result)() = ^ (){
        NSData *output = [self _base64DecodedData];
        return output;
    };
    return result;
}

#pragma mark - helper
- (NSString *)_urlEncode {
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)_urlDecode {
    return [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

@end

@implementation NSData (Base64)

+ (NSData *)_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
        
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
        
#endif
        
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)_base64EncodedString
{
    return [self _base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (Base64)

+ (NSString *)_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData _dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedString];
}

- (NSString *)_base64DecodedString
{
    return [NSString _stringWithBase64EncodedString:self];
}

- (NSData *)_base64DecodedData
{
    return [NSData _dataWithBase64EncodedString:self];
}

@end

@implementation NSAttributedString (ParagraphStyle)

+ (CGFloat)contentHeightWithText:(NSString *)text
                           width:(CGFloat)width
                        fontSize:(CGFloat)fontSize
                     lineSpacing:(CGFloat)lineSpacing {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                                 };
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height);
    
    return height;
}

@end

@implementation NSString (ImageURL)

// exam http://f.10333.com/fd37e4e854ee.jpg     原图
// exam http://f.10333.com/fd37e4e854ee_.jpg    标清图
// exam http://f.10333.com/fd37e4e854ee_1.jpg   大缩略图
// exam http://f.10333.com/fd37e4e854ee_2.jpg   小缩略图
/*
 流程 1 判断是url
     2 过滤掉之前的后缀
     3 按需求添加后缀
 */
- (NSString *)thumbUrlWithDPIType:(WPImageURLDPIType)type {
    NSString *thumbUrl = nil;
    if ([self isImageURL]) {
        NSString *resource = [self urlFilterToResource];
        thumbUrl = [resource urlStrAddStr:[[self thumbNailSuffixs] objectAtIndex:type]];
    }
    return thumbUrl;
}

// 1.同大小品质降低缩略图,生成规则:原图片名称+_+.图片类型
- (NSString *)thumbUrlSameDpi {
    return [self thumbUrlWithDPIType:WPImageURLDPIHigh];
}

// 2.400*400缩略图,生成规则:原图片名称+_1+.图片类型
- (NSString *)thumbUrlMiddleDpi {
    return [self thumbUrlWithDPIType:WPImageURLDPIMiddle];
}

// 3.100*100缩略图,生成规则:原图片名称+_2+.图片类型
- (NSString *)thumbUrlSmallDpi {
    return [self thumbUrlWithDPIType:WPImageURLDPISmall];
}

- (NSString *)urlStrAddStr:(NSString *)str {
    NSString *pathExtension = [self pathExtension];
//    NSString *preFix = @"http://";
//    NSString *urlStr = [[[self componentsSeparatedByString:preFix] lastObject] stringByDeletingPathExtension];
    NSString *urlStr = [self substringToIndex:self.length - (pathExtension.length + 1)];
    NSString *url = [[NSString stringWithFormat:@"%@%@",urlStr,str] stringByAppendingPathExtension:pathExtension];
    return url;
}

- (BOOL)isImageURL { // 验证URL "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
//    return [self isValid] && [self hasPrefix:@"http://"]; //  && ([self hasSuffix:@".jpg"] || [self hasSuffix:@".png"])
    return [self validateIsValidURL];
}

//验证字符串是合法的url
-(BOOL)validateIsValidURL{
    NSString *regex = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (NSString *)urlFilterToResource {
    NSString *pathExtension = [self pathExtension];
   // NSString *preFix = @"http://";
   // NSString *urlWithOutPathExtension = [[[self componentsSeparatedByString:preFix] lastObject] stringByDeletingPathExtension];
   // NSString *urlWithOutPathExtension = [self stringByDeletingPathExtension];
    NSString *urlWithOutPathExtension = [self substringToIndex:self.length - (pathExtension.length + 1)];
    for (NSString *suffix in [self thumbNailSuffixs]) {
        if ([urlWithOutPathExtension hasSuffix:suffix]) {
            urlWithOutPathExtension = [urlWithOutPathExtension deleteSuffix:suffix];
            break;
        }
    }
    return [NSString stringWithFormat:@"%@",[urlWithOutPathExtension stringByAppendingPathExtension:pathExtension]];
}

- (NSArray *)thumbNailSuffixs { //
    return @[@"_",@"_1",@"_2",@""];
}

- (NSString *)deleteSuffix:(NSString *)suffix {
    return [self stringByReplacingCharactersInRange:NSMakeRange(self.length - suffix.length, suffix.length) withString:@""];
}

@end


