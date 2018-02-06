

#import <Foundation/Foundation.h>

@interface NSMutableArray (Helper)
/**
 *@description 加入元素（避免空值或Null)
 **/
- (void)lx_addSafityObject:(id)object;
@end
