// Generated by CoffeeScript 1.10.0
(function(window, $) {
  var genericOpener, openers;
  openers = $('.opener');
  genericOpener = $('.opener-generic');
  genericOpener.on('click', function() {
    var elem;
    elem = $(this);
    return elem.parents('.o-modal-overlay').remove();
  });
  if (openers.length === 1) {
    return genericOpener[0].click();
  }
})(this, this.jQuery);
