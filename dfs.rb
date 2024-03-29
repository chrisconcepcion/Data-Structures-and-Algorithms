#irb -I . # include directory and start erb.
#require 'dfs' # require dfs.rb file.
#include Dfs #include Dfs module.
module Dfs
    # Dfs/Deep first search essentially iterates through all values of a graph/tree
    # by going left first, going as deep as possible by going left continuously
    # until it runs out of nodes/lands on nil.
    #
    # Now we go right and then repeat the step above(going left until we cannot).
    #
    # After we are out of options, both left and right nodes are nil we go back
    # to the last step where going left was successful but this time we go right
    # and repeat step 1.
    #
    # We continue this process until we run out of nodes to process.
    def dfs(node)
        # Print node value.
        p node.val

        # Create an array from child nodes and remove any nil values.
        children = [node.left, node.right].compact

        # For each child do a deep first search.
        children.each do |child|
            # Do a deep first search on child.
            dfs(child)
        end
    end
end

# Now I will demonstrate what the dfs process looks like.

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
#33
#12
#6
#13
#76

### Practice Questions
# https://leetcode.com/problems/minimum-depth-of-binary-tree/

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer}
def min_depth(root)

    # We want to enumerate down the left and right child node and return the number of nodes transversed.

    # Edge cases.
    # When root is has no children.
    if root == nil
        return 0
    else
        return dfs_depth(root)depth_storage.min
    end

end

def dfs_depth(node, depth = 1, depth_storage = [] )
    # Create an array from child nodes and remove any nil values.
    children = [node.left, node.right].compact
    if children.empty?
        # if there are no children, return the depth and it will be added to
        # to the depth_storage.
        return depth
    else
        # For each child do a deep first search.
        children.each do |child|
            # Do a deep first search on child.
            depth_storage << dfs_depth(child, depth + 1)
            if depth_storage.size > 1
               return  depth_storage.min
            end
        end
    end
    
    # Return the min depth
    return depth_storage.min
end
