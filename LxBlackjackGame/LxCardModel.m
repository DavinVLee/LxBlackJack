
#import "LxCardModel.h"

@implementation LxCardModel

+ (LxCardModel *)randomModel
{
    LxCardModel *model = [[LxCardModel alloc] init];
    model.type = arc4random() % 4;
    model.tag = 1 + arc4random() % 13;
    return model;
}

- (NSInteger)pointCount
{
    if (self.tag <= 10) {
        return self.tag;
    }else
    {
        return 10;
    }
}
@end
