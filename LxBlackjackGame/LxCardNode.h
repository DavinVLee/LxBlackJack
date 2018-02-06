
#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef NS_ENUM(NSInteger,LxCardType)
{
    LxCardClubs = 0,
    LxCardDiamonds ,
    LxCardHeart,
    LxCardSpader,
};
@interface LxCardNode : UIView
@property (strong, nonatomic) UIImageView *backImageNode;
@property (strong, nonatomic) UIImageView *frontImageNode;
/**
 *@description 卡牌是否翻开
 **/
@property (assign, nonatomic) BOOL isFront;

/**
 *@description 设置卡牌UI
 **/
- (void)setupCardWithCardType:(LxCardType)type
                          tag:(NSInteger)tag;

- (CGSize)defaultSize;

- (void)changeSideToFront:(BOOL)front;

@end
