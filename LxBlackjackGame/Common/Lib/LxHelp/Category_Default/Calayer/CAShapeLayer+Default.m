//
//  CAShapeLayer+Default.m
//  SmartPiano
//
//  Created by 李翔 on 2017/5/18.
//  Copyright © 2017年 Ydtec. All rights reserved.
//

#import "CAShapeLayer+Default.h"
#import <UIKit/UIKit.h>

@implementation CAShapeLayer (Default)

#pragma mark - GetMethod
+ (CAShapeLayer *)lx_roundedRectangleWithSize:(CGSize)rectangSize corners:(CGFloat)corners
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rectangSize.width, rectangSize.height) cornerRadius:corners];
    layer.path = path.CGPath;
    
    return layer;
}

@end
