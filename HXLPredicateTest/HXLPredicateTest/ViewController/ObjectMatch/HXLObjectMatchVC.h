//
//  HXLObjectMatchVC.h
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLObjectMatchVC : HXLBaseVC <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UITextView *textViewOriginal;
@property (retain, nonatomic) IBOutlet UITextView *textViewFiltered;


@property (retain, nonatomic) IBOutlet UITextField *textFieldNameEqual;
@property (retain, nonatomic) IBOutlet UITextField *textFieldAgeMoreThan;
@property (retain, nonatomic) IBOutlet UITextField *textFieldAgeLessThan;


@property (retain, nonatomic) NSPredicate *predicate;
@property (retain ,nonatomic) NSMutableArray *arrPeople;
@property (retain, nonatomic) NSString *strRegex;
@property (retain, nonatomic) NSString *strInput;


@end
