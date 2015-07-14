//
//  WWLJTextField.m
//  WWLJTextField
//
//  Created by 武文杰 on 15/7/1.
//  Copyright (c) 2015年 武文杰. All rights reserved.
//

#import "WWLJTextField.h"

@interface WWLJTextField ()<UITextFieldDelegate>
{
    UITextField *_textField;
}

@property (nonatomic) CGSize keyboardSize;
@property (weak) id keyboardDidShowNotificationObserver;
@property (weak) id keyboardWillHideNotificationObserver;
@end

@implementation WWLJTextField
@synthesize scrollView;
@synthesize tableView;
@synthesize keyboardSize;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加消息中心
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
        
    }
    return self;
}

- (void)scrollToField
{
    CGRect textFieldRect = [[_textField superview] convertRect:_textField.frame toView:self.window];
    CGRect aRect = self.window.bounds;
    
    aRect.origin.y = -tableView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + 60;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || tableView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0, self.superview.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [tableView setContentOffset:scrollPoint animated:YES];
    }
}

#pragma mark - UIKeyboard notifications

- (void) keyboardDidShow:(NSNotification *) notification{
    if (_textField== nil) return;
    if (![_textField isKindOfClass:[WWLJTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];

}

- (void) keyboardWillHide:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
            [self.tableView setContentOffset:CGPointMake(0, -tableView.contentInset.top) animated:NO];
        
    }];
    

   
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardDidShowNotificationObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self.keyboardWillHideNotificationObserver];
}

#pragma mark - UITextField notifications

- (void)textFieldDidBeginEditing:(NSNotification *) notification{
    UITextField *textField = (UITextField*)[notification object];
    
    _textField = textField;
    
    [self setKeyboardDidShowNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardDidShow:notification];
    }]];
    
    [self setKeyboardWillHideNotificationObserver:[[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *notification){
        [self keyboardWillHide:notification];
    }]];
    
    if ([self.superview.superview.superview isKindOfClass:[UIScrollView class]] && self.tableView == nil){
        self.tableView = (UITableView*)self.superview.superview.superview;
    }

}

- (void)textFieldDidEndEditing:(NSNotification *) notification{
    UITextField *textField = (UITextField*)[notification object];
    [textField resignFirstResponder];
    _textField = nil;
}



@end
