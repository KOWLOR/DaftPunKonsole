# letter to keycode mappings, in keyboard-like layout
keyboard_qwerty = [
  [ ["q", 81], ["w", 87], ["e", 69], ["r", 82], ["t", 84], ["y", 89], ["u", 85], ["i", 73], ["o", 79], ["p", 80] ],
  [ ["a", 65], ["s", 83], ["d", 68], ["f", 70], ["g", 71], ["h", 72], ["j", 74], ["k", 75], ["l", 76], [";", 186] ],
  [ ["z", 90], ["x", 88], ["c", 67], ["v", 86], ["b", 66], ["n", 78], ["m", 77], [",", 188] ],
  [ ["", 32] ]
]

keyboard_qwertz = [
  [ ["q", 81], ["w", 87], ["e", 69], ["r", 82], ["t", 84], ["z", 90], ["u", 85], ["i", 73], ["o", 79], ["p", 80] ],
  [ ["a", 65], ["s", 83], ["d", 68], ["f", 70], ["g", 71], ["h", 72], ["j", 74], ["k", 75], ["l", 76], ["ö", 192] ],
  [ ["y", 89], ["x", 88], ["c", 67], ["v", 86], ["b", 66], ["n", 78], ["m", 77], [",", 188] ],
  [ ["", 32] ]
]

keyboard_azerty = [
  [ ["a", 65], ["z", 90], ["e", 69], ["r", 82], ["t", 84], ["y", 89], ["u", 85], ["i", 73], ["o", 79], ["p", 80] ],
  [ ["q", 81], ["s", 83], ["d", 68], ["f", 70], ["g", 71], ["h", 72], ["j", 74], ["k", 75], ["l", 76], ["m", 77] ],
  [ ["w", 87], ["x", 88], ["c", 67], ["v", 86], ["b", 66], ["n", 78], [",", 188], [";", 186] ],
  [ ["", 32] ]
]

# sounds are always on the same row and key index
sound_index = [
  [0, 0, 'WorkIt'],   [0, 1, 'MakeIt'], [0, 2, 'DoIt'],   [0, 3, 'MakesUs'],
  [0, 6, 'MoreThan'], [0, 7, 'Hour'],   [0, 8, 'Our'],    [0, 9, 'Never'],
  [1, 0, 'Harder'],   [1, 1, 'Better'], [1, 2, 'Faster'], [1, 3, 'Stronger'],
  [1, 6, 'Ever'],     [1, 7, 'After'],  [1, 8, 'WorkIs'], [1, 9, 'Over']
]

sound_keys = {}

initJson = (keyboard) ->
  _.each(keyboard, (row, index_row) ->
    _.each(row, ([key_char, key_code], index_key) ->
      row_selected =  $(".r:nth-child(#{index_row+1})")
      span_selected =  $(row_selected).find("span")[index_key]
      $(span_selected).text(key_char)
      $(span_selected).parent('*[data-code]').attr('data-code', key_code)
    )
  )
  _.each(sound_index, ([row, key, sound]) ->
    key_code = keyboard[row][key][1]
    sound_keys[key_code] = sound
  )

getKeyCode = (event) ->
  code = event.keyCode or event.which
  # firefox returns code 0 for ö
  code = 192 if code == 0 and e.key == 'ö'
  return code

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
    initJson(keyboard_azerty)
    $('.k').addClass 'azerty'
    $(this).closest('.modal').remove()

  $('.js-qwerty').on 'click', (e) ->
    e.preventDefault()
    initJson(keyboard_qwerty)
    $('.k').addClass 'qwerty'
    $(this).closest('.modal').remove()

  $('.js-qwertz').on 'click', (e) ->
    e.preventDefault()
    initJson(keyboard_qwertz)
    $('.k').addClass 'qwertz'
    $(this).closest('.modal').remove()

  $(document).keydown (e) ->
    e.preventDefault()
    code = e.keyCode or e.which
    # my firefox (linux) returns code 0 for oe
    if code == 0 and e.key == 'ö'
      code = 192
    key = $('[data-code=' + code + ']')

    if key.data('level')
      curClass = key.data('level')
      key.addClass('is-active')
      key.closest('.level').find('.is-active').not(key).removeClass('is-active')
      $('body').removeClass().addClass(curClass)

    else
      key.addClass('is-active')
      $('#js-lyrics').html('<span class="animated"/>').find('span').addClass('fadeOutUp').html(key.data('lyric'))

    switch $('.level').find('i.is-active').data('level')
      when 'Normal'
        level_num = 1
      when 'High'
        level_num = 2
      when 'Low'
        level_num = 3

    sound_name = sound_keys[code]
    if sound_name
      ion.sound.play sound_name + level_num


  $(document).keyup (e) ->
    e.preventDefault()
    code = e.keyCode or e.which
    # my firefox (linux) returns code 0 for oe
    if code == 0 and e.key == 'ö'
      code = 192
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
