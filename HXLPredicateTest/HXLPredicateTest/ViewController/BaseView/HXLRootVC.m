//
//  HXLRootVC.m
//  HXLPredicateTest
//
//  Created by LeoHao on 13-5-31.
//  Copyright (c) 2013年 LeoHao. All rights reserved.
//

#import "HXLRootVC.h"
#import "HXLArrayFilteredVC.h"
#import "HXLRegexVC.h"
#import "HXLObjectMatchVC.h"

@interface HXLRootVC ()

@end

@implementation HXLRootVC


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
    //设置标题
    self.navigationItem.title = @"NSPredicate功能测试";
//    [_tableView setEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    
    [_arrType release];
    [_dicVC release];
    [super dealloc];
}

#pragma mark - <------ Supper ------>
//为当前类初始化数据
-(void)setDataForVC
{
    _arrType = [[NSMutableArray alloc] initWithCapacity:4];
    [_arrType addObject:@"字符串数组过滤"];
    [_arrType addObject:@"正则表达式"];
    [_arrType addObject:@"对象数组的匹配"];
    
    
    _dicVC = [[NSMutableDictionary alloc] initWithCapacity:_arrType.count];
    
    HXLArrayFilteredVC *arraryFilterVC = [[HXLArrayFilteredVC alloc] initWithNibName:@"HXLArrayFilteredVC" bundle:nil];
    [_dicVC setValue:arraryFilterVC forKey:@"字符串数组过滤"];
    [arraryFilterVC release];

    
    HXLRegexVC *regexVC = [[HXLRegexVC alloc] initWithNibName:@"HXLRegexVC" bundle:nil];
    [_dicVC setValue:regexVC forKey:@"正则表达式"];
    [regexVC release];
    
    HXLObjectMatchVC *objectMatchVC = [[HXLObjectMatchVC alloc] initWithNibName:@"HXLObjectMatchVC" bundle:nil];
    [_dicVC setValue:objectMatchVC forKey:@"对象数组的匹配"];
    [objectMatchVC release];
 
//    [NSJSONSerialization JSONObjectWithData:nil options:(NSJSONReadingMutableContainers) error:<#(NSError **)#>]

}

//设置视图
-(void)setMainView
{
    _tableView.backgroundColor = [UIColor clearColor];
}



#pragma mark - <------ UITableViewDataSource ------>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrType count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"RootViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    cell.textLabel.text = [_arrType objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //通过相应cell找到对应的标题，然后找到相应的ViewController
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *strCellTitle = cell.textLabel.text;
    UIViewController *vc = (UIViewController *)[_dicVC objectForKey:strCellTitle];
    
    //设置下个页面返回键title为“返回”
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    //页面跳转
    [self.navigationController pushViewController:vc animated:YES];
}

//返回YES，表示支持单元格的移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *str0 = [_arrType objectAtIndex:sourceIndexPath.row];
    NSString *str1 = [_arrType objectAtIndex:destinationIndexPath.row];
    [_arrType replaceObjectAtIndex:sourceIndexPath.row withObject:str1];
    [_arrType replaceObjectAtIndex:destinationIndexPath.row withObject:str0];
    
    [_tableView reloadData];
}

//
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrType removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }else{
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }
}

//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


@end