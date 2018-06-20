//
//  FCChartCollectionReusableView.m
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/13.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import "FCChartCollectionReusableView.h"

@implementation FCChartCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headerCollectionView.frame = self.frame;
}


#pragma mark - Private Methods

- (void)configUI{
    [self addSubview:self.headerCollectionView];
}

- (UICollectionView *)headerCollectionView{
    if (!_headerCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionHeadersPinToVisibleBounds = YES;
        
        _headerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _headerCollectionView.backgroundColor = [UIColor whiteColor];
        _headerCollectionView.bounces = NO;
        _headerCollectionView.directionalLockEnabled = YES;
        _headerCollectionView.showsVerticalScrollIndicator = NO;
        _headerCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _headerCollectionView;
}

@end
