#dfs and bfs scratch

# DFS does a deep search on each node, transversing deeper through a node branch
# until it hits a nil. Then it moves onto to the next available node.
# Generally goes from left to right through a tree.
def dfs(node)
    puts node.val

    children = [node.left, node.right].compact
    children.each do |child|
        dfs(child)
    end
end


# BFS transverses through a tree one node level at a time.
def bfs(node)
    queue = [node]

    while queue.size > 0
        # O(n) but average is O(1)
        # Removes and returns first item in array.
        node = queue.shift

        puts node.val

        # Adds left child to queue if available.
        left_child = node.left
        if left_child
            queue.push left_child
        end

        # Adds right child to queue if available.
        right_child = node.right
        if right_child
            queue.push right_child
        end
    end
end
