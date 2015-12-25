//
//  SecondViewController.m
//  PickerViewDemo
//
//  Created by FrankLiu on 15/12/24.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "SecondViewController.h"
#import "ButtonWithPickerView.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Button调出PickerView";

    self.view.backgroundColor = [UIColor whiteColor];
    
    ButtonWithPickerView *btn = [ButtonWithPickerView buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    
    btn.frame           = CGRectMake(0, 0, 300, 40);
    btn.center          = self.view.center;
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"PickView" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton*)sender {

    [sender becomeFirstResponder];
}

@end
