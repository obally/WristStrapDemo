//
//  SYSleepViewController.m
//  WristStrapDemo
//
//  Created by obally on 17/4/18.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "SYSleepViewController.h"
#import "OBColumnChart.h"
#import "WristStrapCommon.h"
@interface SYSleepViewController ()<WCDSharkeyFunctionDelegate>
@property(nonatomic,strong)WCDSharkeyFunction *shareKey;


@end

@implementation SYSleepViewController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加相关视图
    [self addView];
    //相关视图事件添加
    [self addAction];
    self.shareKey = [WCDSharkeyFunction shareInitializationt];
    self.shareKey.delegate = self;
    [self.shareKey querySleepDataFromSharkey];
    
    
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
    OBColumnChart *column = [[OBColumnChart alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 320)];
    column.valueArr = @[
                        @[@3,@5],
                        @[@2.2,@5.8],
                        @[@3.4,@4.3],
                        @[@2.1,@7.8],
                        @[@1.9,@2.8],
                        @[@1.2,@6.9],
                        @[@4.5,@15.9],
                        ];
    column.originSize = CGPointMake(30, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 20;
    column.typeSpace = 15;
    column.columnSpace = 5;
    column.isShowYLine = NO;
    column.columnWidth = 12;
    column.bgVewBackgoundColor = [UIColor whiteColor];
    column.drawTextColorForX_Y = [UIColor lightGrayColor];
    column.colorForXYLine = [UIColor lightGrayColor];
    column.columnBGcolorsArr = @[[UIColor colorWithRed:126/256.0 green:142.0/256 blue:237.0/256 alpha:1],[UIColor colorWithRed:166/256.0 green:237/256.0 blue:233.0/256 alpha:1]];
    column.xShowInfoText = @[@"09/26",@"09/27",@"09/28",@"09/29",@"09/30",@"10/01",@"10/02"];
    column.isShowLineChart = NO;
    column.lineValueArray =  @[
                               @6,
                               @12,
                               @10,
                               @1,
                               @9,
                               @5,
                               @9,
                               @9,
                               @5,
                               @6,
                               @4,
                               @8,
                               @11
                               ];
    [column showAnimation];
    [self.view addSubview:column];

}
- (void)addAction
{
    
}
- (void)viewframeSet
{
    
}
#pragma mark -Actions
#pragma mark - WCDSharkeyFunctionDelegate
//睡眠数据
- (void)WCDQuerySleepDataFromSharkeyCallBack:(NSUInteger)startMinute rawData:(NSData *)rawData gatherRate:(SleepDataGatherRate)gatherRate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:startMinute*60.0];
    NSString* dateString = [formatter stringFromDate:date];
//   @"201701111111" 
    SleepDataInfo *info =  [self.shareKey analyseSleep:( [[NSDate date] timeIntervalSince1970] - 60*60*15) data:rawData gatherRate:gatherRate];
    NSDate* date1 =  [NSDate dateWithTimeIntervalSince1970:info.startMinute];
    NSDate* date2 =  [NSDate dateWithTimeIntervalSince1970:info.deepMinute];
    NSDate* date3 =  [NSDate dateWithTimeIntervalSince1970:info.lightMinute];
    NSDate* date4 =  [NSDate dateWithTimeIntervalSince1970:info.totalMinute];
    SleepSectionInfo *infos= info.sectionInfos[0];
    NSLog(@"睡眠数据 ----------%@",info);
}
#pragma mark - getter and setter
@end
