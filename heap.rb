# Heap
# Rules of the Data Structure:
# 1. The tree must be filled aside from the bottom row and completed
# starting from left to right.
# 2. Each completed level must have double the elements of the parents
# aside from the bottom row.

# Indexes of nodes are read from top level and downwards, starting from
# the left side. Example below with indexes within parenthesis:
#
#               20(0)
#            /      \
#         19(1)       18(2)
#        /   \      /      \
#     14(3)  13(4) 12(5)   22(6)

# Formula for Retrieving Node Indexes:
# children: (2x parent) + 1, (2x parent) + 2
# parent: floor( (child -1)/2 )
# Examples with the heap tree below:
#               20(0)
#            /      \
#         19(1)       18(2)
#        /   \      /      \
#     14(3)  13(4) 12(5)   22(6)


# index of parent of 19 = floor( (1-1)/2 ) = 0
# index of child node of 18 = (2*2) + 1 = 5, 18 = (2*2) + 6 = 6. 5 and 6 are
# the children nodes.


# MinHeap: Nodes sorted in ascending order(lowest to highest)
# => parent node < children node
#               1
#            /    \
#           2      3

# MaxHeap: Nodes sorted in descending order(highest to lowest)
# => parent node > children node
#               3
#            /    \
#           2      1

# Add:
# - Adding nodes require you add the value at the next available node.
# - if this creates a violation swap the newest value up until the heap is
# fixed.

# We added 22 to the next available node below and we created a heap violation
#               20
#            /      \
#         19        18
#        /  \      /  \
#     14     13  12     22

#               20
#         19        22
#        /  \      /  \
#     14     13  12     18

# To fix this we need to swap the higher value up one level until the heap
# is fixed. Swap 22 with 20


#               22
#            /      \
#         15        20
#        /  \      /  \
#     11     12  12     18

# And now it's fixed.
# This is considered a max heap. We have followed all the rules.

# Remove:
# - Always remove the root element and swap it with the last node in the array.
# - If there is still a violation swap down with the largest
# child in the node continously until the heap is fixed.


#               18
#            /      \
#         15        22
#        /  \      /  \
#     11     12  12    20

# now we fix this violation by removing 18 and swapping it with 20.

#               20
#            /      \
#         15        22
#        /  \      /  \
#     11     12  12    18

# now we fix the next violation by moving 20 down and swapping with 22

#               22
#            /     \
#         15        20
#        /  \      /  \
#     11     12  12    18

# And now it's fixed.
# This is considered a max heap. We have followed all the rules.

class Heap
    attr_accessor: heap, last_position_index


    def add(node)

          heap << node
          last_position_index = last_position_index + 1

          ensure_max_heap node



    end

    # parent: ( (child_node -1)/2 ).floor()
    def parent_index child_node
        ( (child_node -1)/2 ).floor()
    end

    # children:
    def children_node_indexs parent_node
      [( (2 x parent_node) + 1), ( (2 x parent_node) + 2)]
    end

    def ensure_max_heap node
      parent_index = parent_index(node)
      parent = heap[parent_index]
      if !parent > node
          heap[parent_index] = node
          heap[last_position_index] = parent
      end
      ensure_max_heap node
    end
end
