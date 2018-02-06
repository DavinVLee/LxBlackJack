

#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef void(^LxResultBlock)(BOOL isFinish);
typedef NS_ENUM(NSInteger,LxGameStatus)
{
    LxGameWin,
    LxGameLose,
    LxGamePush,
};
@interface LxResultPushNode : ASDisplayNode

/**
 *@description 回调存放
 **/
@property (copy,nonatomic) LxResultBlock block;

+ (void)showResultWithType:(LxGameStatus)type block:(LxResultBlock)block;
@end
