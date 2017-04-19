//
//  OBRoundView.m
//  GradientLayerDemo
//
//  Created by obally on 17/4/12.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBRoundView.h"
#import "WristStrapCommon.h"
#define  CENTER   CGPointMake(self.width *.5, self.height *.5)
@interface OBRoundView ()
/** 外圈  */
@property (nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,strong) CAShapeLayer *bottomLayer;

@property(nonatomic,strong) CAShapeLayer *topLayer;
@end
@implementation OBRoundView
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        CAShapeLayer *bottomLayer = [CAShapeLayer layer];
        bottomLayer.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:self.width/2.0 - 10 startAngle:(M_PI_2) * 3.0 endAngle:(M_PI_2) * 3.0 + M_PI * 2 clockwise:1].CGPath;
        bottomLayer.fillColor = [UIColor clearColor].CGColor;
        bottomLayer.strokeColor = [UIColor purpleColor].CGColor;
        bottomLayer.lineWidth = 15;
        bottomLayer.strokeStart = 0;
        bottomLayer.strokeEnd = 1;
        self.topLayer = bottomLayer;
        [bottomLayer setLineDashPattern:[NSArray arrayWithObjects:@5,@1, nil]];
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        
        CAGradientLayer *lay1 = [CAGradientLayer layer];
        lay1.frame = CGRectMake(0, 0, self.width/2.0, self.height);
        lay1.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor colorWithRed:107/255.0 green:205/255.0 blue:255/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:197/255.0 green:201/255.0 blue:131/255.0 alpha:1].CGColor, nil];
        lay1.startPoint = CGPointMake(0.5, 0);
        lay1.endPoint = CGPointMake(0.5, 1);
        [_gradientLayer addSublayer:lay1];
        
        CAGradientLayer *lay2 = [CAGradientLayer layer];
        lay2.frame = CGRectMake(self.width/2.0, 0, self.width/2.0, self.height);
        lay2.colors = [NSArray arrayWithObjects:(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor colorWithRed:197/255.0 green:201/255.0 blue:131/255.0 alpha:1].CGColor, nil];
        lay2.startPoint = CGPointMake(0.5, 0);
        lay2.endPoint = CGPointMake(0.5, 1);
        [_gradientLayer addSublayer:lay2];
        
        _gradientLayer.mask = bottomLayer;
        
    }
    return _gradientLayer;
}
- (CAShapeLayer *)bottomLayer
{
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:self.width/2.0 - 10 startAngle:0 endAngle:M_PI * 2 clockwise:1].CGPath;
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.8].CGColor;
        _bottomLayer.lineWidth = 15;
        [_bottomLayer setLineDashPattern:[NSArray arrayWithObjects:@5,@1, nil]];
        
    }
    return _bottomLayer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.bottomLayer];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.topLayer.strokeEnd = progress;
}

@end
