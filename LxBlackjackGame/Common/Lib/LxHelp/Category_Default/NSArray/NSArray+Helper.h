//
//  NSArray+Helper.h
//  svgtest2
//
//  Created by 李翔 on 2017/4/25.
//  Copyright © 2017年 ydkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helper)

/**
 *@description 获取字符
 **/
- (NSString *)lx_JsonString;


/**
 *@description 确认所有元素为指定类型
 **/
- (BOOL)lx_checkElementsMicClass:(Class)aClass;


@end
