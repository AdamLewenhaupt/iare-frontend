    paper = Snap "##{name}-icon"
    Snap.load "/imgs/#{name}-icon.svg", (f) ->
        icon = f.select '#icon'

        paper.append icon

        $("##{name}-icon")
            .hover lightFactory(icon)
            .mouseleave dimFactory(icon)
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
