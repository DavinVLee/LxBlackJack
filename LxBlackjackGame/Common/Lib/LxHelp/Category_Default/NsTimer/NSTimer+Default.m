

#import "NSTimer+Default.h"

@implementation NSTimer (Default)

- (void)lx_pause
{
    [self setFireDate:[NSDate distantFuture]];
}

- (void)lx_resume
{
    [self setFireDate:[NSDate date]];
}

@end
