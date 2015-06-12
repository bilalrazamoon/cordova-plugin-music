angular.module('starter', ['ionic', 'starter.controllers', 'starter.services'])

    .run(function ($ionicPlatform) {
        $ionicPlatform.ready(function () {
            // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
            // for form inputs)
            if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
                cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
            }
            if (window.StatusBar) {
                // org.apache.cordova.statusbar required
                StatusBar.styleLightContent();
            }
        });
    })

    .config(function ($stateProvider, $urlRouterProvider) {
        $stateProvider

            .state('tab', {
                url: "/tab",
                abstract: true,
                templateUrl: "templates/tabs.html"
            })

            .state('tab.playlists', {
                url: '/playlists',
                views: {
                    'tab-playlists': {
                        templateUrl: 'templates/tab-playlists.html',
                        controller: 'playlistsCtrl'
                    }
                }
            })
            .state('tab.playlists-detail', {
                url: '/playlists/:id',
                views: {
                    'tab-playlists': {
                        templateUrl: 'templates/tab-songs.html',
                        controller: 'playlistsDetailCtrl'
                    }
                }
            })

            .state('tab.songs', {
                url: '/songs',
                views: {
                    'tab-songs': {
                        templateUrl: 'templates/tab-songs.html',
                        controller: 'songsCtrl'
                    }
                }
            });
        $urlRouterProvider.otherwise('/tab/playlists');

    });
