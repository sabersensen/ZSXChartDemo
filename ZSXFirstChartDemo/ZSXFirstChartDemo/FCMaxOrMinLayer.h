//
//  FCMaxOrMinLayer.h
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/15.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FCMaxOrMinLayerTypeMax,
    FCMaxOrMinLayerTypeMin,
} FCMaxOrMinLayerType;

@interface FCMaxOrMinLayer : CALayer

@property (nonatomic,assign)FCMaxOrMinLayerType type;


@end
