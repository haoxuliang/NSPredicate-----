//
//  HXLBaseVC.m
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import "HXLBaseVC.h"

@interface HXLBaseVC ()

@end

@implementation HXLBaseVC

#pragma mark - Private
//为当前类初始化数据
-(void)setDataForVC
{}
//设置视图
-(void)setMainView
{}

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:253.0/225.0 blue:255.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:25.00/225.00 green:133.00/225.00 blue:144.00/225.00 alpha:1.0];

    //为当前类初始化数据
    [self setDataForVC];
    
    //设置视图
    [self setMainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
