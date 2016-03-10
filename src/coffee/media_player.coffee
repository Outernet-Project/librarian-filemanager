((window, $, templates) ->
  'use strict'

  currentItemClass = 'playlist-list-item-current'
  selectors = {
    itemSelector: '#playlist-list .playlist-list-item',
    currentItemClass: currentItemClass,
    currentItemSelector: '.' + currentItemClass,
  }

  detailUnits = {
    'title': '.playlist-item-title',
    'artist': '.playlist-item-artist',
    'author': '.playlist-item-author',
    'description': '.playlist-item-description',
  }

  mediaPlayer =
    initialize: (container, features, callbacks) ->
      @container = container
      defaultCallbacks = {
        setCurrent: (current, previous) =>
          @onSetCurrent(current, previous)
          return
      }
      @options = $.extend {}, selectors, features, defaultCallbacks, callbacks
      @details = (container.find '#playlist-metadata').first()
      @readyPlayer()
      return

    onPlayerReady: (mediaElement) ->
      @player = mediaElement
      ($ window).on 'views-sidebar-toggled', () =>
        @sidebarToggled()
        return
      @playlist = new Playlist @container, @options
      return

    onSetCurrent: (current, previous) ->
      previousUrl = previous.data('url')
      nextUrl = current.data('url')
      autoPlay = previousUrl != nextUrl
      @updatePlayer(current, autoPlay)
      @updateDetails(current)
      previousUrl = previous.data('url')
      nextUrl = current.data('url')
      if previousUrl != nextUrl
        window.changeLocation nextUrl
      return

    updatePlayer: (item, autoPlay) ->
      mediaUrl = item.data('direct-url')
      wasPlaying = not @player.paused
      if wasPlaying
        @player.pause()
      @player.setSrc(mediaUrl)
      if wasPlaying || autoPlay
        @player.play()
      return

    updateDetails: (item) ->
      for unit, selector of detailUnits
        value = item.data unit
        if value
          @details.find(selector).html(value)
      return

    next: () ->
      @playlist.next()
      return

    previous: () ->
      @playlist.previous()
      return

    sidebarToggled: () ->
      # Hack to get mediaelementjs to resize its controls
      @triggerResizeEvents 100, 1000
      return

    triggerResizeEvents: (interval, duration) ->
      ###
      Trigger window resize event every `interval` milliseconds for
      `duration` milliseconds
      ###
      if @resizeTimerId
        window.clearInterval(@resizeTimerId)
      start = Date.now()
      end = start + duration
      resizeFunc = () ->
        $(window).trigger 'resize'
        if Date.now() >= end
          window.clearInterval(@resizeTimerId)
        return
      resizeFunc = resizeFunc.bind(@)
      @resizeTimerId = window.setInterval resizeFunc, 100
      return

  window.mediaPlayer = mediaPlayer
) this, this.jQuery, this.templates
