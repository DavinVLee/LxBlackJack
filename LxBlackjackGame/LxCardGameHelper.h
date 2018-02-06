

#import <Foundation/Foundation.h>
#import "LxCardModel.h"

@interface LxCardGameHelper : NSObject

/**
 *@description 获取随机后的4副牌的容器
 **/
+ (NSMutableArray <LxCardModel *>*)getRandomCardsModelArray;

@end
