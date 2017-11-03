//
//  CALayer+Default.h
//  SmartPiano
//
//  Created by 李翔 on 2017/5/9.
//  Copyright © 2017年 Ydtec. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface CALayer (Default)

/***********************************Image************************************//**
 *@description 设置图片
 *@param image 设置的图片对象
 **/
- (void)lx_setImage:(UIImage *)image;
/**
 *@description 根据图片名称设置图片
 *@param imageName 图片名称
 *@return 图片
 **/
- (UIImage *)lx_setImageWithImageName:(NSString *)imageName;
/**
 *@description 获取图片
 **/
- (UIImage *)lx_snapshotImage;
/**
 *@description 获取图片,默认居中
 *@param edge 截取图片画板内容个方向的增量
 **/
- (UIImage *)lx_snapshotImageWithOffsetEdge:(UIEdgeInsets)edge;

/***********************************coreAnimation************************************/

/**
 *@description 暂停动画
 **/
- (void)lx_pauseAnimation;
/**
 *@description 重新开始动画
 **/
- (void)lx_resumeAnimation;
/***********************************base************************************/
- (NSString *)lx_address;
@end
