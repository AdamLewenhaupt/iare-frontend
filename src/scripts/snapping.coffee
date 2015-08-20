lightFactory = (icon) -> (-> icon.attr { fill: '#fff'})
dimFactory = (icon) -> (-> icon.attr { fill: '#000'})

createIcon = (name, href) ->

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
	if loc != "d3testing.html"
		createIcons [
			{name: "iare", href: "/" }, 
			{name: "cluster", href: "/cluster.html"}, 
			{name: "cal", href: "/cal.html" },
			{name: "news", href: "/news.html" }]