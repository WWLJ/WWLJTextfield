//
//  ViewController.m
//  WWLJTextField
//
//  Created by iShareme on 15/7/1.
//  Copyright (c) 2015年 iShareme. All rights reserved.
//

#import "ViewController.h"
#import "WWLJTextField.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(WWLJTextField *)getNewTextField:(NSString *)placehodler
{
    WWLJTextField * textView = [[WWLJTextField alloc]initWithFrame:CGRectMake(72, 0, [[UIScreen mainScreen] bounds].size.width - 107, 44)];
    textView.delegate = self;
    [textView setTextAlignment:NSTextAlignmentRight];
    textView.placeholder = placehodler;
    return textView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 300)];
    aView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = aView;
    
}

#pragma mark tableView的协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"renxing"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    switch (indexPath.row) {
        case 0:{//所在公司
            [cell addSubview:[self getNewTextField:@"请输入公司名称"]];
            [cell setAccessoryView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)]];
            [cell.textLabel setText:@"所在公司"];
        }
            break;
        case 1:{//职位名称
            [cell addSubview:[self getNewTextField:@"当前职位名称"]];
            [cell setAccessoryView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)]];
            [cell.textLabel setText:@"职位名称"];
        }
            break;
        case 2:{
            [cell addSubview:[self getNewTextField:@"职位名称"]];
            [cell setAccessoryView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)]];
            [cell.textLabel setText:@"职位名称"];
        }
            break;
        case 3:{
            [cell addSubview:[self getNewTextField:@"名称"]];
            [cell setAccessoryView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)]];
            [cell.textLabel setText:@"职位名称"];
        }
            break;
        case 4:{
            [cell addSubview:[self getNewTextField:@"vrever"]];
            [cell setAccessoryView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)]];
            [cell.textLabel setText:@"职位名称"];
        }
            break;  
            
    }
    return cell;
}


@end
