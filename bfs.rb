#irb -I . # include directory and start erb.
#require 'bfs' # require dfs.rb file.
#include Bfs #include Dfs module.
module Bfs
    # Breadth first search/bfs essentially transverses the a tree/graph one
    # level at a time.
    # If we have a tree with 3 levels where the root node sits at the top
    # like a pyramid the bfs function will:
    # Print root level, level 1.
    # Print second level, level 2.
    # Print final level, level 3.
    def bfs(node)
        # Queue will store out nodes.
        queue = []
        # Add the first node to the queue.
        queue.push(node)
        # Now while queue size is not 0...
        while(queue.size != 0)
            # We remove the first node from the queue and set the node on the
            # node var.
            node = queue.shift
            # Print the node value to console.
            p node.val
            # Create an array from the nodes children and remove any nil values.
            children = [node.left, node.right].compact
            # Now add both children to the back of the queue.
            children.each do |child|
                queue.push(child)
            end
        end
    end
end

# Now I will demonstrate what the bfs process looks like.

# Lets take an array and convert it to a tree structure.
# array = [1,4,6,33,12,13,76]


# Create tree node class.
# class TreeNode
#    attr_accessor :left, :right, :val

#    def initialize(opts={})
#        @left = opts[:left]
#        @right = opts[:right]
#        @val = opts[:val]
#    end
#end

# Create a tree from tree notes.
# c stands for child nodes(bottom nodes).
# p stands for parent nodes of child nodes.
# root is the root node which children are parent nodes.
#c1 = TreeNode.new({val: 33})
#c2 = TreeNode.new({val:12})
#c3 = TreeNode.new({val:13})
#c4 = TreeNode.new({val:76})
#p1 = TreeNode.new({val:4, left: c1, right: c2})
#p2 = TreeNode.new({val: 6, left: c3, right: c4})
#root = TreeNode.new({val: 1, left: p1, right: p2})


# Our array now looks like the following if we were to visual it.
#            1
#          /   \
#        4       6
#      /   \    /  \
#     33   12  13   76

# When we run dfs method with root as the argument we will get the following:
#1
#4
#6
#33
#12
#13
#76


# Lets break down the results into simple levels.
#LEVEL 1:
#1

# LEVEL 2:
#4
#6

# LEVEL 3:
#33
#12
#13
#76
