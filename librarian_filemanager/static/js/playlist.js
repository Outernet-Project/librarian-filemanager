// Generated by CoffeeScript 1.10.0
(function(window, $) {
  'use strict';
  var prepareAudio;
  prepareAudio = function() {
    var audio;
    audio = $('#audio-control-audio');
    if (audio.length) {
      audio.mediaelementplayer();
    }
  };
  $(prepareAudio);
  window.onTabChange(prepareAudio);
})(this, this.jQuery);
