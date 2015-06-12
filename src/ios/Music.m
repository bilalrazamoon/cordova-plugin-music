#import "Music.h"

@implementation Music

- (void)getPlaylists:(CDVInvokedUrlCommand*)command
{
     [self.commandDelegate runInBackground:^{
    //getAllPlaylists
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery playlistsQuery];
    NSArray *playlists = [myPlaylistsQuery collections];
    NSMutableArray* returnPlaylits = [NSMutableArray arrayWithCapacity:1];
    
    for (MPMediaPlaylist *playlist in playlists) {
        NSString *playListId = [NSString stringWithFormat:@"%@", [playlist valueForProperty: MPMediaPlaylistPropertyPersistentID]];
        NSString *playListName = [NSString stringWithFormat:@"%@", [playlist valueForProperty: MPMediaPlaylistPropertyName]];
        NSMutableDictionary* po = [NSMutableDictionary dictionaryWithCapacity:1];
        [po setObject: playListName forKey:@"name"];
        [po setObject: playListId forKey:@"id"];
        [returnPlaylits addObject:po];
    }
    NSLog(@"%@", returnPlaylits);
    
    CDVPluginResult* pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsArray:returnPlaylits];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
         }];
}

- (void)getSongs:(CDVInvokedUrlCommand*)command
{
  [self.commandDelegate runInBackground:^{
    //getAllSongs
    MPMediaQuery *mySongsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [mySongsQuery items];
    NSMutableArray* songsArray = [NSMutableArray arrayWithCapacity:1];
    
    for (MPMediaItem *song in songs) {
        NSString *songtId = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyPersistentID]];
        NSString *songName = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyTitle]];
        NSString *songArtist = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyArtist]];
        
        NSMutableDictionary* so = [NSMutableDictionary dictionaryWithCapacity:1];
        
        [so setObject: songName forKey:@"name"];
        [so setObject: songtId forKey:@"id"];
        [so setObject: songArtist forKey:@"artist"];
        
        [songsArray addObject:so];
    }
    
    NSLog(@"%@", songsArray);
    
    CDVPluginResult* pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsArray:songsArray];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
      }];
}

- (void)getSongsFromPlaylist:(CDVInvokedUrlCommand*)command
{
     [self.commandDelegate runInBackground:^{
    //getPlaylistById
    NSString *playlistId = [command.arguments objectAtIndex:0];
    NSLog(@"PlaylistId: %@", playlistId);
    
    MPMediaPropertyPredicate *playlistIdPredicate =
    [MPMediaPropertyPredicate predicateWithValue:playlistId
                                     forProperty:MPMediaItemPropertyPersistentID];
    
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery playlistsQuery];
    [myPlaylistsQuery addFilterPredicate:playlistIdPredicate];
    
    NSArray *playlists = [myPlaylistsQuery collections];
    NSMutableArray* songsArray = [NSMutableArray arrayWithCapacity:1];
    
    NSString *playlistName;
    if (playlists.count > 0)
    {
        //song exists
        MPMediaPlaylist *playlist = [playlists objectAtIndex:0];
        NSArray *songs = [playlist items];
        
        if (songs.count > 0) {
            
            NSLog(@"Songs Availabe");
            
            for (MPMediaItem *song in songs) {
                NSString *songtId = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyPersistentID]];
                NSString *songName = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyTitle]];
                NSString *songArtist = [NSString stringWithFormat:@"%@", [song valueForProperty: MPMediaItemPropertyArtist]];
                
                NSMutableDictionary* so = [NSMutableDictionary dictionaryWithCapacity:1];
                
                [so setObject: songName forKey:@"name"];
                [so setObject: songtId forKey:@"id"];
                [so setObject: songArtist forKey:@"artist"];
                
                [songsArray addObject:so];
            }
        }
        playlistName= [playlist valueForProperty: MPMediaPlaylistPropertyName];
        NSLog(@"%@", playlistName);
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsArray:songsArray];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
          }];
}


- (void)playSong:(CDVInvokedUrlCommand*)command
{
     [self.commandDelegate runInBackground:^{
    
    //getPlaylistById
    NSString *songId = [command.arguments objectAtIndex:0];
    NSLog(@"songId: %@", songId);
    
    MPMediaPropertyPredicate *songIdPredicate =
    [MPMediaPropertyPredicate predicateWithValue:songId
                                     forProperty:MPMediaItemPropertyPersistentID];
    
    MPMediaQuery *mySongQuery = [MPMediaQuery songsQuery];
    [mySongQuery addFilterPredicate:songIdPredicate];
    
    NSArray *songs = [mySongQuery items];
    
    NSString *songName;
    NSString *songid;
    if (songs.count > 0)
    {
        //song exists
        MPMediaItem *song = [songs objectAtIndex:0];
        songName= [song valueForProperty: MPMediaItemPropertyTitle];
        songid= [song valueForProperty: MPMediaItemPropertyPersistentID];
        NSURL *url = [song valueForProperty:MPMediaItemPropertyAssetURL];
        NSLog(@"songName: %@", songName);
        
        // Play the item using AVPlayer
        //AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
        
        if (player != nil) {
            [player stop];
            player.currentTime=0.0f;
            player = nil;
            [NSThread sleepForTimeInterval:.5];

        }
        
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL: url
                                                                        error: nil];
        
            
        player.delegate = self;
        [player prepareToPlay];
        [player play];
    }
     }];
}

- (void)stopSong:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{

    if (player.playing) {
        NSLog(@"Stopping song");

        [player stop];
     }
        CDVPluginResult* pluginResult = [CDVPluginResult
                                         resultWithStatus:CDVCommandStatus_OK
                                         messageAsString: @"Audio Stopped"];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    }];

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying");

    NSString* jsString = nil;
    if (flag) {
        jsString = [NSString stringWithFormat:@"%@(\"%s\");", @"window.cordova.plugins.Music.onMessageFromNative", "Audio Completed"];
    } else {
        jsString = [NSString stringWithFormat:@"%@(\"%s\");", @"window.cordova.plugins.Music.onMessageFromNative", "Error"];
    }
    [self.commandDelegate evalJs:jsString];
}


@end