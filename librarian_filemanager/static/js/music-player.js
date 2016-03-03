// Generated by CoffeeScript 1.10.0
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

(function(window, $, templates) {
  'use strict';
  var MusicPlayer, prepareAudio;
  MusicPlayer = (function() {
    function MusicPlayer(container1) {
      var options;
      this.container = container1;
      this.onReady = bind(this.onReady, this);
      options = {
        itemSelector: '#playlist-list .playlist-list-item',
        currentItemSelector: 'playlist-list-item-current',
        ready: (function(_this) {
          return function() {
            _this.onReady();
          };
        })(this),
        setCurrent: (function(_this) {
          return function(item) {
            _this.onSetCurrent(item);
          };
        })(this)
      };
      this.playlist = new Playlist(this.container, options);
      return;
    }

    MusicPlayer.prototype.onReady = function() {
      this.controls = this.container.find('#audio-controls-audio').first();
      this.controls.mediaelementplayer({
        features: ['prevtrack', 'playpause', 'nexttrack', 'progress', 'duration', 'volume'],
        success: (function(_this) {
          return function(mediaElement) {
            _this.player = mediaElement;
          };
        })(this),
        error: (function(_this) {
          return function() {
            return _this.controls.prepend(templates.audioLoadFailure);
          };
        })(this)
      });
    };

    MusicPlayer.prototype.onSetCurrent = function(item) {
      this.updatePlayer(item);
      window.changeLocation(item.data('url'));
    };

    MusicPlayer.prototype.updatePlayer = function(item) {
      var audio_url, wasPlaying;
      audio_url = item.data('direct-url');
      wasPlaying = !this.player.paused;
      if (wasPlaying) {
        this.player.pause();
      }
      this.player.setSrc(audio_url);
      if (wasPlaying) {
        this.player.play();
      }
    };

    return MusicPlayer;

  })();
  prepareAudio = function() {
    var container, player;
    container = $('#playlist-container');
    if (container.length) {
      player = new MusicPlayer(container);
    }
  };
  $(prepareAudio);
  window.onTabChange(prepareAudio);
})(this, this.jQuery, this.templates);
