//
//  SYWristStapHomeViewController.m
//  WristStrapDemo
//
//  Created by obally on 17/4/18.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "SYWristStapHomeViewController.h"
#import "WristStrapModel.h"
#import "OBDataManager.h"
#import "SYSportViewController.h"
#import "SYSleepViewController.h"
#import "WristStrapCommon.h"
@interface SYWristStapHomeViewController ()<WCDSharkeyFunctionDelegate>
@property(nonatomic,strong)WCDSharkeyFunction *shareKey;
@property(nonatomic,strong)WristStrapModel *strapModel; //手环数据
@property(nonatomic,strong)Sharkey *sharKey;


@property(nonatomic,strong) UIView *topView; //顶部卡片数展示 跟点按连接
@property(nonatomic,strong) UIImageView *topCardImage; //顶部卡片展示
@property(nonatomic,strong) UIButton *topConnectButton; //顶部点按连接设备
@property(nonatomic,strong) UIView *bottomView; //底部视图总视图
@property(nonatomic,strong) UIButton *bottomCardButton; //底部卡包按钮
@property(nonatomic,strong) UIButton *bottomSportButton; //底部运动按钮
@property(nonatomic,strong) UIButton *bottomSleepButton; //底部睡眠按钮
@property(nonatomic,strong) UIButton *bottomReminderButton; //底部提醒按钮
@property(nonatomic,strong) UIButton *bottomSettingButton; //底部设置按钮


@end

@implementation SYWristStapHomeViewController
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加相关视图
    [self addView];
    //相关视图事件添加
    [self addAction];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"新中新手环";
    self.view.backgroundColor = RGBColor(239, 240, 241);
    self.shareKey = [WCDSharkeyFunction shareInitializationt];
    self.shareKey.delegate = self;
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
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.topCardImage];
    [self.topView addSubview:self.topConnectButton];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomCardButton];
    [self.bottomView addSubview:self.bottomSportButton];
    [self.bottomView addSubview:self.bottomSleepButton];
    [self.bottomView addSubview:self.bottomReminderButton];
    [self.bottomView addSubview:self.bottomSettingButton];
}
- (void)addAction
{
    [self.topConnectButton addTarget:self action:@selector(connectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomCardButton addTarget:self action:@selector(cardAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomSportButton addTarget:self action:@selector(sportAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomSleepButton addTarget:self action:@selector(sleepAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomReminderButton addTarget:self action:@selector(reminderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomSettingButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewframeSet
{
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, kHeight(300));
    self.topCardImage.frame = CGRectMake(kWidth(60), kHeight(30), kScreenWidth - kWidth(60) * 2, kHeight(150));
    self.topConnectButton.frame = CGRectMake(0, self.topCardImage.bottom + kHeight(60), kScreenWidth, kHeight(40));
    self.bottomView.frame = CGRectMake(0, self.topView.bottom + kHeight(10), kScreenWidth, kScreenHeight - NaviHeitht - self.topView.bottom);
    self.bottomCardButton.frame = CGRectMake(0, 0, kScreenWidth/2.0, self.bottomView.height/3.0);
    self.bottomSportButton.frame = CGRectMake(self.bottomCardButton.right, 0, self.bottomCardButton.width, self.bottomCardButton.height);
    self.bottomSleepButton.frame = CGRectMake(0, self.bottomCardButton.bottom, self.bottomCardButton.width, self.bottomCardButton.height);
    self.bottomReminderButton.frame = CGRectMake(self.bottomSleepButton.right, self.bottomSleepButton.top, self.bottomCardButton.width, self.bottomCardButton.height);
    self.bottomSettingButton.frame = CGRectMake(0, self.bottomSleepButton.bottom, self.bottomCardButton.width, self.bottomCardButton.height);
}
#pragma mark -Actions
//连接手环
- (void)connectAction
{
    [self.shareKey scanWithSharkeyType:SHARKEYALL];
}
- (void)cardAction
{

}
- (void)sportAction
{
    SYSportViewController *sportVC = [[SYSportViewController alloc]init];
    [self.navigationController pushViewController:sportVC animated:YES];
}
- (void)sleepAction
{
    SYSleepViewController *sleepVC = [[SYSleepViewController alloc]init];
    [self.navigationController pushViewController:sleepVC animated:YES];
}
- (void)reminderAction
{
    
}
- (void)settingAction
{
    
}
#pragma mark - WCDSharkeyFunctionDelegate
- (void)WCDBLERealStateCallBack:(BLEState)bleState
{
    if (bleState == BLEStatePoweredOn) {
        //蓝牙打开状态
        [_topConnectButton setTitle:@"点按以连接您的手环设备" forState:UIControlStateNormal];
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
        //蓝牙关闭状态
        [_topConnectButton setTitle:@"点按以打开蓝牙" forState:UIControlStateNormal];
    } else if (bleState == BLEStateScaning) {
        //手环正在扫描
        [_topConnectButton setTitle:@"正在连接手环设备" forState:UIControlStateNormal];
    } else if (bleState == BLEStateConnected) {
        //手环连接状态
//        [_topConnectButton setTitle:@"手环已连接" forState:UIControlStateNormal];
    } else if (bleState == BLEStateDisconnected) {
        //手环未连接状态
        [_topConnectButton setTitle:@"手环断开连接" forState:UIControlStateNormal];
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
- (void)WCDConnectSuccessCallBck:(BOOL)flag sharkey:(Sharkey *)intactSharkey
{
    NSLog(@"配对成功flag ----- %d，intactSharkey -------%@",flag,intactSharkey);
     [_topConnectButton setTitle:@"手环已连接" forState:UIControlStateNormal];
    [self.shareKey stopScan];
    [[NSUserDefaults standardUserDefaults]setObject:@1 forKey:@"NoFirst"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.shareKey setqueryRemotePairStatus];
}
#pragma mark - getter and setter
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}
- (UIImageView *)topCardImage
{
    if (_topCardImage == nil) {
        _topCardImage = [[UIImageView alloc]init];
        _topCardImage.backgroundColor = [UIColor redColor];
    }
    return _topCardImage;
}
- (UIButton *)topConnectButton
{
    if (_topConnectButton == nil) {
        _topConnectButton = [[UIButton alloc]init];
        [_topConnectButton setTitle:@"点按以连接您的手环设备" forState:UIControlStateNormal];
        [_topConnectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _topConnectButton;
}
- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}
- (UIButton *)bottomCardButton
{
    if (_bottomCardButton == nil) {
        _bottomCardButton = [[UIButton alloc]init];
        _bottomCardButton.backgroundColor = RandomColor;
        [_bottomCardButton setTitle:@"卡包" forState:UIControlStateNormal];
        [_bottomCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _bottomCardButton;
}
- (UIButton *)bottomSportButton
{
    if (_bottomSportButton == nil) {
        _bottomSportButton = [[UIButton alloc]init];
        _bottomSportButton.backgroundColor = RandomColor;
        [_bottomSportButton setTitle:@"运动" forState:UIControlStateNormal];
        [_bottomSportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _bottomSportButton;
}
- (UIButton *)bottomSleepButton
{
    if (_bottomSleepButton == nil) {
        _bottomSleepButton = [[UIButton alloc]init];
        _bottomSleepButton.backgroundColor = RandomColor;
        [_bottomSleepButton setTitle:@"睡眠" forState:UIControlStateNormal];
        [_bottomSleepButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _bottomSleepButton;
}
- (UIButton *)bottomReminderButton
{
    if (_bottomReminderButton == nil) {
        _bottomReminderButton = [[UIButton alloc]init];
        _bottomReminderButton.backgroundColor = RandomColor;
        [_bottomReminderButton setTitle:@"提醒" forState:UIControlStateNormal];
        [_bottomReminderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _bottomReminderButton;
}
- (UIButton *)bottomSettingButton
{
    if (_bottomSettingButton == nil) {
        _bottomSettingButton = [[UIButton alloc]init];
        _bottomSettingButton.backgroundColor = RandomColor;
        [_bottomSettingButton setTitle:@"设置" forState:UIControlStateNormal];
        [_bottomSettingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _bottomSettingButton;
}
@end
