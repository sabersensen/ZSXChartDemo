//
//  FCChartCollectionViewCell.h
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/13.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FCChartCollectionViewCellTypeDefault, //正常样式 文字居中
    FCChartCollectionViewCellTypeMax,  //最高标志位
    FCChartCollectionViewCellTypeMin,  //最低标志位
} FCChartCollectionViewCellType;

@interface FCChartCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)NSString *text;

@property (nonatomic,strong)UIColor *textColor;

@property (nonatomic,strong)UIColor *backColor;

@property (nonatomic,assign)FCChartCollectionViewCellType cellType;
@end
