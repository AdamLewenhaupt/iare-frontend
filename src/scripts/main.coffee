loc = undefined

elbow = (d, i) -> 
	# "M#{d.source.x},#{d.source.y}H#{d.target.x}V#{d.target.y}"
	"M#{d.source.x},#{d.source.y}V#{(d.target.y + d.source.y) / 2}H#{d.target.x}V#{d.target.y}"

$ ->

	url = window.parent.location.href
	parts = url.split '/' 
	loc = parts[parts.length-1]
	
	if loc == "d3testing.html"

		margin = {
			top: 80,
			right: 120,
			bottom: 20,
			left: 400
		}

		width = 960 - margin.left - margin.right
		height = 500 - margin.top - margin.bottom

		i = 0

		tree = d3.layout.tree()
			.size([height, width])
			.nodeSize([300])


		svg = d3.select("body").append "svg"
			.attr "width", width + margin.left + margin.right
			.attr "height", height + margin.top + margin.bottom
				.append 'g'
			.attr 'transform', "translate(#{margin.left}, #{margin.top})"

		d3.json "tree.json", (err, json) -> 

			update = (source) ->
				  # Compute the new tree layout.
				  nodes = tree.nodes(json).reverse()
				  links = tree.links(nodes)
				  # Normalize for fixed-depth.
				  nodes.forEach (d) ->
				    d.y = d.depth * 100
				    return
				  # Declare the nodes…
				  node = svg.selectAll('g.node').data(nodes, (d) ->
				    d.id or (d.id = ++i)
				  )
				  # Enter the nodes.
				  nodeEnter = node.enter().append('g').attr('class', 'node').attr('transform', (d) ->
				    'translate(' + d.x + ',' + d.y + ')'
				  )
				  nodeEnter.append('circle').attr('r', 30).style 'fill', '#fff'
				  nodeEnter.append('text').attr('y', (d) ->
				    if d.children or d._children then 0 else 0
				  ).attr('dx', '40px').attr('text-anchor', 'left').text((d) ->
				    d.name
				  ).style 'fill-opacity', 1
				  # Declare the links…
				  link = svg.selectAll('path.link').data(links, (d) ->
				    d.target.id
				  )
				  # Enter the links.
				  link.enter().insert('path', 'g').attr('class', 'link').attr 'd', elbow 
				  return
				
			update json