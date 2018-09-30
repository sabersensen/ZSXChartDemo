//
//  FCChartView.m
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/12.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import "FCChartView.h"
#import "FCChartCollectionViewCell.h"
#import "FCChartCollectionReusableView.h"
#import "FCChartCollectionViewFlowLayout.h"

static NSString *kMainCVDefaultCellIdentifier = @"kMainCVChartCollectionViewCell";
static NSString *kMainCVHeaderIdentifier = @"kMainCVChartCollectionReusableView";
static NSString *kAttachCVDefaultCellIdentifier = @"kAttachCVChartCollectionViewCell";
static NSString *kAttachCVHeaderCellIdentifier = @"kkAttachCVChartCollectionReusableView";


static NSInteger kMainCVTag = 19979754;

@interface FCChartView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FCChartCollectionViewFlowLayoutDataSource>

/**
 主要渲染CollectionView
 */
@property (nonatomic,strong)UICollectionView *mainCV;

@property (nonatomic,strong)FCChartCollectionViewFlowLayout *mainLayout;


@property (nonatomic,assign)FCChartViewType fixationType;

@property (nonatomic,assign)NSInteger suspendRow;

@property (nonatomic,assign)NSInteger suspendSection;


@end

@implementation FCChartView

- (instancetype)initWithFrame:(CGRect)frame type:(FCChartViewType)type dataSource:(id<FCChartViewDataSource>)dataSource{
    if (self = [super initWithFrame:frame]) {
        _fixationType = type;
        _dataSource = dataSource;
        [self configUIWithType:type];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainCV.frame = self.bounds;
}

#pragma mark - Private Methods

- (void)configUIWithType:(FCChartViewType)type{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    [self addSubview:self.mainCV];
}

#pragma mark - Public Methods

- (void)reload{
    self.suspendRow = 0;
    self.suspendSection = 0;
    self.mainLayout.suspendRowNum = self.suspendRow;
    self.mainLayout.suspendSectionNum = self.suspendSection;
    [self.mainLayout reload];
    [self.mainCV reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataSource chartView:self numberOfItemsInSection:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_dataSource numberOfSectionsInChartView:self];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCVDefaultCellIdentifier forIndexPath:indexPath];
    if (indexPath.section < self.suspendSection) {
        cell.backgroundColor = self.suspendSectionColor;
        cell = [self.dataSource collectionViewCell:cell collectionViewType:FCChartCollectionViewTypeSuspendSection cellForItemAtIndexPath:indexPath];
        return cell;
    }
    if (indexPath.row <self.suspendRow) {
        cell.backgroundColor = self.suspendRowColor;
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section-self.suspendSection];
        cell = [self.dataSource collectionViewCell:cell collectionViewType:FCChartCollectionViewTypeSuspendRow cellForItemAtIndexPath:indexP];
        return cell;
    }
    cell.backgroundColor = self.mainColor;
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row-self.suspendRow inSection:indexPath.section-self.suspendSection];
    cell = [self.dataSource collectionViewCell:cell collectionViewType:FCChartCollectionViewTypeMain cellForItemAtIndexPath:indexP];
    return cell;
}

#pragma mark - FCChartViewDataSource

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataSource chartView:self sizeForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataSource chartView:self sizeForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate


#pragma mark - Getter Methods

- (UICollectionView *)mainCV{
    if (!_mainCV) {
        _mainCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.mainLayout];
        _mainCV.backgroundColor = [UIColor whiteColor];
        _mainCV.directionalLockEnabled = YES;
        _mainCV.tag = kMainCVTag;
        _mainCV.delegate = self;
        _mainCV.dataSource = self;
        _mainCV.bounces = NO;
        _mainCV.showsHorizontalScrollIndicator = NO;
        _mainCV.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _mainCV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainCV registerClass:[FCChartCollectionViewCell class] forCellWithReuseIdentifier:kMainCVDefaultCellIdentifier];

    }
    return _mainCV;
}

- (FCChartCollectionViewFlowLayout *)mainLayout{
    if (!_mainLayout) {
        _mainLayout = [[FCChartCollectionViewFlowLayout alloc] init];
        _mainLayout.suspendRowNum = self.suspendRow;
        _mainLayout.suspendSectionNum = self.suspendSection;
        _mainLayout.dataSource = self;
    }
    return _mainLayout;
}

- (NSInteger)suspendRow{
    if (!_suspendRow) {
        if (self.dataSource &&[self.dataSource respondsToSelector:@selector(chartView:numberOfSuspendItemsInSection:)]) {
            _suspendRow = [_dataSource chartView:self numberOfSuspendItemsInSection:0];
        }else{
            switch (_fixationType) {
                case FCChartViewTypeSectionAndRowFixation:
                    return 1;
                case FCChartViewTypeOnlySectionFixation:
                    return 0;
                case FCChartViewTypeOnlyRowFixation:
                    return 1;
                case FCChartViewTypeNoFixation:
                    return 0;
            }
            
        }
    }
    return _suspendRow;
}

- (NSInteger)suspendSection{
    if (!_suspendSection) {
        if (self.dataSource &&[self.dataSource respondsToSelector:@selector(numberOfSuspendSectionsInChartView:)])
        {
            _suspendSection = [_dataSource numberOfSuspendSectionsInChartView:self];
        }else{
            switch (_fixationType) {
                case FCChartViewTypeSectionAndRowFixation:
                    return 1;
                case FCChartViewTypeOnlySectionFixation:
                    return 1;
                case FCChartViewTypeOnlyRowFixation:
                    return 0;
                case FCChartViewTypeNoFixation:
                    return 0;
            }
        }
    }
    return _suspendSection;
}

- (UIColor *)mainColor{
    if (!_mainColor) {
        _mainColor = [UIColor whiteColor];
    }
    return _mainColor;
}

- (UIColor *)suspendRowColor{
    if (!_suspendRowColor) {
        _suspendRowColor = [UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
    }
    return _suspendRowColor;
}

- (UIColor *)suspendSectionColor{
    if (!_suspendSectionColor) {
        _suspendSectionColor = [UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
    }
    return _suspendSectionColor;
}



@end
