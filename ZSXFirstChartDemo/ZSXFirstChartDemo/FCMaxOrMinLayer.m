//
//  FCMaxOrMinLayer.m
//  ZSXFirstChartDemo
//
//  Created by 邹时新 on 2018/6/15.
//  Copyright © 2018年 zoushixin. All rights reserved.
//

#import "FCMaxOrMinLayer.h"

@implementation FCMaxOrMinLayer

- (void)drawInContext:(CGContextRef)ctx{
    CGContextRef context = ctx;
    UIGraphicsPushContext(context);
    UIColor* color2 = self.type==FCMaxOrMinLayerTypeMax?[UIColor colorWithRed: 0.922 green: 0.902 blue: 0.357 alpha: 1]:[UIColor colorWithRed: 0.502 green: 0.498 blue: 0.502 alpha: 1];
    
    CGRect rectangleRect = CGRectMake(9/2, 0, 63/2, 29/2);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: rectangleRect cornerRadius: 5/2];
    [color2 setFill];
    [rectanglePath fill];
    {
        NSString* textContent = self.type==FCMaxOrMinLayerTypeMax?@"最高":@"最低";
        NSMutableParagraphStyle* rectangleStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        rectangleStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* rectangleFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 18/2], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: rectangleStyle};
        
        CGFloat rectangleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rectangleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rectangleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rectangleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rectangleRect), CGRectGetMinY(rectangleRect) + (CGRectGetHeight(rectangleRect) - rectangleTextHeight) / 2, CGRectGetWidth(rectangleRect), rectangleTextHeight) withAttributes: rectangleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 15/2)];
    [bezierPath addLineToPoint: CGPointMake(9/2, 10/2)];
    [bezierPath addLineToPoint: CGPointMake(9/2, 20/2)];
    [color2 setFill];
    [bezierPath fill];
    UIGraphicsPopContext();
}



@end
