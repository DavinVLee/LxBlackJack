

#import <UIKit/UIKit.h>

@protocol LxBottomBarDelegate <NSObject>

- (void)btnClickIndex:(NSInteger)index;

@end

@interface lxBottomBar : UIView

@property (weak, nonatomic) id <LxBottomBarDelegate> delegate;

- (void)setupDefault;

@end
