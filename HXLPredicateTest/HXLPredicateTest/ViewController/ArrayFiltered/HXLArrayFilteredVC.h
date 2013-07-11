//
//  HXLArrayFilteredVC.h
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLArrayFilteredVC : HXLBaseVC <UITextFieldDelegate> {
    BOOL isIgnoreCase;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (retain, nonatomic) IBOutlet UITextView *textViewOriginal;
@property (retain, nonatomic) IBOutlet UITextView *textViewFiltered;

@property (retain, nonatomic) IBOutlet UITextField *textFieldContain;
@property (retain, nonatomic) IBOutlet UITextField *textFieldBegin;
@property (retain, nonatomic) IBOutlet UITextField *textFieldEnd;
@property (retain, nonatomic) IBOutlet UITextField *textFieldLike;
@property (retain, nonatomic) IBOutlet UITextField *textFieldEqual;
@property (retain, nonatomic) IBOutlet UITextField *textFieldIn;



@property (retain ,nonatomic) NSPredicate *predicate;
@property (retain ,nonatomic) NSArray *arrOriginal;
@property (retain ,nonatomic) NSMutableArray *arrMuOriginal;

@property (retain ,nonatomic) NSArray *arrFiltered;
//@property (retain ,nonatomic) NSMutableArray *arrMuFiltered;

@end
