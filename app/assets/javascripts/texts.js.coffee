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
          word_simple_char = data[0].simplified_char
          ContentProcessor.higlight_word(target_word, word_simple_char)
        else
          render_not_found()
      complete: () ->
        ContentProcessor.reposition_text_entry()
        

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

ContentProcessor=
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

  reposition_text_entry: ->
    current_dictionary_height = $("#dict").css('height')
    $("#text-part").css('margin-top', current_dictionary_height)

  adjust_dict_width: ->
    text_part_width = $("#text-part").css('width')
    $("#dict").css("width", text_part_width)

  higlight_word: (word_id, chars)->
    ContentProcessor.dehighlight_all_words()

    word = $(".character[data-index=#{word_id}]")
    target_character = word.text()
    target_char_index_in_word = chars.indexOf(target_character)
    

    index_to_highlight = [(word_id-target_char_index_in_word)...(word_id-target_char_index_in_word+chars.length)]
    for index in index_to_highlight
      char = $(".character[data-index=#{index}]")
      char.addClass('highlight')

  dehighlight_all_words: ->
    word = $(".highlight")
    word.removeClass('highlight')


ready = ->
  character = $(".character")
  text_title_character = $(".text-title-character")
  dictionary = $("#dict")
  text_part = $("#text-part")
  text = $('#text')
  original_font_size = text.css('font-size')
  ContentProcessor.adjust_dict_width()
  ContentProcessor.reposition_text_entry()

  $( window ).resize ->
    ContentProcessor.adjust_dict_width()
    ContentProcessor.reposition_text_entry()

  $("#font-inc").on 'click', (e) ->
    e.preventDefault
    ContentProcessor.enlarge_font(text)

  $("#font-dec").on 'click', (e) ->
    e.preventDefault
    ContentProcessor.decrease_font(text)

  $("#font-reset").on 'click', (e) ->
    e.preventDefault
    ContentProcessor.reset_font(original_font_size, text)

  character.on 'click', (e) ->
    target_word = $(this).data('index')
    target_text = $('#text').data('id')
    
    DictionaryChecker.request(target_word, target_text)

  text_title_character.on 'click', (e) ->
    target_word = $(this).data('title-index')
    target_text = $('#text').data('id')
    DictionaryChecker.request(target_word, target_text)
    
$(document).ready(ready)
$(document).on('page:load', ready)