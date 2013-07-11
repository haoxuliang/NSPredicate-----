//
//  HXLRootVC.h
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXLRootVC : HXLBaseVC <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;



@property (retain, nonatomic) NSMutableArray *arrType;
@property (retain, nonatomic) NSMutableDictionary *dicVC;


@end
