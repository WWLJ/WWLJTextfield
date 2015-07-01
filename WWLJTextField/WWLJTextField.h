//
//  WWLJTextField.h
//  WWLJTextField
//
//  Created by iShareme on 15/7/1.
//  Copyright (c) 2015年 iShareme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWLJTextField : UITextField

@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView  *tableView;

@end
