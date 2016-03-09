// Generated by CoffeeScript 1.10.0
(function(window, $, templates) {
  'use strict';
  var DOWN, UP, body, mainPanel, modalDialogTemplate, openerLinkSelector, searchInput, setPath, spinnerIcon;
  UP = 38;
  DOWN = 40;
  openerLinkSelector = '.opener-link';
  searchInput = $('#files-multisearch #p');
  body = $(document.body);
  mainPanel = $("#" + window.o.pageVars.mainPanelId);
  modalDialogTemplate = window.templates.modalDialogCancelOnly;
  spinnerIcon = window.templates.spinnerIcon;
  setPath = function(path) {
    if (path === '.') {
      searchInput.val('');
    } else {
      searchInput.val(path);
    }
  };
  mainPanel.on('keydown', '.file-list-link', function(e) {
    var elem, listItem;
    elem = $(this);
    listItem = elem.parents('.file-list-item');
    switch (e.which) {
      case UP:
        listItem.prev().find('a').focus();
        e.preventDefault();
        break;
      case DOWN:
        listItem.next().find('a').focus();
        e.preventDefault();
    }
  });
  mainPanel.on('click', '.file-list-link', function(e) {
    var elem, icon, isDir, openerListUrl, originalIcon, res, spinner, url;
    elem = $(this);
    openerListUrl = elem.data('opener');
    isDir = elem.data('type') === 'directory';
    if (!!openerListUrl) {
      e.preventDefault();
      e.stopPropagation();
      res = $.modalContent(openerListUrl, {
        successTemplate: modalDialogTemplate
      });
      res.done(function(data) {
        var links;
        links = $(openerLinkSelector);
        return links.click(function(e) {
          var linkEl, openerUrl;
          linkEl = $(this);
          openerUrl = linkEl.attr('href');
          $.modalContent(openerUrl, {
            fullScreen: true
          });
          e.preventDefault();
          return e.stopPropagation();
        });
      });
      return;
    }
    if (elem.data('type') === 'directory') {
      e.preventDefault();
      e.stopPropagation();
      icon = elem.find('.file-list-icon');
      url = elem.attr('href');
      originalIcon = icon.html();
      spinner = $(spinnerIcon);
      icon.after(spinner);
      icon.hide();
      res = loadContent(url);
      res.done(function() {
        window.history.pushState(null, null, url);
        return setPath(elem.data('relpath'));
      });
      res.always(function() {
        icon.show();
        return spinner.remove();
      });
    }
  });
})(this, this.jQuery, this.templates);