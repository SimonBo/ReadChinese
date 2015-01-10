DictionaryFormatter =
  format_pronunciation: (data) ->
    p_id = data[0].id
    text_to_replace = data.text()
    pinyin = PinyinConverter.convert(text_to_replace).replace(/[\][]/g, '')
    target_element = $("#" + "#{p_id}")
    target_element.text(pinyin)


  format_meaning: (data) ->
    text_to_replace = data.text()
    corrected_text = text_to_replace.replace(/[\/]/g, ', ')
    p_id = data[0].id
    $("#" + "#{p_id}").text(corrected_text[1..-3])

ready = ->
  pronunciation = $('.pronunciation')
  meaning = $('.meaning')

  if pronunciation.length > 0
    pronunciation.each () ->
      DictionaryFormatter.format_pronunciation($(this))

  if meaning.length > 0
    meaning.each ->
      DictionaryFormatter.format_meaning($(this))

$(document).ready(ready)
$(document).on('page:load', ready)