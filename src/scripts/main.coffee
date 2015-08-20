loc = undefined

elbow = (d, i) -> 
	"M" + d.source.y + "," + d.source.x 
	+ "H" + d.target.y + "V" + d.target.x

$ ->

	url = window.parent.location.href
	parts = url.split '/' 
	loc = parts[parts.length-1]
	
	if loc == "d3testing.html"

		tree = d3.layout.tree()
			.separation (a,b) -> 1
			.children (d) -> d.children
			.size 960, 500

		svg = d3.select("#paper")
			.attr("width", 960)
			.attr("height", 500)
			.append "g"

		d3.json "tree.json", (err, json) ->
			if err
		 		throw err

			nodes = tree.nodes json
			link = svg.selectAll '.link'
			 	.data tree.links nodes
			 	.enter()
			 	.append "path"
			 	.attr 'class', 'link'
			 	.attr 'd', elbow

			node = svg.selectAll '.node'
				.data nodes
			 	.enter().append('g')
			 	.attr 'class', 'node'
			 	.attr("transform", (d) -> "translate(" + d.y + "," + d.x + ")")