lightFactory = (icon) -> (-> icon.attr { fill: '#fff'})
dimFactory = (icon) -> (-> icon.attr { fill: '#000'})

createIcon = (name) ->

	paper = Snap "##{name}-icon"
	Snap.load "/imgs/#{name}-icon.svg", (f) ->
		icon = f.select '#icon'

		paper.append icon

		$("##{name}-icon")
			.hover lightFactory(icon)
			.mouseleave dimFactory(icon)


createIcons = (list) ->
	for name in list
		createIcon name

$ -> 
	createIcons ["iare", "cluster", "cal", "news"]