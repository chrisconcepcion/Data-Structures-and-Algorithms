# Review BFS and DFS methods

# Dfs stands for Deep First Search.
# DFS Goes from left to right, digging through each node one at a time before starting at the next.

def dfs(node)
    # Prints node value
    puts node.val

    # Starts a dfs with child node, since the first child node would be the left
    # node, we are doing a deep first search starting from the parent node of
    # the tree and going the furthest left possible before exploring the right
    # node options.
    node.children.each do |child|
        dfs(child)
    end
end


# BFS stands for Breadth First Search.
# BFS transverses one row at a time and then goes down another left and repeats.
def bfs(node)
    queue = [node]
    while queue.size > 0
        node = queue.shift
        puts node.val

        children = node.children
        if children.size > 0
            queue.concat children
        end
    end

end


# Find videos to go over strategies
