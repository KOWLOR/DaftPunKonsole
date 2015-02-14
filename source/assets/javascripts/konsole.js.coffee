initJson = (index_type) ->
  $.ajax(
    url: 'http://s.cdpn.io/190177/keyboard_.json'
    type: 'get'
    dataType: 'json')
  .done (data) ->
    _.each(data.keyboard.type[index_type].row, (row, index_row) ->
      _.each(row.key, (key, index_key) ->
        row_selected =  $(".r:nth-child(#{index_row+1})")
        span_selected =  $(row_selected).find("span")[index_key]
        $(span_selected).text(key.char)
        $(span_selected).parent('*[data-code]').attr('data-code', key.code)

      )
      )

init = ->
  level = 'Normal'
  $('body').addClass 'Normal'
  $('.level').find('i[data-level=' + level + ']').addClass 'is-active'

ion.sound
  sounds: [
    {name:'beat'}
    {name:'WorkIt1'}
    {name:'MakeIt1'}
    {name:'DoIt1'}
    {name:'MakesUs1'}
    {name:'Harder1'}
    {name:'Better1'}
    {name:'Faster1'}
    {name:'Stronger1'}
    {name:'MoreThan1'}
    {name:'Hour1'}
    {name:'Our1'}
    {name:'Never1'}
    {name:'Ever1'}
    {name:'After1'}
    {name:'WorkIs1'}
    {name:'Over1'}
    {name:'WorkIt2'}
    {name:'MakeIt2'}
    {name:'DoIt2'}
    {name:'MakesUs2'}
    {name:'Harder2'}
    {name:'Better2'}
    {name:'Faster2'}
    {name:'Stronger2'}
    {name:'MoreThan2'}
    {name:'Hour2'}
    {name:'Our2'}
    {name:'Never2'}
    {name:'Ever2'}
    {name:'After2'}
    {name:'WorkIs2'}
    {name:'Over2'}
    {name:'MoreThan3'}
    {name:'Hour3'}
    {name:'Our3'}
    {name:'Never3'}
    {name:'Ever3'}
    {name:'After3'}
    {name:'WorkIs3'}
    {name:'Over3'}

  ]
  path: 'http://s.cdpn.io/190177/'
  preload: true

$ ->
  init()
  k = $('.k')

  $('.js-azerty').on 'click', (e) ->
    e.preventDefault()
    initJson(0)
    $('.k').addClass 'azerty'
    $(this).closest('.modal').remove()

  $('.js-qwerty').on 'click', (e) ->
    e.preventDefault()
    initJson(1)
    $('.k').addClass 'qwerty'
    $(this).closest('.modal').remove()

  $(document).keydown (e) ->
    e.preventDefault()
    code = e.keyCode or e.which
    key = $('[data-code=' + code + ']')

    if key.data('level')
      curClass = key.data('level')
      key.addClass('is-active')
      key.closest('.level').find('.is-active').not(key).removeClass('is-active')
      $('body').removeClass().addClass(curClass)

    else
      key.addClass('is-active')
      $('#js-lyrics').html('<span class="animated"/>').find('span').addClass('fadeOutUp').html(key.data('lyric'))

    if $('.level').find('i.is-active').data('level') == 'Normal'
      if k.hasClass 'qwerty'
        switch code
          when 81
            ion.sound.play 'WorkIt1'
          when 87
            ion.sound.play 'MakeIt1'
          when 69
            ion.sound.play 'DoIt1'
          when 82
            ion.sound.play 'MakesUs1'

          when 65
            ion.sound.play 'Harder1'
          when 83
            ion.sound.play 'Better1'
          when 68
            ion.sound.play 'Faster1'
          when 70
            ion.sound.play 'Stronger1'

          when 85
            ion.sound.play 'MoreThan1'
          when 73
            ion.sound.play 'Hour1'
          when 79
            ion.sound.play 'Our1'
          when 80
            ion.sound.play 'Never1'

          when 74
            ion.sound.play 'Ever1'
          when 75
            ion.sound.play 'After1'
          when 76
            ion.sound.play 'WorkIs1'
          when 186, 59
            ion.sound.play 'Over1'
      else
        switch code
          when 65
            ion.sound.play 'WorkIt1'
          when 90
            ion.sound.play 'MakeIt1'
          when 69
            ion.sound.play 'DoIt1'
          when 82
            ion.sound.play 'MakesUs1'

          when 81
            ion.sound.play 'Harder1'
          when 83
            ion.sound.play 'Better1'
          when 68
            ion.sound.play 'Faster1'
          when 70
            ion.sound.play 'Stronger1'

          when 85
            ion.sound.play 'MoreThan1'
          when 73
            ion.sound.play 'Hour1'
          when 79
            ion.sound.play 'Our1'
          when 80
            ion.sound.play 'Never1'

          when 74
            ion.sound.play 'Ever1'
          when 75
            ion.sound.play 'After1'
          when 76
            ion.sound.play 'WorkIs1'
          when 77
            ion.sound.play 'Over1'

    else if $('.level').find('i.is-active').data('level') == 'High'
      if k.hasClass 'qwerty'
        switch code
          when 81
            ion.sound.play 'WorkIt2'
          when 87
            ion.sound.play 'MakeIt2'
          when 69
            ion.sound.play 'DoIt2'
          when 82
            ion.sound.play 'MakesUs2'

          when 65
            ion.sound.play 'Harder2'
          when 83
            ion.sound.play 'Better2'
          when 68
            ion.sound.play 'Faster2'
          when 70
            ion.sound.play 'Stronger2'

          when 85
            ion.sound.play 'MoreThan2'
          when 73
            ion.sound.play 'Hour2'
          when 79
            ion.sound.play 'Our2'
          when 80
            ion.sound.play 'Never2'

          when 74
            ion.sound.play 'Ever2'
          when 75
            ion.sound.play 'After2'
          when 76
            ion.sound.play 'WorkIs2'
          when 186, 59
            ion.sound.play 'Over2'
      else
        switch code
          when 65
            ion.sound.play 'WorkIt2'
          when 90
            ion.sound.play 'MakeIt2'
          when 69
            ion.sound.play 'DoIt2'
          when 82
            ion.sound.play 'MakesUs2'

          when 81
            ion.sound.play 'Harder2'
          when 83
            ion.sound.play 'Better2'
          when 68
            ion.sound.play 'Faster2'
          when 70
            ion.sound.play 'Stronger2'

          when 85
            ion.sound.play 'MoreThan2'
          when 73
            ion.sound.play 'Hour2'
          when 79
            ion.sound.play 'Our2'
          when 80
            ion.sound.play 'Never2'

          when 74
            ion.sound.play 'Ever2'
          when 75
            ion.sound.play 'After2'
          when 76
            ion.sound.play 'WorkIs2'
          when 77
            ion.sound.play 'Over2'

    else if $('.level').find('i.is-active').data('level') == 'Low'
      if k.hasClass 'qwerty'
        switch code
          when 85
            ion.sound.play 'MoreThan3'
          when 73
            ion.sound.play 'Hour3'
          when 79
            ion.sound.play 'Our3'
          when 80
            ion.sound.play 'Never3'

          when 74
            ion.sound.play 'Ever3'
          when 75
            ion.sound.play 'After3'
          when 76
            ion.sound.play 'WorkIs3'
          when 186, 59
            ion.sound.play 'Over3'
      else
        switch code
          when 85
            ion.sound.play 'MoreThan3'
          when 73
            ion.sound.play 'Hour3'
          when 79
            ion.sound.play 'Our3'
          when 80
            ion.sound.play 'Never3'

          when 74
            ion.sound.play 'Ever3'
          when 75
            ion.sound.play 'After3'
          when 76
            ion.sound.play 'WorkIs3'
          when 77
            ion.sound.play 'Over3'


  $(document).keyup (e) ->
    e.preventDefault()
    code = e.keyCode or e.which
    key = $('[data-code=' + code + ']')

    if !key.data('level')
      key.removeClass('is-active')

  $('#js-daft_1').jPlayer
    ready: (event) ->
      $(this).jPlayer 'setMedia',
        m4a: 'http://s.cdpn.io/190177/instru.mp3'
    supplied: 'm4a'
    wmode: 'window'
    autoBlur: false
    useStateClassSkin: true
    smoothPlayBar: true
    keyEnabled: true
    toggleDuration: true
    remainingDuration: true
    keyBindings:
      play:
        key: 32
        fn: (f) ->
          if f.status.paused
            f.play()
          else
            f.pause()
      muted:
        key: 0
        fn: (f) ->
          f._muted !f.options.muted
      volumeUp:
        key: 0
        fn: (f) ->
          f.volume f.options.volume + 0.1
      volumeDown:
        key: 0
        fn: (f) ->
          f.volume f.options.volume - 0.1
