
#import "ASButtonNode+ClickHelp.h"
#define kAsbtnCoverTag  99  /** 覆盖view的tag值**/
@implementation ASButtonNode (ClickHelp)

#pragma mark - OverWrite_Function
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.enabled) {
        [self checkAndSetCover];
        [UIView animateWithDuration:0.10
                              delay:0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1 animations:^{
                                  self.view.transform = CGAffineTransformIdentity;
                             }];
                           
                         }];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self checkAndCloseCover];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self checkAndCloseCover];
}

//- (void)setCovered:(BOOL)covered
//{
//    if (covered) {
//        [self checkAndSetCover];
//    }else
//    {
//        [self checkAndCloseCover];
//    }
//}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        [self checkAndSetCover];
    } else {
        [self checkAndCloseCover];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self checkAndSetCover];
    } else {
        [self checkAndCloseCover];
    }
}

#pragma mark - Call_Function
- (void)checkAndSetCover
{
    [self coverView].hidden = NO;
}

- (void)checkAndCloseCover
{
    if (!self.selected) {
         [self coverView].hidden = YES;
    }
}

#pragma mark - Get_Method
- (UIView *)coverView
{
    UIView *coverView = [self.view viewWithTag:kAsbtnCoverTag];
    if (!coverView) {
        coverView = [UIView new];
        coverView.frame = CGRectMake(2, 2, CGRectGetWidth(self.frame) - 4, CGRectGetHeight(self.frame) - 4);
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        coverView.tag = kAsbtnCoverTag;
        coverView.userInteractionEnabled = NO;
        coverView.hidden = NO;
        [self.view addSubview:coverView];
    }
    return coverView;
}


@end
