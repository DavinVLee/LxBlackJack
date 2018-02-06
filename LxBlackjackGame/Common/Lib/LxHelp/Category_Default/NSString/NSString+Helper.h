
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helper)
/***********************************get************************************///
/**
 *@description 获取数组
 **/
- (NSMutableArray *)lx_getArray;

/**N
 *@description 获取字典
 **/
- (NSMutableDictionary *)lx_getDictionary;


/**
 *@description 获取本地cache目录
 **/
+ (NSString *)lx_cacheFolderPath;

/***********************************文本************************************///
/**
 *@description 获取字符串的内容大小
 **/
- (CGSize)lx_textSizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize;



@end
