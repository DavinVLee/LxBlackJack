

#import "UIViewController+Default.h"

@implementation UIViewController (Default)

#pragma mark - Animation
- (void)lx_transitionWithType:(NSString *)type
                  WithSubtype:(NSString *)subtype
                     Duration:(NSTimeInterval)duration
                      ForView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.type = type;
    if (!subtype) {
        animation.subtype = subtype;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:animation forKey:@"transitionAni"];
    
    
    
}


@end
