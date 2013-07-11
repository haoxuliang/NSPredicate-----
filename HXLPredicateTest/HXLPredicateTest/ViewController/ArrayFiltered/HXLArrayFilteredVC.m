//
//  HXLArrayFilteredVC.m
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//


#import "HXLArrayFilteredVC.h"

@interface HXLArrayFilteredVC ()

@end

@implementation HXLArrayFilteredVC

#pragma mark - <------ Init ------>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"字符串数组过滤";
    isIgnoreCase = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    [_arrOriginal release];
    [_arrMuOriginal release];
    
    [_segmentedControl release];
    [_textViewOriginal release];
    [_textViewFiltered release];
    [_textFieldContain release];
    [_textFieldBegin release];
    [_textFieldEnd release];
    [_textFieldLike release];
    [_scrollView release];
    [_textFieldEqual release];
    [_textFieldIn release];
    [super dealloc];
}

#pragma mark - <------ Supper ------>
-(void)setDataForVC
{
    _arrOriginal = [[NSArray alloc] initWithObjects:@"name",@"haoxuliang",@"begin",@"come",@"go",@"school",@"student",@"teacher",@"home",@"hospital",@"predicate",@"build",@"full",@"dictionary",@"test", nil];
    _arrMuOriginal = [[NSMutableArray alloc] initWithArray:_arrOriginal];
    
    _textViewOriginal.text = [self getStringWithArray:_arrOriginal];
}


#pragma mark - <------ Private ------>
-(NSString *)getStringWithArray:(NSArray *)array
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in array) {
        if ([string length] == 0) {
            [string appendFormat:@"{ %@",str];
        }else{
            [string appendFormat:@" , %@",str];
        }
    }
    if (string.length > 0) {
        [string appendString:@" }"];
    }
    return string;
}

-(void)setOtherTextFieldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField != _textFieldContain) {
        _textFieldContain.text = @"";
    }
    if (textField != _textFieldBegin) {
        _textFieldBegin.text = @"";
    }
    if (textField != _textFieldEnd) {
        _textFieldEnd.text = @"";
    }
    if (textField != _textFieldLike) {
        _textFieldLike.text = @"";
    }
    if (textField != _textFieldEqual) {
        _textFieldEqual.text = @"";
    }
    if (textField != _textFieldIn) {
        _textFieldIn.text = @"";
    }
}

#pragma mark -  <------ 备注开始 ------>
/**
 过滤数组方法有二：
 1、NSArray *newArray = [originalArray filteredArrayUsingPredicate:_predicate];
 2、[_arrMuOriginal filterUsingPredicate:_predicate];
 
 这两个方法有一定区别
 第一个方法，是过滤原数组，生成一个新数组，NSArray，NSMutableArray都可以使用
 第二个方法，在原数组上过滤，直接改变了原数组。只适用于NSMutableArray，因为，NSArray内数据是不可变的。
 */

/**
 关于SELF
 
 当数组成员是字符串组时，写谓词表达式时，用SELF
 */
#pragma mark -  <------ 备注结束 ------>

#pragma mark - <------ IBAction ------>
//UISegmentedControl,   change value
- (IBAction)ignoreCase:(UISegmentedControl*)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        isIgnoreCase = NO;
    }else{
        isIgnoreCase = YES;
    }
}

//处理数组，包含指定字符
- (IBAction)containString:(id)sender {
    if (_textFieldContain.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldContain];
    
    //处理数组
//    NSPredicate *predicate;
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",_textFieldContain.text];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",_textFieldContain.text];
    }

    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}

//处理数组，以指定字符开始
- (IBAction)beginWithString:(id)sender {
    if (_textFieldBegin.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldBegin];
    
    //处理数组
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",_textFieldBegin.text];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@",_textFieldBegin.text];
    }
    
    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}

//处理数组，以指定字符结束
- (IBAction)endWithString:(id)sender {
    if (_textFieldEnd.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldEnd];
    
    //处理数组
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH[c] %@",_textFieldEnd.text];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH %@",_textFieldEnd.text];
    }
    
    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}

//处理数组，相似
- (IBAction)likeString:(id)sender {
    if (_textFieldLike.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldLike];
    
    //处理数组
    //处理数组
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF LIKE[c] %@", [NSString stringWithFormat:@"*%@*",_textFieldLike.text]];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF LIKE %@", [NSString stringWithFormat:@"*%@*",_textFieldLike.text]];
    }
    
    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}

//处理数组，相等
- (IBAction)equalString:(id)sender {
    if (_textFieldEqual.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldEqual];
    
    /**
     比较运算符>,<,==
     可用于 数值 及 字符串
     */
    //处理数组
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF ==[c] %@", _textFieldEqual.text];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF == %@", _textFieldEqual.text];
    }
    
    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}

- (IBAction)inStrings:(id)sender {
    if (_textFieldIn.text.length == 0) {
        return;
    }
    [self setOtherTextFieldClear:_textFieldIn];
    
    
//    //处理数组
//    if (isIgnoreCase) {
//        _predicate = [NSPredicate predicateWithFormat:@"SELF IN[c] %@",[NSString stringWithFormat:@"{%@}", _textFieldIn.text]];
//    }else{
//        _predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", [NSString stringWithFormat:@"{%@}", _textFieldIn.text]];
////        _predicate = [NSPredicate predicateWithFormat:@"SELF IN {'name','tests','go','come'}"];//单词间用 “,”隔开
////        _predicate = [NSPredicate predicateWithFormat:@"SELF IN {'name' 'tests' 'go' 'come'}"];//单词间用 “ ”隔开
//    }
    
    NSArray *arr = [_textFieldIn.text componentsSeparatedByString:@" "];
    
    //处理数组
    if (isIgnoreCase) {
        _predicate = [NSPredicate predicateWithFormat:@"SELF IN[c] %@",arr];
    }else{
        _predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", arr];
    }

    
    _arrFiltered = [_arrOriginal filteredArrayUsingPredicate:_predicate];
    
    //展示处理后数据
    _textViewFiltered.text = [self getStringWithArray:_arrFiltered];
}



- (IBAction)hiddenKeyBoard:(id)sender {
    [_textFieldIn resignFirstResponder];
    [_textFieldBegin resignFirstResponder];
    [_textFieldContain resignFirstResponder];
    [_textFieldEnd resignFirstResponder];
    [_textFieldLike resignFirstResponder];
    [_textFieldEqual resignFirstResponder];
}

#pragma mark - <------ UITextFieldDelegate ------>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _textFieldContain) {
        [self containString:nil];
    }else if (textField == _textFieldBegin) {
        [self beginWithString:nil];
    }else if (textField == _textFieldEnd) {
        [self endWithString:nil];
    }else if (textField == _textFieldLike) {
        [self likeString:nil];
    }else if (textField == _textFieldEqual) {
        [self equalString:nil];
    }else if (textField == _textFieldIn) {
        [self inStrings:nil];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _textFieldContain) {
        [_scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
    }else if (textField == _textFieldBegin) {
        [_scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    }else if (textField == _textFieldEnd) {
        [_scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField == _textFieldLike) {
        [_scrollView setContentOffset:CGPointMake(0, 135) animated:YES];
    }else if(textField == _textFieldEqual){
        [_scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
    }
}

@end
