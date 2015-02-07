TestRenderer =
  render_multiple_choice_test: () ->
    TestRenderer.change_switcher_text()
    # hide answer input
    $('.type-answer').slideToggle()
    # display 4 answer options
    # check if answer correct
    # switch multiple choice btn to type answer
    # TestRenderer.change_switcher_text()

  change_switcher_text: ->
    switch_button = $("#switch-to-multiple-choice")
    if switch_button.text() == "Multiple choice"
      switch_button.text('Type answer')
    else
      switch_button.text('Multiple choice')


ready = ->
  multiple_choice_switch_btn = $("#switch-to-multiple-choice")
  multiple_choice_switch_btn.on 'click', (e) ->
    TestRenderer.render_multiple_choice_test()

$(document).ready(ready)
$(document).on('page:load', ready)