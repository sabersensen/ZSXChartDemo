//
//  FCChartCollectionViewFlowLayout.h
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/13.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCChartCollectionViewFlowLayoutDataSource <NSObject>

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FCChartCollectionViewFlowLayout : UICollectionViewFlowLayout


/**
 需要灵活item 尺寸 就需要遵守
 */
@property (nonatomic,weak)id <FCChartCollectionViewFlowLayoutDataSource>dataSource;


/**
 锁定行数
 */
@property (nonatomic,assign)NSInteger suspendRowNum;


/**
 锁定列数
 */
@property (nonatomic,assign)NSInteger suspendSectionNum;

- (void)reload;

@end
