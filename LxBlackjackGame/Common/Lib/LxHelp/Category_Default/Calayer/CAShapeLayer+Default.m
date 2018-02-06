

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
