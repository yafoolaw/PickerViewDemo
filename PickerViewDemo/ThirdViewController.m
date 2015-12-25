//
//  ThirdViewController.m
//  PickerViewDemo
//
//  Created by FrankLiu on 15/12/24.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "ThirdViewController.h"
#import "LabelWithPickView.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ThirdViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray    *m_yearArray;
@property (nonatomic, strong) NSMutableArray    *m_monthArray;
@property (nonatomic, strong) LabelWithPickView *m_label;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Label调出PickerView";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.m_yearArray  = [NSMutableArray arrayWithArray:@[@"2014年",@"2015年"]];
    self.m_monthArray = [NSMutableArray arrayWithArray:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"]];

    UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    pickerView.dataSource = self;
    pickerView.delegate   = self;
    pickerView.backgroundColor = [UIColor redColor];
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarItemAction)];
    toolBar.items = @[item];
    
    self.m_label = [[LabelWithPickView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2.0, 100, 300, 40)];
    [self.view addSubview:self.m_label];
    
    self.m_label.userInteractionEnabled = YES;
    self.m_label.backgroundColor        = [UIColor redColor];
    self.m_label.text                   = @"Tap Me";
    self.m_label.textAlignment          = NSTextAlignmentCenter;
    self.m_label.inputView              = pickerView;
    self.m_label.inputAccessoryView     = toolBar;
    
    
    self.m_label.inputView.backgroundColor = [UIColor clearColor];
}

- (void)toolBarItemAction {

    [self.m_label resignFirstResponder];
    
    UIPickerView *pickerView = self.m_label.inputView;
    
    NSInteger year  = [pickerView selectedRowInComponent:0];
    NSInteger month = [pickerView selectedRowInComponent:1];
    
    NSString *yearStr  = self.m_yearArray[year];
    NSString *monthStr = self.m_monthArray[month];
    
    self.m_label.text = [NSString stringWithFormat:@"%@  %@",yearStr,monthStr];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.m_yearArray.count;
        
    } else {
        
        return self.m_monthArray.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.view.frame.size.width/2.0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    return 40;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.m_yearArray[row];
        
    } else {
        
        return self.m_monthArray[row];
    }
}

@end
