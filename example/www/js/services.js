angular.module('starter.services', [])
    .factory('Music', function ($q, $ionicPlatform) {
        return {
            getPlaylists: function () {
                var q = $q.defer();
                $ionicPlatform.ready(function () {
                    cordova.plugins.Music.getPlaylists(function (data) {
                        q.resolve(data);
                    }, function (err) {
                        q.reject(err);
                    });
                });
                return q.promise;
            },
            getSongs: function () {
                var q = $q.defer();
                $ionicPlatform.ready(function () {
                    cordova.plugins.Music.getSongs(function (data) {
                        q.resolve(data);
                    }, function (err) {
                        q.reject(err);
                    });
                });
                return q.promise;
            },
            getSongsFromPlaylist: function (id) {
                var q = $q.defer();
                $ionicPlatform.ready(function () {
                    cordova.plugins.Music.getSongsFromPlaylist(id, function (data) {
                        q.resolve(data);
                    }, function (err) {
                        q.reject(err);
                    });
                });
                return q.promise;
            },
             playSong: function (id) {
                 var q = $q.defer();
                 $ionicPlatform.ready(function () {
                     cordova.plugins.Music.playSong(id, function (data) {
                         q.resolve(data);
                     }, function (err) {
                         q.reject(err);
                     });
                 });
                 return q.promise;
             },
              stopSong: function () {
                  var q = $q.defer();
                  $ionicPlatform.ready(function () {
                      cordova.plugins.Music.stopSong(function (data) {
                          q.resolve(data);
                      }, function (err) {
                          q.reject(err);
                      });
                  });
                  return q.promise;
              }
        };
    });
