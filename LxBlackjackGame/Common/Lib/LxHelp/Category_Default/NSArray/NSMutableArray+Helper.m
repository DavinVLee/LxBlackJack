

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

- (void)lx_addSafityObject:(id)object
{
    
    if (object != nil && ![object isKindOfClass:[NSNull class]]) {
        [self addObject:object];
    }
}
@end
