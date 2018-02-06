

#import "WeBackGroundMusicManage.h"
#import <MediaPlayer/MediaPlayer.h>


@interface WeBackGroundMusicManage ()<AVAudioPlayerDelegate>
/**
 *音乐播放器
 **/
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

/***********************************************声效部分***************************************/
/**
 *所有短音乐播放容器  (type : nsmutableArray(voicePlayer))
 **/
@property (strong, nonatomic) NSMutableDictionary *voiceInfoDic;

@property (strong, nonatomic) NSMutableArray <WeAVAudioPlayer *>*playerArray;

@end

@implementation WeBackGroundMusicManage

+ (WeBackGroundMusicManage *)sharedInstance
{
    static WeBackGroundMusicManage *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WeBackGroundMusicManage alloc] init];
        _sharedInstance.playerArray = [[NSMutableArray alloc] init];
        _sharedInstance.volume = 0.4;
    });
    return _sharedInstance;
    
}

- (void)setVolume:(CGFloat)volume
{
    _volume  = volume;
    for (WeAVAudioPlayer *player in _playerArray) {
        player.volume = volume;
    }
}
#pragma mark - CallFunction
- (void)playVoiceWithType:(PlayVoiceType)type
{
    NSURL *voiceUrl = nil;
    CGFloat volume = self.volume;
    switch (type) {
        case PlayVoiceVikter:
            voiceUrl = [[NSBundle mainBundle] URLForResource:@"TowerUpdata" withExtension:@"mp3"];
            break;
        case playVoiceError:
            voiceUrl = [[NSBundle mainBundle] URLForResource:@"error" withExtension:@"wav"];
            break;
            case PlayVoiceDrum:
            voiceUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Clickwheel" ofType:@"mp3"]];
            break;
            case PlayVoiceGun:
        {
            voiceUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dapao" ofType:@"wav"]];
            volume = 1;
        }
            break;
            case playVoiceClick:
            voiceUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clickwheel" ofType:@"mp3"]];
            break;
        default:
            break;
    }
    
    NSMutableArray *playerArray = self.voiceInfoDic[@(type)];
    if (playerArray.count > 2 && type == playVoiceError) {//做限制，避免鬼畜声音
        return;
    }else if (playerArray == nil)
    {
        playerArray = [NSMutableArray array];
        [self.voiceInfoDic setObject:playerArray forKey:@(type)];
    }
    
    WeAVAudioPlayer *player = [[WeAVAudioPlayer alloc] initWithContentsOfURL:voiceUrl error:nil];
    player.volume = volume;
    player.delegate = self;
    player.voiceType = type;
    [player prepareToPlay];
    [player play];
    [_playerArray addObject:player];
}

#pragma mark - GetMethod
- (NSMutableDictionary *)voiceInfoDic
{
    if (!_voiceInfoDic) {
        _voiceInfoDic = [[NSMutableDictionary alloc] init];
    }
    return _voiceInfoDic;
}

#pragma mark - VoiceDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ([player isKindOfClass:[WeAVAudioPlayer class]]) {
        NSMutableArray *playerArray = self.voiceInfoDic[@(((WeAVAudioPlayer *)player).voiceType)];
        [playerArray removeObject:player];
        player = nil;
    }else
    {
 
    }
   
    
}

#pragma mark - *************************************BackGroundMusicPart*********************************
#pragma mark -BackGroundMusicFUNCTION

- (void)pauseMapBgMusic
{

}


- (void)playMapBgMusic
{

    NSURL *voiceUrl = [[NSBundle mainBundle] URLForResource:@"MX054_31" withExtension:@"mp3"];
    WeAVAudioPlayer *player = [[WeAVAudioPlayer alloc] initWithContentsOfURL:voiceUrl error:nil];
    player.volume = _volume;
    player.delegate = self;
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    [_playerArray addObject:player];
}

- (void)pausePlayer
{
    [self.audioPlayer pause];
    
}

- (void)stopPlayer
{

    [self.audioPlayer stop];
}

@end
