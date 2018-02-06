
#import "LxCardNode.h"

@interface LxCardNode ()

@property (assign, nonatomic) BOOL changed;
@end

@implementation LxCardNode

- (void)setupCardWithCardType:(LxCardType)type
                          tag:(NSInteger)tag
{
    NSMutableString *cardImageName = [NSMutableString string];
    switch (type) {
        case LxCardClubs:
            [cardImageName appendString:@"cardClubs"];
            break;
            case LxCardHeart:
            [cardImageName appendString:@"cardHearts"];
            break;
            case LxCardSpader:
            [cardImageName appendString:@"cardSpades"];
            break;
            case LxCardDiamonds:
            [cardImageName appendString:@"cardDiamonds"];
            break;
        default:
            break;
    }
    switch (tag) {
        case 1:
            [cardImageName appendString:@"A@2x"];
            break;
        case 2:
            [cardImageName appendString:@"2@2x"];
            break;
        case 3:
            [cardImageName appendString:@"3@2x"];
            break;
        case 4:
            [cardImageName appendString:@"4@2x"];
            break;
        case 5:
            [cardImageName appendString:@"5@2x"];
            break;
        case 6:
            [cardImageName appendString:@"6@2x"];
            break;
        case 7:
            [cardImageName appendString:@"7@2x"];
            break;
        case 8:
            [cardImageName appendString:@"8@2x"];
            break;
        case 9:
            [cardImageName appendString:@"9@2x"];
            break;
        case 10:
            [cardImageName appendString:@"10@2x"];
            break;
        case 11:
            [cardImageName appendString:@"J@2x"];
            break;
        case 12:
            [cardImageName appendString:@"Q@2x"];
            break;
        case 13:
            [cardImageName appendString:@"K@2x"];
            break;
            
        default:
            break;
    }
    
    UIImage *frontImage = [UIImage lx_imageFromBundleWithName:cardImageName];
    _frontImageNode = [[UIImageView alloc] init];
    _frontImageNode.image = frontImage;
    _frontImageNode.frame = CGRectMake(0, 0, frontImage.size.width, frontImage.size.height);
    [self addSubview:_frontImageNode];
    _frontImageNode.userInteractionEnabled = NO;
    
    UIImage *backImage = [UIImage lx_imageFromBundleWithName:@"cardBack_red4@2x"];
    _backImageNode = [[UIImageView alloc] init];
    _backImageNode.image = backImage;
    _backImageNode.frame = CGRectMake(0,0, backImage.size.width, backImage.size.height);
    [self addSubview:_backImageNode];
    _backImageNode.userInteractionEnabled = NO;
    
    CGRect rect = self.frame;
    rect.size = _frontImageNode.frame.size;
    self.frame = rect;
    self.userInteractionEnabled = YES;
}

- (void)changeSideToFront:(BOOL)front
{
    // 翻转动画
    if (front) {
        _isFront = YES;
        [UIView transitionFromView:_backImageNode
                            toView: _frontImageNode
                          duration:0.7
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finished) {
                            _isFront = YES;
                        }];
    }else
    {
        _isFront = NO;
         [UIView transitionFromView:_frontImageNode
                             toView:_backImageNode
                           duration:0.7
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         completion:^(BOOL finished) {
                             _isFront = NO;
                         }];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (!_changed) {
        [self changeSideToFront:YES];
    }else
    {
        [self changeSideToFront:NO];
    }
}

- (CGSize)defaultSize
{
    return CGSizeMake(70, 95);
}

@end
