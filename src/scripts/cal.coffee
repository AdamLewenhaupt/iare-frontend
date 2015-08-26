$ ->
    url = window.parent.location.href
    parts = url.split '/'
    loc = parts[parts.length-1]
    
    if loc == "cal.html"

        $cal = $("#cal").fullCalendar
           aspectRatio: 1 
