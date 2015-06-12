var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var Music = function () {
};
var currentCallback=null;


/**
 * getPlayLists
 *
 * @param {Function} successCallback
 * @param {Function} errorCallback
 * @return {Array} An object of key/value pairs of all Playlists.
 */
Music.getPlaylists = function (success, fail) {
    exec(success, fail, 'Music', 'getPlaylists', []);
};

/**
 * getSongsFromPlaylist
 *
 * @param {Function} successCallback
 * @param {Function} errorCallback
 * @return {Array} An object of key/value pairs of all Songs from Playlists.
 */
Music.getSongsFromPlaylist = function (id, success, fail) {
    exec(success, fail, 'Music', 'getSongsFromPlaylist', [id]);
};

/**
 * getSongs
 *
 * @param {Function} successCallback
 * @param {Function} errorCallback
 * @return {Array} An object of key/value pairs of all Songs.
 */
Music.getSongs = function (success, fail) {
    exec(success, fail, 'Music', 'getSongs', []);
};

/**
 * playSong
 *
 * @param {int} id
 * @param {Function} successCallback
 * @param {Function} errorCallback
 */
Music.playSong = function (id, success, fail) {
    currentCallback=success;
    exec(null, fail, 'Music', 'playSong', [id]);
};
Music.stopSong = function (success, fail) {
    exec(success, fail, 'Music', 'stopSong', []);
};

Music.onMessageFromNative = function (msg) {
    if (msg) {
        currentCallback && currentCallback(msg)
    }
}
if (cordova.platformId === 'android' || cordova.platformId === 'amazon-fireos' || cordova.platformId === 'windowsphone') {

    var channel = require('cordova/channel');

    channel.createSticky('onMusicPluginReady');
    channel.waitForInitialization('onMusicPluginReady');

    channel.onCordovaReady.subscribe(function() {
        exec(Music.onMessageFromNative, undefined, 'Music', 'messageChannel', []);
        channel.initializationComplete('onMusicPluginReady');
    });
}

module.exports = Music;