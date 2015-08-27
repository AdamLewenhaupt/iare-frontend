menuSetup  = (names) ->
    for name in names
        $(".menu-btn.#{name}").data("target", name).click ->
            $(".frame > div").addClass 'hidden'
            $("##{$(this).data("target")}").removeClass 'hidden'

$ ->

    $cal = $("#cal").fullCalendar
           aspectRatio: 1 


    menuSetup ["main", "osa", "booking"]
