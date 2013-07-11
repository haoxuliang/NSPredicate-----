//
//  HXLObjectMatchVC.m
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import "HXLObjectMatchVC.h"
#import "HXLPerson.h"

@interface HXLObjectMatchVC ()

@end

@implementation HXLObjectMatchVC

#pragma mark - <------ Supper ------>
-(void)setDataForVC
{
    _arrPeople = [[NSMutableArray alloc] initWithCapacity:4];
    
    HXLPerson *person = [[HXLPerson alloc] init];
    [person setName:@"Hao Xuliang"];
    [person setAge:30];
    [_arrPeople addObject:person];
    [person release];
    
    HXLPerson *person1 = [[HXLPerson alloc] init];
    [person1 setName:@"Wang Weiqian"];
    [person1 setAge:28];
    [_arrPeople addObject:person1];
    [person1 release];
    
    HXLPerson *person2 = [[HXLPerson alloc] init];
    [person2 setName:@"Li Mei"];
    [person2 setAge:38];
    [_arrPeople addObject:person2];
    [person2 release];
    
    HXLPerson *person3 = [[HXLPerson alloc] init];
    [person3 setName:@"Jiang Heshuang"];
    [person3 setAge:23];
    [_arrPeople addObject:person3];
    [person3 release];
}

-(void)setMainView
{
    _textViewOriginal.text = [self getStringWithPersonArray:_arrPeople];
}

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
    self.navigationItem.title = @"对象数组的匹配";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_arrPeople release];
    [_textViewOriginal release];
    [_textViewFiltered release];
    [_textFieldNameEqual release];
    [_textFieldAgeMoreThan release];
    [_textFieldAgeLessThan release];
    [_scrollView release];
    [super dealloc];
}

#pragma mark - <------ Private ------>
-(NSString *)getStringWithPersonArray:(NSArray *)array
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (HXLPerson *p in array) {
        [string appendFormat:@"Name = %@,   age = %d\n",p.name,p.age];
    }
    return string;
}

#pragma mark - <------ 备注开始 ------>

/**
 比较运算符（>,<,==,）可以运用于 字符串 和 数字 的匹配中
 */

#pragma mark - <------ 备注结束 ------>

#pragma mark - <------ IBAction ------>
- (IBAction)nameEqual:(id)sender {
    [_textFieldNameEqual resignFirstResponder];
    _strInput = _textFieldNameEqual.text;
    
    //方法一
////    _predicate = [NSPredicate predicateWithFormat:@"name >[c] %@",_strInput];
////    _predicate = [NSPredicate predicateWithFormat:@"name <[c] %@",_strInput];
////    _predicate = [NSPredicate predicateWithFormat:@"name ==[c] %@",_strInput];
//    _predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",_strInput];
//    _textViewFiltered.text = [self getStringWithPersonArray:[_arrPeople filteredArrayUsingPredicate:_predicate]];
    
    //方法二
    NSDictionary *dic = [NSDictionary dictionaryWithObject:_strInput forKey:@"Name"];
    NSPredicate *bufferPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] $Name"];
    _predicate = [bufferPredicate predicateWithSubstitutionVariables:dic];
    
    //结果
    _textViewFiltered.text = [self getStringWithPersonArray:[_arrPeople filteredArrayUsingPredicate:_predicate]];
}

- (IBAction)ageMoreThan:(id)sender {
    [_textFieldAgeMoreThan resignFirstResponder];
    _strInput = _textFieldAgeMoreThan.text;
    _predicate = [NSPredicate predicateWithFormat:@"age>%d",[_strInput intValue]];
    _textViewFiltered.text = [self getStringWithPersonArray:[_arrPeople filteredArrayUsingPredicate:_predicate]];
}

- (IBAction)ageLessThan:(id)sender {
    [_textFieldAgeLessThan resignFirstResponder];
    _strInput = _textFieldAgeLessThan.text;
    _predicate = [NSPredicate predicateWithFormat:@"age<%d",[_strInput intValue]];
    _textViewFiltered.text = [self getStringWithPersonArray:[_arrPeople filteredArrayUsingPredicate:_predicate]];
}

- (IBAction)complexFilter:(id)sender {
    _predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ AND age>%d AND age<%d",_textFieldNameEqual.text,[_textFieldAgeMoreThan.text intValue],[_textFieldAgeLessThan.text intValue]];
    _textViewFiltered.text = [self getStringWithPersonArray:[_arrPeople filteredArrayUsingPredicate:_predicate]];
}

- (IBAction)hiddenKeybarod:(id)sender {
    [_textFieldNameEqual resignFirstResponder];
    [_textFieldAgeMoreThan resignFirstResponder];
    [_textFieldAgeLessThan resignFirstResponder];
}

#pragma mark - <------ UITextFieldDelegate ------>
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _textFieldNameEqual) {
        [_scrollView setContentOffset:CGPointMake(0, 10) animated:YES];
    }else if (textField == _textFieldAgeMoreThan) {
        [_scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }else if (textField == _textFieldAgeLessThan) {
        [_scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _textFieldNameEqual) {
        [self nameEqual:nil];
    }else if (textField == _textFieldAgeMoreThan) {
        [self ageMoreThan:nil];
    }else if (textField == _textFieldAgeLessThan) {
        [self ageLessThan:nil];
    }
    
    return YES;
}

@end
