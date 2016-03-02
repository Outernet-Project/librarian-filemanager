<%def name="audio_control(url)">
    <div id="audio-control-wrapper" class="audio-control-wrapper">
        <audio id="audio-control-audio" controls="controls">
        <source src="${url}" />
        <object type="application/x-shockwave-flash" data="${assets.url}vendor/mediaelement/flashmediaelement.swf">
            <param name="movie" value="${assets.url}vendor/mediaelement/flashmediaelement.swf" />
            <param name="flashvars" value="controls=true&file=${url}" />
        </object>
        </audio>
    </div>
</%def>

<div class='playlist-container' id="playlist-container">
    % if not facets or not facets.has_type('audio'):
    <span class="note">${_('No music files to be played.')}</span>
    % else:
    <%
      albumart_path = th.join(facets['audio']['path'], facets['audio']['cover'] or '')
      albumart_url = h.quoted_url('files:direct', path=albumart_path)
      entries = facets['audio']['playlist']
      if selected:
          try:
              selected_entry = filter(lambda e: e['file'] == selected, entries)[0]
          except IndexError:
              selected_entry = entries[0]
      else:
          selected_entry = entries[0]
      audio_url = h.quoted_url('files:direct', path=selected_entry['file_path'])
    %>
    <div class="playlist-controls" id="playlist-controls">
        <div class="playlist-controls-albumart" id="playlist-controls-albumart">
            <img src="${assets.url}img/albumart-placeholder.png"/>
        </div>
        ${audio_control(audio_url)}
        <!--
        <div class="playlist-controls-progressbar" id="playlist-controls-progressbar"></div>
        <div class="playlist-controls-navigation" id="playlist-controls-navigation">
        <div class="playlist-controls-navigation-previous" id="playlist-controls-navigation-previous"></div>
        <div class="playlist-controls-navigation-pause" id="playlist-controls-navigation-pause"></div>
        <div class="playlist-controls-navigation-stop" id="playlist-controls-navigation-stop"></div>
        <div class="playlist-controls-navigation-next" id="playlist-controls-navigation-next"></div>
        -->
    </div>
    <div class="playlist-list-container" id="playlist-list-container">
        <h2 style="border-bottom: none;">${_('Playlist')}</h2>
        <ul class="playlist-list" id="playlist-list" role="grid">
        % for entry in facets['audio']['playlist']:
            <%
            file = entry['file']
            current = entry == selected_entry
            file_path = entry['file_path']
            url = h.quoted_url('files:path', view=view, path=path, selected=file)
            direct_url = h.quoted_url('files:direct', path=file_path)
            title = entry['title']
            artist = entry['artist']
            duration = entry['duration']
            %>
            <li
                class="playlist-list-item ${'playlist-list-item-current' if current else ''}"
                role="row"
                aria-selected="false"
                data-title="${title | h}"
                data-artist="${artist | h}"
                data-duration="${duration}"
                data-url="${url}"
                data-direct-url="${direct_url}">
                <a class="playlist-list-item-link" href="${url}">${title | h} - ${artist | h}</a>
          </li>
        % endfor
        </ul>
    </div>
    % endif
</div>
