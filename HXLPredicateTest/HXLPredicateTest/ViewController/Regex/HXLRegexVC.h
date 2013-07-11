//
//  HXLRegexVC.h
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLRegexVC : HXLBaseVC <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (retain, nonatomic) IBOutlet UITextField *textFieldMobile;
@property (retain, nonatomic) IBOutlet UITextField *textFieldPersonID;
@property (retain, nonatomic) IBOutlet UITextField *textFieldChinese;
@property (retain, nonatomic) IBOutlet UITextField *textFieldUrl;

@property (retain, nonatomic) NSString *strRegex;
@property (retain, nonatomic) NSString *strInput;

@property (retain, nonatomic) NSPredicate *predicate;



@end
