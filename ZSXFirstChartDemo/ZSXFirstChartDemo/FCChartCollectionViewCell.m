//
//  FCChartCollectionViewCell.m
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/13.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import "FCChartCollectionViewCell.h"
#import "FCMaxOrMinLayer.h"

@interface FCChartCollectionViewCell()

@property (nonatomic,strong)CATextLayer *textLayer;

@property (nonatomic,strong)FCMaxOrMinLayer *maxLayer;
@property (nonatomic,strong)FCMaxOrMinLayer *minLayer;

@property (nonatomic,strong)UILabel *textLabel;



@end

@implementation FCChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
//    self.maxLayer.frame = CGRectMake(self.bounds.size.width/2, (self.bounds.size.height-15)/2, 36, 15);
//    self.minLayer.frame = CGRectMake(self.bounds.size.width/2, (self.bounds.size.height-15)/2, 36, 15);
}
//
//- (void)drawRect:(CGRect)rect{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 0.5f);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, rect.size.width, 0);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextAddLineToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context,0, 0);
//    CGContextStrokePath(context);
//}

#pragma mark - Private Methods

- (void)configUI{
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.textLabel];
//    [self.contentView.layer addSublayer:self.textLayer];
//    [self.contentView.layer insertSublayer:self.maxLayer atIndex:0];
//    [self.contentView.layer insertSublayer:self.minLayer atIndex:0];
//
//    [self.maxLayer setNeedsDisplay];
//    [self.minLayer setNeedsDisplay];
    self.contentView.clipsToBounds = YES;
    self.clipsToBounds = YES;
}

#pragma mark - Getter Methods

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel                 = [[UILabel alloc] init];
        _textLabel.textAlignment   = NSTextAlignmentCenter;
        _textLabel.textColor       = [UIColor blackColor];
        _textLabel.lineBreakMode   = NSLineBreakByTruncatingTail;
        _textLabel.font            = [UIFont systemFontOfSize:13];
        _textLabel.numberOfLines   = 0;
    }
    return _textLabel;
}


- (CATextLayer *)textLayer{
    if (!_textLayer) {
        _textLayer = [[CATextLayer alloc] init];
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        _textLayer.foregroundColor = [UIColor blackColor].CGColor;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.wrapped = NO;
        _textLayer.truncationMode = kCATruncationEnd;
        UIFont *font = [UIFont systemFontOfSize:16];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
    }
    return _textLayer;
}

- (FCMaxOrMinLayer *)maxLayer{
    if (!_maxLayer) {
        _maxLayer = [FCMaxOrMinLayer layer];
        _maxLayer.type = FCMaxOrMinLayerTypeMax;
        _maxLayer.bounds = CGRectMake(0, 0, 36, 15) ;
        _maxLayer.contentsScale = [UIScreen mainScreen].scale;
        _maxLayer.hidden = YES;
    }
    return _maxLayer;
}
- (FCMaxOrMinLayer *)minLayer{
    if (!_minLayer) {
        _minLayer = [FCMaxOrMinLayer layer];
        _minLayer.type = FCMaxOrMinLayerTypeMin;
        _minLayer.bounds = CGRectMake(0, 0, 36, 15) ;
        _minLayer.contentsScale = [UIScreen mainScreen].scale;
        _minLayer.hidden = YES;
    }
    return _minLayer;
}

#pragma mark - Setter Methods

- (void)setText:(NSString *)text{
    _text = text;
//    self.textLayer.string = text;
    self.textLabel.text = text;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textLabel.textColor = textColor;

//    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setCellType:(FCChartCollectionViewCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case FCChartCollectionViewCellTypeDefault:
        {
            self.textLayer.frame = self.bounds;
            self.minLayer.hidden = YES;
            self.maxLayer.hidden = YES;
            self.textLayer.alignmentMode = kCAAlignmentCenter;
        }
            break;
        case FCChartCollectionViewCellTypeMax:
        {
            self.textLayer.frame = CGRectMake(0, (self.bounds.size.height-21)/2, self.bounds.size.width/2, 16);
            self.minLayer.hidden = YES;
            self.maxLayer.hidden = NO;
            self.textLayer.alignmentMode = kCAAlignmentRight;

        }
            break;
        case FCChartCollectionViewCellTypeMin:
        {
            self.textLayer.frame = CGRectMake(0, (self.bounds.size.height-21)/2, self.bounds.size.width/2, 16);
            self.minLayer.hidden = NO;
            self.maxLayer.hidden = YES;
            self.textLayer.alignmentMode = kCAAlignmentRight;

        }
            break;
            
        default:
            break;
    }
}




@end
