
isCluster = (d) -> d.name == "CLUSTER"

elbow = (d, i) ->
    if isCluster d.target.parent
        "M#{d.source.x},#{d.source.y}V#{d.target.y}H#{d.target.x}V#{d.target.y}"
    else if d.target.parent.isSmall
        "M#{d.source.x},#{d.source.y}V#{d.target.y}H#{d.target.x}V#{d.target.y}"

    else if d.target.children == undefined
        "M#{d.source.x},#{d.source.y}V#{d.target.y - 40}H#{d.target.x}V#{d.target.y}"

    else
        "M#{d.source.x},#{d.source.y}V#{(d.target.y + d.source.y) / 2}H#{d.target.x}V#{d.target.y}"


$ ->

    screenWidth = $(window).width()
    screenHeight = $(window).height()

    margin = {
        top: 40,
        right:120,
        bottom: 20,
        left: screenWidth / 2
    }

    width = screenWidth / 5
    bubbleWidth = width / 5 

    i = 0

    tree = d3.layout.tree()


    svg = d3.select("#tree")
            .append 'g'
        .attr 'transform', "translate(#{margin.left}, #{margin.top})"

    svg.append("defs").append("pattern")
        .attr("id", "test")
        .attr("width", bubbleWidth)
        .attr("height", bubbleWidth)
        .append("image")
            .attr("xlink:href", "/imgs/test.jpg")
            .attr("width",  bubbleWidth)
            .attr("height", bubbleWidth)

    d3.json "tree.json", (err, json) ->

        update = (source) ->
            # Compute the new tree layout.
            nodes = tree.nodes(json)
            links = tree.links(nodes)
            # Normalize for fixed-depth.

            j = 0
            currentDepth = 0
            maxHeight = 0
            nodes.forEach (d) ->
                if currentDepth < d.depth
                    if d.parent == undefined or not d.parent.isSmall
                        j = 0
                    else
                        j--

                currentDepth = d.depth
                j++
                y = d.depth * 100
                if d.parent != undefined
                    d.x = d.parent.x - d.parent.children.length * width / 2  + (d.parent.children.indexOf(d)+  0.5 )* width
                    
                if d.parent != undefined and d.parent.name == "CLUSTER"
                    d.isSmall = true
                    d.x = d.parent.x + bubbleWidth 
                    y = y - 150 + (j - 1) * 120

                else if d.parent != undefined and d.parent.isSmall
                    d.x = d.parent.x + bubbleWidth
                    y = d.parent.y + 50

                else if d.children == undefined

                    if d.parent.children.length < 6
                        d.x = d.parent.x + bubbleWidth
                        y = y - 50 + j * 80
                    else
                        d.x = d.parent.x + (if j % 2 == 0 then -200 else bubbleWidth)
                        y = y - 50 + (j / 2) * 80

                maxHeight = if y > maxHeight then y else maxHeight
                d.y = y

            $("#tree").height(maxHeight + 80)
                
            # Declare the nodes…
            node = svg.selectAll('g.node').data(nodes, (d) ->
                d.id or (d.id = ++i)
            )
            # Enter the nodes.
            nodeEnter = node.enter().append('g').attr('class', 'node').attr('transform', (d) ->
                'translate(' + d.x + ',' + d.y + ')'
            )
            nodeEnter.append('circle').attr('r', bubbleWidth / 2).style 'fill', '#fff'
                .style "fill", (d) -> if isCluster d then "none" else "url(#test)"
                .style "stroke", (d) -> if isCluster d then "none"
                .on "click", (d) -> alert(d.name)

            nodeEnter.append('text').attr('y', (d) ->
                if d.children or d._children then 0 else 0
            ).attr('dx', "#{bubbleWidth / 2 + 10}px").attr('text-anchor', 'left').text((d) ->
                d.name
            ).style 'fill-opacity', (d) ->
                if d.name == "CLUSTER" then 0 else 1
            
            # Declare the links…
            link = svg.selectAll('path.link').data(links, (d) ->
                d.target.id
            )
            # Enter the links.
            link.enter().insert('path', 'g').attr('class', 'link').attr 'd', elbow 
            return
                
        update json
