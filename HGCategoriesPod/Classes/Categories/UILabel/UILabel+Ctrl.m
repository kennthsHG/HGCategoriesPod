//
//  UILabel+Ctrl.m
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import "UILabel+Ctrl.h"
#import <objc/runtime.h>

static char responseKey;

@interface UILabel ()

- (NSMutableAttributedString *)attributedString;

@end


@implementation UILabel (Ctrl)

#pragma mark - Public methods
//针对NSRange设置属性
- (void)setAttribute:(NSString *)name value:(id)value range:(NSRange)range
{
    if(range.location > [self.text length] || range.length > [self.text length])
    {
        return;
    }
    
    NSMutableAttributedString *attributed = [self attributedString];
    
    [attributed addAttribute:name value:value range:range];
    
    self.attributedText = attributed;
}

//针对内容设置属性
- (void)setAttribute:(NSString *)name value:(id)value SubStr:(id)str
{
    
    NSInteger index = 0;
    NSRange range = [self.text rangeOfString:str];
    NSMutableArray* rangeArray = [[NSMutableArray alloc] init];
    
    //搜索所有满足条件的字符区间
    while (range.length > 0)
    {
        index += range.location;
        [rangeArray addObject:[NSValue valueWithRange:NSMakeRange(index, range.length)]];
        
        index += range.length;
        NSString* nextStr = [self.text substringFromIndex:index];
        range = [nextStr rangeOfString:str];
    }
    
    //设置属性
    for(NSValue* rangeValue in rangeArray)
    {
        [self setAttribute:name value:value range:[rangeValue rangeValue]];
    }
}

- (void)setBoldFontToRange:(NSRange)range
{
    NSString *fontNameBold = [NSString stringWithFormat:@"%@-Bold",
                              [[self.font familyName] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if (![UIFont fontWithName:fontNameBold size:self.font.pointSize]) {
#ifdef NZDEBUG
        NSLog(@"%s: Font not found: %@", __PRETTY_FUNCTION__, fontNameBold);
#endif
        return;
    }
    
    UIFont *font = [UIFont fontWithName:fontNameBold size:self.font.pointSize];
    
    NSMutableAttributedString *attributed = [self attributedString];
    [attributed addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = attributed;
}

- (void)setBoldFontToString:(NSString *)str
{
    NSInteger index = 0;
    NSRange range = [self.text rangeOfString:str];
    NSMutableArray* rangeArray = [[NSMutableArray alloc] init];
    
    //搜索所有满足条件的字符区间
    while (range.length > 0)
    {
        index += range.location;
        [rangeArray addObject:[NSValue valueWithRange:NSMakeRange(index, range.length)]];
        
        index += range.length;
        NSString* nextStr = [self.text substringFromIndex:index];
        range = [nextStr rangeOfString:str];
    }
    
    //设置属性
    for(NSValue* rangeValue in rangeArray)
    {
        [self setBoldFontToRange:[rangeValue rangeValue]];
    }
}

#pragma mark -
#pragma mark - Private methods

- (NSMutableAttributedString *)attributedString
{
    return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
}

- (CGSize)attributeSize
{
    CGSize rcSize = CGSizeZero;
    if(0 == self.numberOfLines)
    {
        rcSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    }
    else
    {
        rcSize = CGSizeMake(MAXFLOAT, self.frame.size.height);
    }
    
    CGRect rc = [self.attributedString boundingRectWithSize:rcSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    return rc.size;
}

- (void)setTouchResponse:(TouchResponse)touch
{
    objc_setAssociatedObject(self, &responseKey, touch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma UIViewDelegate
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    
    TouchResponse response = objc_getAssociatedObject(self, &responseKey);
    //实现点击方法: 用数组存储每次设置的属性 可以求出每段设置的内容的区域(Rc)再判断点击位置
    NSMutableArray*array = [self getSubAttributeArray];
    
    if(1 == self.numberOfLines)
    {
        CGSize size = [self attributeSize];
        CGFloat off_y = (self.frame.size.height - size.height)/2.f;
        
        NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc] init];
        for(NSInteger i = 0; i < array.count; i++)
        {
            NSDictionary* subAttributeDic = [array objectAtIndex:i];
            NSMutableAttributedString* subAttribute =  [subAttributeDic objectForKey:@"Attribute"];
            NSRange subRange = NSRangeFromString([subAttributeDic objectForKey:@"Range"]);
            
            [attribute appendAttributedString:subAttribute];
            
            CGRect rc1 = [attribute boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine context:nil];
            rc1.origin.y = off_y;
            
            if(CGRectContainsPoint(rc1, pt))
            {
                response([subAttribute string],subRange);
                return;
            }
        }
    }
    else
    {
        CGSize size = [self attributeSize];
        NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc] init];

        CGFloat off_x = (self.frame.size.width - size.width)/2.f;
        CGFloat off_y = (self.frame.size.height - size.height)/2.f;
        CGFloat ptX = pt.x;
        NSInteger numIndex = 0;
        CGFloat height = 0;
        for(NSInteger i = 0; i < array.count; i++)
        {
            NSDictionary* subAttributeDic = [array objectAtIndex:i];
            NSMutableAttributedString* subAttribute =  [subAttributeDic objectForKey:@"Attribute"];
            NSRange subRange = NSRangeFromString([subAttributeDic objectForKey:@"Range"]);
            
            [attribute appendAttributedString:subAttribute];
            //获得1行时的总长度
             CGRect rc = [attribute boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
            //多行区域
            CGRect rc1 = [attribute boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
            rc1.origin.y = off_y;
            rc1.origin.x = off_x;
            
            //计算行数(0行起)
            if(pt.y > height + off_y)
            {
                numIndex = rc.size.width/size.width;
            }
            height = rc1.size.height;
            
            ptX = pt.x + (numIndex*(size.width)) - (self.frame.size.width - size.width)/2.f;
            
            if(CGRectContainsPoint(rc1, pt) && ptX < rc.size.width)
            {
                response([subAttribute string],subRange);
                return;
            }
        }

    }
}

- (NSMutableArray*)getSubAttributeArray
{
    NSInteger len = [self.attributedString length];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger startIndex = 0;
    
    for (NSInteger i = 1; i < len; i++)
    {
        NSDictionary* subAttribute = [self.attributedString  attributesAtIndex:i - 1 effectiveRange:nil];
        NSDictionary* subAttributeNext = [self.attributedString  attributesAtIndex:i effectiveRange:nil];
        
        if(![subAttribute isEqualToDictionary:subAttributeNext])
        {
            NSAttributedString* subAttribute = [self.attributedString  attributedSubstringFromRange:NSMakeRange(startIndex, i - startIndex)];
            NSString* rangeStr = NSStringFromRange(NSMakeRange(startIndex, i - startIndex));
            
            NSDictionary* subAttributeDic = [NSDictionary dictionaryWithObjectsAndKeys:subAttribute,@"Attribute",rangeStr,@"Range", nil];
            [array addObject:subAttributeDic];
            startIndex = i;
        }
        
        if(i == len -1)
        {
            NSAttributedString* subAttribute = [self.attributedString  attributedSubstringFromRange:NSMakeRange(startIndex, i - startIndex + 1)];
            NSString* rangeStr = NSStringFromRange(NSMakeRange(startIndex, i - startIndex + 1));
            
             NSDictionary* subAttributeDic = [NSDictionary dictionaryWithObjectsAndKeys:subAttribute,@"Attribute",rangeStr,@"Range", nil];
            [array addObject:subAttributeDic];
        }
    }
    
    return array;
}

@end
