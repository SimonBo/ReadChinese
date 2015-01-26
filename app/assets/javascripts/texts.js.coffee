DictionaryChecker = 
  request: (target_word, target_text) ->
    $.ajax
      type: 'GET'
      url: "/words/find/#{target_word}/#{target_text}"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        $('#notice').text("AJAX Error: #{textStatus}") 
      success: (data, textStatus, jqXHR) ->
        $('#notice').text()
        if data.length >0
          if $('#user_signed_in').length > 0
            checked_word = data[0].id
            DictionaryChecker.increment_checked_words(checked_word)
          DictionaryChecker.reset_info_fields()
          DictionaryChecker.render_dictionary_entry(data)
        else
          render_not_found()
      complete: () ->
        DivResizer.reposition_text_entry()

  increment_checked_words: (checked_word) ->
    $.ajax
      type: 'GET'
      url: "/checked_words/mark_as_checked/#{checked_word}"
      dataType: "json"

  reset_info_fields: (data) ->
    $('#character').html("<strong>Character: </strong>")
    $('#pronunciation').html("<strong>Pinyin: </strong>")
    $('#meaning').html("<strong>Meaning: </strong>")

  render_dictionary_entry: (data) ->
    DictionaryChecker.show_found_word(data)
    DictionaryChecker.show_pinyin(data)
    DictionaryChecker.show_meanings(data)

  show_found_word: (data) ->
    word = data[0].simplified_char
    $('#character').append(word)

  show_pinyin: (data) ->
    pinyin = PinyinConverter.convert(data[0].pronunciation).toString().replace(/[\][]/g, '')
    $('#pronunciation').append(pinyin)

  show_meanings: (data) ->
    meanings = (word.meaning for word in data)
    for chunk in meanings
      if /\w\d/i.test(chunk.toString())
        chunk = PinyinConverter.convert(chunk)
      $('#meaning').append chunk
      $('#meaning').append '<br>'

  render_not_found: ->
    $('#character').text('Not found')
    $('#pronunciation').text('')
    $('#meaning').text('')

FontResizer =
  enlarge_font: (text) ->
    font_size = text.css('font-size').replace('px', '')
    inc_font_size = parseInt(font_size) + 1 + 'px'
    text.css('font-size', inc_font_size )

  decrease_font: (text) ->
    font_size = text.css('font-size').replace('px', '')
    dec_font_size = parseInt(font_size) - 1 + 'px'
    text.css('font-size', dec_font_size )

  reset_font: (original_font_size, text) ->
    text.css('font-size', original_font_size )

DivResizer=
  reposition_text_entry: ->
    current_dictionary_height = $("#dict").css('height')
    $("#text-part").css('margin-top', current_dictionary_height)

  adjust_dict_width: ->
    text_part_width = $("#text-part").css('width')
    $("#dict").css("width", text_part_width)

ready = ->
  character = $(".character")
  text_title_character = $(".text-title-character")
  dictionary = $("#dict")
  text_part = $("#text-part")
  text = $('#text')
  original_font_size = text.css('font-size')

  $( window ).resize ->
    DivResizer.adjust_dict_width()
    DivResizer.reposition_text_entry()

  $("#font-inc").on 'click', (e) ->
    e.preventDefault
    FontResizer.enlarge_font(text)

  $("#font-dec").on 'click', (e) ->
    e.preventDefault
    FontResizer.decrease_font(text)

  $("#font-reset").on 'click', (e) ->
    e.preventDefault
    FontResizer.reset_font(original_font_size, text)

  character.on 'click', (e) ->
    target_word = text_title_character.length + $(this).data('index')
    target_text = $('#text').data('id')
    DictionaryChecker.request(target_word, target_text)

  text_title_character.on 'click', (e) ->
    target_word = $(this).data('title-index')
    target_text = $('#text').data('id')
    DictionaryChecker.request(target_word, target_text)
    
$(document).ready(ready)
$(document).on('page:load', ready)