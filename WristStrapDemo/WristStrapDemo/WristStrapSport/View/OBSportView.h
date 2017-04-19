//
//  OBSportView.h
//  GradientLayerDemo
//
//  Created by obally on 17/4/12.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OBRoundView;
@interface OBSportView : UIView
@property(nonatomic,assign) CGFloat progress;
@property(nonatomic,strong) OBRoundView *roundView;
@property(nonatomic,assign) NSInteger stepCount; //步数
@property(nonatomic,assign) NSInteger targetCount; //目标数

@end
