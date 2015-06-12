angular.module('starter.controllers', [])

    .controller('playlistsCtrl', function ($scope, Music) {
        $scope.playlists = [];
        Music.getPlaylists().then(function (data) {
            $scope.playlists = data;
            $scope.$$phase || $scope.$digest();
        })
    })

    .controller('playlistsDetailCtrl', function ($scope, Music, $stateParams) {
        var id = $stateParams.id;
        $scope.songs = [];
        Music.getSongsFromPlaylist(id).then(function (data) {
            $scope.songs = data;
            $scope.$$phase || $scope.$digest();
        })
        $scope.play= function (s) {
            if(s.playing){
                Music.stopSong().then(function(msg){
                    s.playing=false;
                    $scope.$$phase || $scope.$digest();
                    alert(msg);
                }).catch(function(msg){
                    alert(msg);
                })
            return
            }
            $scope.songs.forEach(function (obj) {
                obj.playing = false;
            });
            s.playing=true;
            Music.playSong(s.id).then(function(msg){
                s.playing=false;
                $scope.$$phase || $scope.$digest();
                alert(msg);
            }).catch(function(){
            })
        }
    })

    .controller('songsCtrl', function ($scope, Music) {
        $scope.songs = [];
        Music.getSongs().then(function (data) {
            $scope.songs = data;
            $scope.$$phase || $scope.$digest();
        });
        $scope.play= function (s) {
            if(s.playing){
                Music.stopSong().then(function(msg){
                    s.playing=false;
                    $scope.$$phase || $scope.$digest();
                    alert(msg);
                }).catch(function(msg){
                    alert(msg);
                })
            return
            }
            $scope.songs.forEach(function (obj) {
                obj.playing = false;
            });
            s.playing=true;
            Music.playSong(s.id).then(function(msg){
                s.playing=false;
                $scope.$$phase || $scope.$digest();
                alert(msg);
            }).catch(function(){
            })
        }
    })
;
