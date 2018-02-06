
#import "NSString+Helper.h"

@implementation NSString (Helper)
#pragma mark - GetMethod
//字符转数组
- (NSMutableArray *)lx_getArray;
{
    if (self.length > 0) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error ;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                                           error:&error];
        if (array.count >0 ) {
            return [NSMutableArray arrayWithArray:array];
        }
    }
    return [NSMutableArray new];
}

//字符转字典
- (NSMutableDictionary *)lx_getDictionary;
{
    if (self.length > 0) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error ;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                                           error:&error];
        if (info) {
            return [NSMutableDictionary dictionaryWithDictionary:info];
        }
    }
    return [NSMutableDictionary new];
}

//获取本地cache目录
+ (NSString *)lx_cacheFolderPath
{
     return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *@description 获取字符串的内容大小
 **/
- (CGSize)lx_textSizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize
{
    
    NSDictionary *dic = @{NSFontAttributeName : font};

    CGRect rect = [self boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic
                                     context:nil];
    return rect.size;
}

@end
