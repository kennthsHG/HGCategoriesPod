//
//  UIViewController+NoInformation.h
//  HGCategoriesPod
//
//  Created by HuangGang on 2019/11/11.
//  Copyright © 2019年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NoInformation)

@property (nonatomic , assign , getter=hasNoInformation) BOOL noInformation;
@property (nonatomic , copy) NSString *informationText;
@property (nonatomic , strong , readonly) UIView *tipView;
@property (nonatomic , strong , readonly) UILabel *informationLabel;
@end
