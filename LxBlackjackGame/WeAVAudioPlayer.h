
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSInteger, PlayVoiceType){
    PlayVoiceVikter,//胜利音效
    playVoiceError,//失败音效
    playVoiceClick,
    PlayVoiceDrum,//鼓声
    PlayVoiceGun,//炮声
};
@interface WeAVAudioPlayer : AVAudioPlayer
/**
 *播放声音类型
 **/
@property (assign, nonatomic) PlayVoiceType voiceType;
@end
