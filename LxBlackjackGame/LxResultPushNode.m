

#import "LxResultPushNode.h"
#import "UIImage+Default.h"

@implementation LxResultPushNode

+ (void)showResultWithType:(LxGameStatus)type block:(LxResultBlock)block
{
    LxResultPushNode *node = [[LxResultPushNode alloc] init];
    node.block = [block copy];
    NSString *imageName = nil;
    switch (type) {
        case LxGameWin:
            imageName = @"win@2x";
            break;
        case LxGameLose:
            imageName = @"lose@2x";
            break;
        case LxGamePush:
            imageName = @"push@2x";
            break;
            
        default:
            break;
    }
    UIImage *image = [UIImage lx_imageFromBundleWithName:imageName];
    node.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
    [mKeyWindow addSubnode:node];
    node.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    ASImageNode *imageNode = [[ASImageNode alloc] init];
    imageNode.image = image;
    imageNode.frame = CGRectMake((mScreenWidth - image.size.width)/2.f, (mScreenHeight - image.size.height)/2.f, image.size.width , image.size.height);
    
    [node addSubnode:imageNode];
    node.userInteractionEnabled = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.userInteractionEnabled) {
        if (_block) {
            _block(YES);
            _block = nil;
            self.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.7
                              animations:^{
                                  self.view.alpha = 0;
                              } completion:^(BOOL finished) {
                                  [self removeFromSupernode];
                              }];
        }
    }
}

@end
