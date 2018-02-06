
#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)
- (void)lx_setEnlargeEdge:(CGFloat) size;
/**
 *@description 设置可点击范围（在原有大小基础上增加范围)
 **/
- (void)lx_setEnlargeEdgeWithTop:(CGFloat) top
                           right:(CGFloat) right
                          bottom:(CGFloat) bottom
                            left:(CGFloat) left;
@end
