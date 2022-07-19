module BFS
    # returns an array of nodes for each level as an array
    # e.g. [[level_1_node_1], [level_2_node_1, level_2_node_2], [level_3_node_1, level_3_node_2, etc....] ]
    def level_nodes(node)
        nodes = []
        queue = []
        queue.push(node)
        nodes.push([node])
        level = 1
        children_count = 0
        level_nodes = []
        nodes_in_current_level = 0
        # Amount of possible children nodes for root node.
        # This var will be used to keep track of nodes checked per level.
        potential_amount_of_nodes_remaining_be_checked = 2
        # Dequeue node, add children nodes to queue and continue until we have
        # 0 nodes in the queue.
        while(queue.size != 0)
            # Get node in queue.
            node = queue.shift

            # Get children of node.
            children = [node.left, node.right].compact

            # reduce possibility of nodes in level by 2(as we checked for 2 children nodes)
            potential_amount_of_nodes_remaining_be_checked = potential_amount_of_nodes_remaining_be_checked - 2

            # Add children nodes to level_nodes.
            level_nodes << children
            level_nodes.flatten!

            if potential_amount_of_nodes_remaining_be_checked == 0
                # We break as there are no more levels.
                if level_nodes.size == 0
                    break
                end
                # Add all nodes from the current level to our list of nodes.
                nodes << level_nodes
                # Set the next level.
                level = level + 1
                # The number of potential nodes is always 2 * current level nodes
                # because each node can have 2 children.
                potential_amount_of_nodes_remaining_be_checked = level_nodes.size * 2
                level_nodes = []
            end

            # add children nodes to queue
            children.each do |child|
                queue.push(child)
            end
        end
        nodes
    end
end
