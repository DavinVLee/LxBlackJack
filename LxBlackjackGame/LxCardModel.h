
#import <Foundation/Foundation.h>
#import "LxCardNode.h"
#import "LxCardNode.h"
@interface LxCardModel : NSObject
/**
 *@description 卡牌类型
 **/
@property (assign, nonatomic) LxCardType type;
/**
 *@description tag
 **/
@property (assign, nonatomic) NSInteger tag;
/**
 *@description 获取点数大小
 **/
@property (assign, nonatomic) NSInteger pointCount;

/**
 *@description 存放卡牌UI
 **/
@property (strong, nonatomic) LxCardNode *cardNode;
+ (LxCardModel *)randomModel;
@end
