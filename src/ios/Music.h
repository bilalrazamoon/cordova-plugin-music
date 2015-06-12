#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>
#import <MediaPlayer/MPMediaQuery.h>
#import <MediaPlayer/MPMediaPlaylist.h>

#import <AVFoundation/AVFoundation.h>

@interface Music : CDVPlugin <AVAudioPlayerDelegate>
{
    AVAudioPlayer  *player;
}

- (void) getPlaylists:(CDVInvokedUrlCommand*)command;

- (void) getSongs:(CDVInvokedUrlCommand*)command;

- (void) getSongsFromPlaylist:(CDVInvokedUrlCommand*)command;

- (void)stopSong:(CDVInvokedUrlCommand*)command;

- (void)playSong:(CDVInvokedUrlCommand*)command;


@end