createIcon = (name, href) ->
    paper = Snap "##{name}-icon"
    Snap.load "/imgs/icons/#{name}-icon.svg", (f) ->
        icon = f.select '#icon'

        paper.append icon

        $("##{name}-icon")
            .click ->
                window.location.href = href


createIcons = (list) ->
    for icon in list
        createIcon icon.name, icon.href

$ ->
    url = window.parent.location.href
    parts = url.split '/'
    loc = parts[parts.length-1]



    createIcons [
            {name: "iare", href: "/" },
            {name: "cluster", href: "/cluster.html"},
            {name: "cal", href: "/cal.html" }
        ]
