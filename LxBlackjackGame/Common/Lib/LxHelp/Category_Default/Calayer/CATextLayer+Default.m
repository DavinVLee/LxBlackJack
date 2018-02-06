

#import "CATextLayer+Default.h"
#import "UIFont+Default.h"

@implementation CATextLayer (Default)

#pragma mark - GetMethod
+ (instancetype)lx_getDefaultTextLayerWithFontSize:(CGFloat)fontSize
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = NO;//换行
    
    UIFont *font = [UIFont lx_shangGFontOfSize:fontSize];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    return textLayer;
}

@end
