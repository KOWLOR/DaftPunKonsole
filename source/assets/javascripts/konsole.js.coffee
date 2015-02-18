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
  [0, 5, 'MoreThan'], [0, 6, 'Hour'],   [0, 7, 'Our'],    [0, 8, 'Never'],
  [1, 0, 'Harder'],   [1, 1, 'Better'], [1, 2, 'Faster'], [1, 3, 'Stronger'],
  [1, 5, 'Ever'],     [1, 6, 'After'],  [1, 7, 'WorkIs'], [1, 8, 'Over']
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

processKeyDown = (key, isMouse) ->
  if key.data('level')
    curClass = key.data('level')
    key.addClass('is-active')
    key.closest('.level').find('.is-active').not(key).removeClass('is-active')
    $('body').removeClass().addClass(curClass)
  else
    $('#js-lyrics').html('<span class="animated"/>').find('span').addClass('fadeOutUp').html(key.data('lyric'))
    if !isMouse
      key.addClass('is-active')

  switch $('.level').find('i.is-active').data('level')
    when 'Normal'
      level_num = 1
    when 'Pitch-1'
      level_num = 2
    when 'Low'
      level_num = 3
    when 'Pitch-2'
      level_num = 4
    when 'High'
      level_num = 5

  code = key.data('code')
  sound_name = sound_keys[code]
  if sound_name
    ion.sound.play sound_name + level_num


init = ->
  level = 'Normal'
  $('body').addClass 'Normal'
  $('.level').find('i[data-level=' + level + ']').addClass 'is-active'

ion.sound
  sounds: do ->
    sounds = []
    for i in [1..5]
      for s in sound_index
        sounds.push {name: (s[2] + i), preload: true}
    return sounds
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
    code = getKeyCode e
    key = $('[data-code=' + code + ']')
    if key.length
      e.preventDefault()
      processKeyDown key, false

  $(document).keyup (e) ->
    code = getKeyCode e
    key = $('[data-code=' + code + ']')
    if key.length
      e.preventDefault()
    if !key.data('level')
      key.removeClass('is-active')

  $('[data-code]').mousedown (e) ->
    e.preventDefault()
    processKeyDown $(this), true

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
      loop:
        key: 0
        fn: (f) ->
          f._loop !f.options.loop
