# cordova-plugin-music

This plugin provides the ability to retrieve songs list, playlist, songs from playlist, play and stop song.

## Installation

    cordova plugin add https://github.com/hafizbilal112/cordova-plugin-music

## Supported Platforms

- Android
- iOS

### Methods

- [`window.cordova.plugins.Music.getSongs`](#windowcordovapluginsmusicgetsongs): Returns the list of songs.

- [`window.cordova.plugins.Music.getPlaylists`](#windowcordovapluginsmusicgetplaylists): Returns the list of playlists.

- [`window.cordova.plugins.Music.getSongsFromPlaylist`](#windowcordovapluginsmusicgetsongsfromplaylist): Returns the list of songs from playlist.

- [`window.cordova.plugins.Music.playSong`](#windowcordovapluginsmusicplaysong): Play song by song id.

- [`window.cordova.plugins.Music.stopSong`](#windowcordovapluginsmusicstopsong): Stop song.

## window.cordova.plugins.Music.getSongs

Returns the list of songs.

    window.cordova.plugins.Music.getSongs(
        // success callback
        function (list) {
            console.log("songs length" + list.length);
        },
        // error callback
        function (e) {
            console.log("Error getting message=" + e);
        }
    );

## window.cordova.plugins.Music.getPlaylists

Returns the list of playlists.

    window.cordova.plugins.Music.getPlaylists(
        // success callback
        function (list) {
            console.log("playlists length" + list.length);
        },
        // error callback
        function (e) {
            console.log("Error getting message=" + e);
        }
    );


## window.cordova.plugins.Music.getSongsFromPlaylist

Returns the list of playlist.

    window.cordova.plugins.Music.getSongsFromPlaylist(
        //id of playlist
        playlistId,
        // success callback
        function (list) {
            console.log("songs length" + list.length);
        },
        // error callback
        function (e) {
            console.log("Error getting message=" + e);
        }
    );

## window.cordova.plugins.Music.playSong

Play song by songId and Call onComplete callback.

    window.cordova.plugins.Music.playSong(
        //id of song
        songId,
        // onComplete callback
        function (msg) {
            console.log("audio completed");
        },
        // error callback
        function (e) {
            console.log("Error getting message=" + e);
        }
    );

## window.cordova.plugins.Music.stopSong

Stop song.

    window.cordova.plugins.Music.stopSong(
        // success callback
        function (msg) {
            console.log("audio stopped");
        },
        // error callback
        function (e) {
            console.log("Error getting message=" + e);
        }
    );
