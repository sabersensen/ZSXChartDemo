//
//  ViewController.m
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/11.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import "ViewController.h"
#import "FCChartView.h"


@interface ViewController ()<FCChartViewDataSource>

@property (nonatomic,strong)FCChartView *chartV;

@property (nonatomic,strong)NSArray *mains;

@property (nonatomic,strong)NSArray *attachs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chartV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - FCChartViewDataSource

- (NSInteger)chartView:(FCChartView *)chartView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (__kindof UICollectionViewCell *)collectionViewCell:(UICollectionViewCell *)collectionViewCell collectionViewType:(FCChartCollectionViewType)type cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FCChartCollectionViewCell *cell = (FCChartCollectionViewCell *)collectionViewCell;
    cell.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    if (indexPath.section%2) {
        if (indexPath.row%2) {
            cell.cellType = FCChartCollectionViewCellTypeMin;
        }else{
            cell.cellType = FCChartCollectionViewCellTypeMax;
        }
        cell.textColor = [UIColor redColor];

    }else{
        cell.textColor = [UIColor blackColor];
        cell.cellType = FCChartCollectionViewCellTypeDefault;
    }
    return cell;
}


- (NSInteger)numberOfSectionsInChartView:(FCChartView *)chartView{
    return 100;
}

- (NSInteger)numberOfSuspendSectionsInChartView:(FCChartView *)chartView{
    return 2;
}

- (NSInteger)chartView:(FCChartView *)chartView numberOfSuspendItemsInSection:(NSInteger)section{
    return 2;
}

- (CGSize)chartView:(FCChartView *)chartView sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==5) {
        return CGSizeMake(80, 60);
    }
    if (indexPath.section==0) {
        return CGSizeMake(80, 60);
    }
    if (indexPath.section == 3 &&indexPath.row ==4) {
        return CGSizeMake(160, 30);
    }
    if (indexPath.section == 3 &&indexPath.row ==5) {
        return CGSizeMake(0, 30);
    }
    return CGSizeMake(80, 30);
}


#pragma mark - Getter Methods

- (FCChartView *)chartV{
    if (!_chartV) {
        _chartV = [[FCChartView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200) type:FCChartViewTypeSectionAndRowFixation dataSource:self];
    }
    return _chartV;
}

- (NSArray *)mains{
    if (!_mains) {
        _mains = @[@[@"小题1",@"小题2",@"小题3",@"小题4",@"小题5",@"小题6",@"小题7",@"小题8",@"小题9",@"小题10",@"小题11",@"小题12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]
                   ,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    }
    return _mains;
}


@end
