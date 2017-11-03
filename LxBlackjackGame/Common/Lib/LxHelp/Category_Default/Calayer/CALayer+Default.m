//
//  CALayer+Default.m
//  SmartPiano
//
//  Created by 李翔 on 2017/5/9.
//  Copyright © 2017年 Ydtec. All rights reserved.
//

#import "CALayer+Default.h"
#import "UIImage+Default.h"

@implementation CALayer (Default)

#pragma mark - SetMethod
- (void)lx_setImage:(UIImage *)image
{
    self.contents = (id)[image CGImage];
}

#pragma mark - GetMethod
- (NSString *)lx_address
{
    return [NSString stringWithFormat:@"%p",self];
}
#pragma mark - CallFunction

- (UIImage *)lx_setImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage lx_imageFromBundleWithName:imageName];
    if (image) {
        [self setContents:(id)[image CGImage]];
    }
    return image;
}


- (UIImage *)lx_snapshotImage {
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
/**
 *@description 获取图片,默认居中
 *@param edge截取图片画板内容个方向的增量
 **/
- (UIImage *)lx_snapshotImageWithOffsetEdge:(UIEdgeInsets)edge
{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width + (edge.left + edge.right), self.bounds.size.height + (edge.top + edge.right)), self.opaque, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, edge.left, edge.top);
        [self renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (void)lx_pauseAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)lx_resumeAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}
@end
