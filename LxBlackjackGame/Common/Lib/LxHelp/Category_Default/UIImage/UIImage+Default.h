

#import <UIKit/UIKit.h>

@interface UIImage (Default)
/**
 *@description 从bundle读取图片
 **/
+ (UIImage *)lx_imageFromBundleWithName:(NSString *)imageName;

/**
 *@description 图片主题色修改
 *@param tintColor 元素主题颜色
 **/
- (UIImage *)lx_imageWithTintColor:(UIColor *)tintColor;
/**
 *@description 图片主题色修改
 *@param tintColor 主题色
 *@param blendMode 填充模式
 **/
- (UIImage *)lx_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
@end
