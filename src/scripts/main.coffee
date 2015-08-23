
elbow = (d, i) ->
    if d.target.children == undefined
        "M#{d.source.x},#{d.source.y}V#{d.target.y - 40}H#{d.target.x}V#{d.target.y}"

    else
        "M#{d.source.x},#{d.source.y}V#{(d.target.y + d.source.y) / 2}H#{d.target.x}V#{d.target.y}"


$ ->

    url = window.parent.location.href
    parts = url.split '/'
    loc = parts[parts.length-1]
    
    if loc == "d3testing.html"

        margin = {
            top: 40,
            right: 120,
            bottom: 20,
            left: 600
        }

        width = 960 - margin.left - margin.right
        height = 500 - margin.top - margin.bottom

        i = 0

        tree = d3.layout.tree()
            .size([height, width])
            .nodeSize([60])


        svg = d3.select("#tree")
                .append 'g'
            .attr 'transform', "translate(#{margin.left}, #{margin.top})"

        d3.json "tree.json", (err, json) ->

            update = (source) ->
                # Compute the new tree layout.
                nodes = tree.nodes(json).reverse()
                links = tree.links(nodes)
                # Normalize for fixed-depth.

                j = 0
                currentDepth = 0
                nodes.forEach (d) ->
                    if currentDepth < d.depth
                        j = 0

                    currentDepth = d.depth
                    j++
                    y = d.depth * 100
                    if d.children == undefined

                        if d.parent.children.length < 6
                            d.x = d.parent.x + 60
                            y = y - 50 + j * 80
                        else
                            d.x = d.parent.x + Math.pow(-1, j) * 160
                            y = y - 50 + (j / 2) * 80

                    d.y = y
                    
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
