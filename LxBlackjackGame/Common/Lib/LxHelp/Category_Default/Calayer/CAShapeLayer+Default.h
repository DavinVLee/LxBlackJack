
#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (Default)

/**
 *@description 获取带圆角矩形
 *@param rectangSize 矩形大小
 *@param corners 圆角
 **/
+ (CAShapeLayer *)lx_roundedRectangleWithSize:(CGSize)rectangSize corners:(CGFloat)corners;


@end
