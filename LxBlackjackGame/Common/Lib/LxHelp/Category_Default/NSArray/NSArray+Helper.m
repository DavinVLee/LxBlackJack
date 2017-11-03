//
//  NSArray+Helper.m
//  svgtest2
//
//  Created by 李翔 on 2017/4/25.
//  Copyright © 2017年 ydkj. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

#pragma mark - GetMethod
//获取jsonStr
- (NSString *)lx_JsonString;
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        return @"error";
    }
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

//确认所有元素为指定类型
- (BOOL)lx_checkElementsMicClass:(Class)aClass
{
    for (id object in self) {
        if (![object isKindOfClass:aClass]) {
            return NO;
        }
    }
    return YES;
}
@end
