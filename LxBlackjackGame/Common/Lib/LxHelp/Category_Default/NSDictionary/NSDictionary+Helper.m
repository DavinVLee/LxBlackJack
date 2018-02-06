

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)
#pragma mark - GetMethod
//获取jsonStr
- (NSString *)lx_JsonString;
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        return @"error";
    }
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
