//
//  ViewController.m
//  WristStrapDemo
//
//  Created by obally on 17/4/11.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "ViewController.h"
#import "WristStrapModel.h"
#import "OBDataManager.h"
#if TARGET_IPHONE_SIMULATOR
#else
@interface ViewController ()<WCDSharkeyFunctionDelegate>
@property(nonatomic,strong)WCDSharkeyFunction *shareKey;
@property(nonatomic,strong)WristStrapModel *strapModel; //手环数据
@property(nonatomic,strong)Sharkey *sharKey;


@end
#endif
@implementation ViewController
#if TARGET_IPHONE_SIMULATOR
#else
- (void)viewDidLoad {
    [super viewDidLoad];
    self.shareKey = [WCDSharkeyFunction shareInitializationt];
    self.shareKey.delegate = self;
    
}
- (IBAction)connectAction:(id)sender {
    [self.shareKey scanWithSharkeyType:SHARKEYALL];
//    [self.shareKey connectSharkey:@""];
}
- (IBAction)sportAction:(id)sender {
//    Byte ;
    [self.shareKey updatePedometerDataFromRemoteWalkNumberOfDays:0xd1];
//    [self.shareKey updatePedometerDataFromRemoteTotalNumberOfDays:0x01];
}
- (IBAction)sleepAction:(id)sender {
    [self.shareKey querySleepDataFromSharkey];
}
- (IBAction)reminderAction:(id)sender {
//    [self.shareKey setNotifyRemoteReminderFlag:ReminderFlagPushIncomingCall]; //电话
//    [self.shareKey setNotifyRemoteReminderFlag:ReminderFlagPushSms]; //消息
    AlarmClockData *clock = [[AlarmClockData alloc]init];
    clock.cycle = AlarmClockWorkDayMask;
    clock.enable = YES;
    clock.hour = 11;
    clock.minute = 25;
    AlarmClockData *clock1 = [[AlarmClockData alloc]init];
    clock1.cycle = AlarmClockWorkDayMask;
    clock1.enable = YES;
    clock1.hour = 12;
    clock1.minute = 00;
    AlarmClockData *clock2 = [[AlarmClockData alloc]init];
    clock2.cycle = AlarmClockWorkDayMask;
    clock2.enable = YES;
    clock2.hour = 13;
    clock2.minute = 55;
    [self.shareKey setAlockTime:[NSArray arrayWithObjects:clock,clock1,clock2,nil]];
    [self.shareKey setTimeSynchronization];
    [self.shareKey setNotifyRemoteReminderFlag:ReminderFlagPushReminders]; //事件
//    WristStrapModel *model = [OBDataManager shareManager].lastStrapModel;
//    NSDictionary *dic =  [model mj_keyValues];
//    Sharkey *sharKey =  [self.shareKey retrieveSharkey:dic];
    Sharkey *sharKey = [[NSUserDefaults standardUserDefaults]objectForKey:@"sharKey"];
    if (sharKey != nil) {
        [self.shareKey bindSharkeyDevice:sharKey phone:@"18701459982" block:^(BindorUnBoundDeviceResultCode result) {
            
        }];
    }
    
}
- (IBAction)setAction:(id)sender {
    
}


#pragma mark - WCDSharkeyFunctionDelegate
- (void)WCDSharkeyScanCallBack:(Sharkey *)crippleSharkey
{
    NSLog(@"crippleSharkey -------%@",crippleSharkey);
   
    //连接手环
    BOOL noFirst = [[NSUserDefaults standardUserDefaults]objectForKey:@"NoFirst"];
    if (!noFirst && [crippleSharkey.name isEqualToString:@"Sharky221017"]) {
        //第一次绑定 需要配对
        [self.shareKey connectSharkeyNeedPair:crippleSharkey];
    } else {
        //不是第一次配对
        WristStrapModel *model = [OBDataManager shareManager].lastStrapModel;
        if (model) {
            if ([model.name isEqualToString:crippleSharkey.name]) {
                [self.shareKey connectSharkey:crippleSharkey];
                
            }
        }
        
        
    }
    
//    [self.shareKey connectSharkeyNeedPair:crippleSharkey];
}
- (void)WCDBLERealStateCallBack:(BLEState)bleState
{
    if (bleState == BLEStatePoweredOn) {
        BOOL noFirst = [[NSUserDefaults standardUserDefaults]objectForKey:@"NoFirst"];
        if(!noFirst) {
        
        } else {
            /**
             *  找回sharkey设备时, 参数（NSDictionary）中的key
             */
//            extern NSString *const SHARKEYPAIRTYPE_KEY;
//            extern NSString *const SHARKEYIDENTIFIER_KEY;
//            extern NSString *const SHARKEYMACADDRESS_KEY;
//            extern NSString *const SHARKEYMODELNAME_KEY;
            WristStrapModel *model = [OBDataManager shareManager].lastStrapModel;
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[NSNumber numberWithInt:model.pairType] forKey:SHARKEYPAIRTYPE_KEY];
            [dic setObject:model.identifier forKey:SHARKEYIDENTIFIER_KEY];
            [dic setObject:model.macAddress forKey:SHARKEYMACADDRESS_KEY];
            [dic setObject:model.modelName forKey:SHARKEYMODELNAME_KEY];
            Sharkey *sharKey =  [self.shareKey retrieveSharkey:dic];
            if (sharKey) {
                [self.shareKey connectSharkey:sharKey];
            }
            
        }
        
    } else if (bleState == BLEStatePoweredOff) {
        
    }
}
- (void)WCDShackHandSuccessCallBack:(Sharkey *)crippleSharkey
{
    [self.shareKey pairToSharkey:crippleSharkey];
    
}
- (void)WCDShackSentANCSCallBack:(Byte)flag
{

}
- (void)WCDPairCodeSendSuccessCallBack
{
    NSLog(@"验证码配对");
}
- (void)WCDTapPairSendSuccessCallBack
{
    NSLog(@"敲击配对");
}
- (void)WCDSecurityPairCodeSendSuccessCallBack
{
    NSLog(@"屏幕点击配对");
}
- (void)WCDConnectSuccessCallBck:(BOOL)flag sharkey:(Sharkey *)intactSharkey
{
    NSLog(@"配对成功flag ----- %d，intactSharkey -------%@",flag,intactSharkey);
    [self.shareKey stopScan];
    [[NSUserDefaults standardUserDefaults]setObject:@1 forKey:@"NoFirst"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.shareKey setqueryRemotePairStatus];
}
//睡眠数据
- (void)WCDQuerySleepDataFromSharkeyCallBack:(NSUInteger)startMinute rawData:(NSData *)rawData gatherRate:(SleepDataGatherRate)gatherRate
{
   SleepDataInfo *info =  [self.shareKey analyseSleep:startMinute data:rawData gatherRate:gatherRate];
    NSLog(@"睡眠数据 ----------%@",info);
}
//计步
- (void)WCDPedometerDate:(NSDate *)date Count:(NSInteger)count Minute:(NSInteger)minute
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"date------%@,count------%ld,minute-----%ld",date,count,minute);
        //查询公里数
        CGFloat distant = [self.shareKey getDistanceAll:165 numStep:count];
        //卡路里
        CGFloat kCal = [self.shareKey getKcal:distant weight:50];
        NSLog(@"distant------%f,kCal------%f",distant,kCal);
    });
   
    
}
- (void)WCDShackSetPhoneSuccessCallBack:(NSData *)flag
{
    NSLog(@"设置事件成功");
}
#endif
@end
