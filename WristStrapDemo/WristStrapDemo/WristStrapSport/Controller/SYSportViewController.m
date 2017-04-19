//
//  SYSportViewController.m
//  WristStrapDemo
//
//  Created by obally on 17/4/18.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "SYSportViewController.h"
#import "OBSportView.h"

@interface SYSportViewController ()<WCDSharkeyFunctionDelegate>
@property(nonatomic,strong)WCDSharkeyFunction *shareKey;
@property(nonatomic,strong) OBSportView *sportView;


@end

@implementation SYSportViewController
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.shareKey = [WCDSharkeyFunction shareInitializationt];
    self.shareKey.delegate = self;
    [self.shareKey updatePedometerDataFromRemoteWalkNumberOfDays:0xd1];
    //添加相关视图
    [self addView];
    //相关视图事件添加
    [self addAction];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //视图frame设置及相关约束
    [self viewframeSet];
    
}
#pragma mark - 视图、action 添加  frame设置
- (void)addView
{
    [self.view addSubview:self.sportView];
}
- (void)addAction
{
    
}
- (void)viewframeSet
{
    
}
#pragma mark -Actions

#pragma mark - WCDSharkeyFunctionDelegate
//计步
- (void)WCDPedometerDate:(NSDate *)date Count:(NSInteger)count Minute:(NSInteger)minute
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"date------%@,count------%ld,minute-----%ld",date,count,minute);
        self.sportView.stepCount = count;
        self.sportView.targetCount = 8000;
        //查询公里数
        CGFloat distant = [self.shareKey getDistanceAll:165 numStep:count];
        //卡路里
        CGFloat kCal = [self.shareKey getKcal:distant weight:50];
        NSLog(@"distant------%f,kCal------%f",distant,kCal);
    });
    
    
}

#pragma mark - getter and setter

- (OBSportView *)sportView
{
    if (_sportView == nil) {
        _sportView = [[OBSportView alloc]initWithFrame:CGRectMake(kWidth(100), kHeight(100),kWidth(200), kWidth(200))];
    }
    return _sportView;
}
@end
