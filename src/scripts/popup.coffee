open = (wrapper) ->
    $(".popup.popup-wrapper").addClass 'active'
    $(".popup.popup-overlay").addClass 'active'

close = ->
    $(".popup.popup-wrapper").removeClass 'active'
        .html("")
    $(".popup.popup-overlay").removeClass 'active'

choose = (type) ->

    switch type
        when "exit"
            close
        when "intern"
            -> 
                close()
                internPopup()
        else
            close

internPopup = ->

    open()

    text = $(".popup.popup-intern").attr('data-intern')
    if text
        options = $.parseJSON text
    else
        options = {}

    $.ajax
        cache: false
        url: "/editor-intern.html"
        success: (content) ->
            $(content).appendTo $(".popup.popup-wrapper")

            if options.board != undefined
                $(".popup.popup-wrapper select[name=board]").parent().remove()
                $("<input name='board' type='hidden' value='#{options.board}' />").appendTo $(".popup.popup-wrapper form")

            $(".popup.popup-finish").click ->
                console.log $(".popup.editor > form").serialize()
                close()

            $(".popup.popup-abort").click ->
                console.log "abort"
                close()

selectPopup = ->
    text = $(".popup.popup-select").attr("data-options")
    options = $.parseJSON(text)
    options.push { text: "Avbryt", type: "exit" }
    open(false)

    $wrapper = $("<div>").addClass "popup popup-select"
    for opt in options
        $("<div>").addClass "popup popup-select-option"
            .html opt.text
            .click choose(opt.type)
            .appendTo $wrapper

    $wrapper.appendTo $(".popup.popup-wrapper")


$ ->
    $("<div>").addClass("popup popup-overlay").appendTo $('body')
    $("<div>").addClass("popup popup-wrapper").appendTo $('body')

    $(".popup.popup-select").click selectPopup
    $(".popup.popup-intern").click internPopup
