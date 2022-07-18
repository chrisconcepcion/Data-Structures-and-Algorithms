module BFS
    def collect_nodes(node)
        nodes = []
        queue = []
        queue.push(node)
        nodes.push([node])
        level = 1
        children_count = 0
        level_nodes = []
        while(queue.size != 0)
            node = queue.shift
            p node.val
            children = [node.left, node.right].compact
            level_nodes << children
            level_nodes.flatten!
            children_count = children_count + 2
            if level * 2 == children_count 
                nodes << level_nodes
                level = level + 1
            end

            children.each do |child|
                queue.push(child)

            end
        end
    end
    nodes
end

1
23
4567
