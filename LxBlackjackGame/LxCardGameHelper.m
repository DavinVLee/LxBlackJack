

#import "LxCardGameHelper.h"

@implementation LxCardGameHelper

+ (NSMutableArray <LxCardModel *>*)getRandomCardsModelArray
{
    NSMutableArray <LxCardModel *>* CardModelArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *totalCardModelArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < 4; i ++) {
        for (int j = 1; j < 14; j ++) {
            LxCardModel *ClubNode = [[LxCardModel alloc] init];
            ClubNode.type = LxCardClubs;
            ClubNode.tag = j;
            [totalCardModelArray addObject:ClubNode];
        }
        for (int j = 1 ; j < 14; j ++) {
            LxCardModel *diamondModel = [[LxCardModel alloc] init];
            diamondModel.type = LxCardDiamonds;
            diamondModel.tag = j;
            [totalCardModelArray addObject:diamondModel];
        }
        for (int j = 1; j < 14; j ++) {
            LxCardModel *heartModel = [[LxCardModel alloc] init];
            heartModel.type = LxCardHeart;
            heartModel.tag = j;
            [totalCardModelArray addObject:heartModel];
        }
        for (int j = 1; j < 14 ; j ++) {
            LxCardModel *spaderModel = [[LxCardModel alloc] init];
            spaderModel.type = LxCardSpader;
            spaderModel.tag = j;
            [totalCardModelArray addObject:spaderModel];
        }
        
        
    }
    
    for (int i = 0; i < 208 ; i ++) {
        LxCardModel *tempModel = totalCardModelArray[arc4random() % totalCardModelArray.count];
        [CardModelArray addObject:tempModel];
        [totalCardModelArray removeObject:tempModel];
    }
    
    
    
    return CardModelArray;
}

@end
