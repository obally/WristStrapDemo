//
//  OBSportView.m
//  GradientLayerDemo
//
//  Created by obally on 17/4/12.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBSportView.h"
#import "OBRoundView.h"

@interface OBSportView ()

@property(nonatomic,strong) UILabel *stepNum;
@property(nonatomic,strong) UILabel *targetNum;

@end
@implementation OBSportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView
{
    OBRoundView *roundView = [[OBRoundView alloc]initWithFrame:self.bounds];
    self.roundView = roundView;
    [self addSubview:roundView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 30, 20)];
    label.text = @"步数";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UILabel *stepNum = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom, self.width - 30 , 50)];
    stepNum.text = @"5507";
    stepNum.textColor = [UIColor orangeColor];
    stepNum.font = [UIFont boldSystemFontOfSize:35];
    stepNum.textAlignment = NSTextAlignmentCenter;
    self.stepNum = stepNum;
    [self addSubview:stepNum];
    
    UILabel *targetNum = [[UILabel alloc]initWithFrame:CGRectMake(0, stepNum.bottom, self.width - 30 , 20)];
    targetNum.text = @"目标 1000";
    targetNum.textColor = [UIColor lightGrayColor];
    targetNum.font = [UIFont systemFontOfSize:14.0];
    targetNum.textAlignment = NSTextAlignmentCenter;
    self.targetNum = targetNum;
    [self addSubview:targetNum];
    
    targetNum.centerX = stepNum.centerX = label.centerX = roundView.centerX;
    stepNum.centerY = roundView.centerY;
    targetNum.top = stepNum.bottom;
    
}
#pragma mark - setter && getter
- (void)setStepCount:(NSInteger)stepCount
{
    _stepCount = stepCount;
    self.stepNum.text =  [NSString stringWithFormat:@"%ld",_stepCount];
    if (_stepCount && _targetCount) {
        self.roundView.progress = _stepCount/_targetCount;
    }
}
- (void)setTargetCount:(NSInteger)targetCount
{
    _targetCount = targetCount;
    self.targetNum.text = [NSString stringWithFormat:@"目标 %ld",_targetCount];
    if (_stepCount && _targetCount) {
        self.roundView.progress = (CGFloat)_stepCount/_targetCount;
    }
}

@end
