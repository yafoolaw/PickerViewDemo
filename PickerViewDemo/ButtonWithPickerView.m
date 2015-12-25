//
//  ButtonWithPickerView.m
//  PickerViewDemo
//
//  Created by FrankLiu on 15/12/24.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "ButtonWithPickerView.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ButtonWithPickerView () <UIPickerViewDataSource,UIPickerViewDelegate>

// 将UIResponder的这两个readonly属性变为readwrite
@property (nonatomic,strong,readwrite) __kindof UIView * inputView;
@property (nonatomic,strong,readwrite) __kindof UIView * inputAccessoryView;
@property (nonatomic, strong) NSMutableArray  *m_yearArray;
@property (nonatomic, strong) NSMutableArray  *m_monthArray;

@property (nonatomic, strong) NSString * m_yearStr;
@property (nonatomic, strong) NSString * m_monthStr;

@end

@implementation ButtonWithPickerView

// 这个方法必须实现
- (BOOL) canBecomeFirstResponder {
    
    return YES;
}

- (UIPickerView *)inputView {

    if (_inputView == nil) {
        
        self.m_yearArray  = [NSMutableArray arrayWithArray:@[@"2014年",@"2015年"]];
        self.m_monthArray = [NSMutableArray arrayWithArray:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"]];
        
        self.m_yearStr  = self.m_yearArray[0];
        self.m_monthStr = self.m_monthArray[0];
        
        UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        pickerView.dataSource = self;
        pickerView.delegate   = self;
        
        return pickerView;
    }
    
    return _inputView;
}

- (UIToolbar*)inputAccessoryView {

    if (_inputAccessoryView == nil) {
        
        UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnResignFirstResponder)];
        toolBar.items = @[item];
        
        return toolBar;
    }
    
    return _inputAccessoryView;
}

- (void)btnResignFirstResponder {

    [self resignFirstResponder];
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
    
    return SCREEN_WIDTH/2.0;
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        self.m_yearStr = self.m_yearArray[row];
        
    } else {
    
        self.m_monthStr = self.m_monthArray[row];
    }
    
    [self setTitle:[NSString stringWithFormat:@"%@  %@",self.m_yearStr,self.m_monthStr] forState:UIControlStateNormal];
}

@end
