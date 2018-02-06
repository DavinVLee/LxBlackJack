
#import <Foundation/Foundation.h>
#import "WeAVAudioPlayer.h"


@interface WeBackGroundMusicManage : NSObject

@property (assign, nonatomic) CGFloat volume;

/**
 *默认设置
 **/
- (void)setupDefault;
/**
 *播放地图首页音乐
 **/
- (void)playMapBgMusic;
/**
 *暂停音乐播放
 **/
- (void)pausePlayer;
- (void)pauseMapBgMusic;
- (void)stopPlayer;


/**
 *播放音效(直接播放、音效与音效之间不冲突)
 **/
- (void)playVoiceWithType:(PlayVoiceType)type;

+ (WeBackGroundMusicManage *)sharedInstance;

@end
