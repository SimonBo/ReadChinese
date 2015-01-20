ready = ->
  word_pronunciation = $('.checked_word_pronunciation')
  if word_pronunciation.length > 0
    for chunk in word_pronunciation
      pinyin = PinyinConverter.convert(chunk.innerText)
      $("##{chunk.id}").text(pinyin)

$(document).ready(ready)
$(document).on('page:load', ready)