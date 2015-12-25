//
//  ViewController.m
//  PickerViewDemo
//
//  Created by FrankLiu on 15/12/23.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 还有一个与UIPickerView相关的协议UIPickerViewAccessibilityDelegate,这是用来实现Accessibility and VoiceOver的
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView    *m_pickerView;
@property (nonatomic, strong) NSMutableArray  *m_yearArray;
@property (nonatomic, strong) NSMutableArray  *m_monthArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"UIPickerView简单介绍";
    
    self.m_yearArray  = [NSMutableArray arrayWithArray:@[@"2014年",@"2015年"]];
    self.m_monthArray = [NSMutableArray arrayWithArray:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"]];

    // 看网上的教程说UIPickerView的高度是一定的,然而我测试,高度还是由你设定的frame决定的,并没有什么固定值
    self.m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    [self.view addSubview:self.m_pickerView];
    
    self.m_pickerView.dataSource = self;
    self.m_pickerView.delegate   = self;
    
    // iOS7之后没有效果了,参见https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UIPickerView.html
    self.m_pickerView.showsSelectionIndicator = YES;
    
    // 跳转到利用Button,将PickerView 作为 InputView 的控制器
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake((self.view.frame.size.width - 200)/2.0, 150, 200, 40);
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"Button调出PickerView" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushToSecondVC) forControlEvents:UIControlEventTouchUpInside];
    
    // 跳转到利用Label,将PickerView 作为 InputView 的控制器
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    
    btn2.frame = CGRectMake((SCREEN_WIDTH - 200)/2.0, 150 + 40 + 40, 200, 40);
    btn2.backgroundColor = [UIColor cyanColor];
    [btn2 setTitle:@"Label调出PickerView" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pushToThirdVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushToSecondVC {

    SecondViewController *secondVC = [SecondViewController new];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)pushToThirdVC {

    ThirdViewController *thirdVC = [ThirdViewController new];
    [self.navigationController pushViewController:thirdVC animated:YES];
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

// 此方法的优先级高于上面的方法,实现了此方法,则上面的方法就不执行了,这个很好理解
// 经过我的测试,此方法的reusingView并没什么用,可能是iOS7之后不再使用,方法说明中关于此参数是这样说的"A view object that was previously used for this row, but is now hidden and cached by the picker view.",另外参考http://stackoverflow.com/questions/20635949/reusing-view-in-uipickerview-with-ios-7
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view  {
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    if (component == 0) {
        
        label.text = self.m_yearArray[row];
        
    } else {
        
        label.text = self.m_monthArray[row];
    }
    
    
    return label;
}

@end
