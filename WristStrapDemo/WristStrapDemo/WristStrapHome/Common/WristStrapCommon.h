//
//  WristStrapCommon.h
//  WristStrapDemo
//
//  Created by obally on 17/4/18.
//  Copyright © 2017年 obally. All rights reserved.
//

#ifndef WristStrapCommon_h
#define WristStrapCommon_h

#import "WCDSharkeyFunction.h"
#import "OBBase.h"
#import "MGJRouter.h"
#define RGBAlphaColor(a,b,c,ap) [UIColor colorWithRed:((float)a)/255.0 green:((float)b)/255.0 blue:((float)c)/255.0 alpha:ap]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 alpha:1.0]
#define RGBColor(a,b,c) [UIColor colorWithRed:((float)a)/255.0 green:((float)b)/255.0 blue:((float)c)/255.0 alpha:1.0]
// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kFont(a) [UIFont systemFontOfSize:(a/ 375.0 * kScreenWidth)] //字体大小
#define kBFont(a) [UIFont boldSystemFontOfSize:(a/ 375.0 * kScreenWidth)] //粗体字体大小
// 屏幕宽
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
// 屏幕高
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
/** 基础iPhone6尺寸适配 */
#define     kHeight(H)         H / 667.0 * kScreenHeight

/** 基础iPhone6尺寸适配 */
#define     kWidth(W)         W / 375.0 * kScreenWidth
// 导航栏高度
#define NaviHeitht         ([UIApplication sharedApplication].statusBarHidden?44:64)

#endif /* WristStrapCommon_h */
