//
//  OBDataManager.h
//  WristStrapDemo
//
//  Created by obally on 17/4/12.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WristStrapModel.h"
@interface OBDataManager : NSObject
+(instancetype)shareManager;
@property(nonatomic,strong) WristStrapModel *strapModel;
- (WristStrapModel *)lastStrapModel;

@end
