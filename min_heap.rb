# Heap Data Structure

# Sources:
# Heaps 1 Introduction and Tree levels - https://www.youtube.com/watch?v=BzQGPA_v-vc
# Heaps 2 Add Remove - https://www.youtube.com/watch?v=7KhYwHfx40U&t=13s
# Heaps 3 TrickleUp - https://www.youtube.com/watch?v=6i15PI_VP-E
# Heap sort in 4 minutes - https://www.youtube.com/watch?v=2DmK_H7IdTo
# Heap Sort Algorithm - https://www.interviewkickstart.com/learn/heap-sort

# Heap - Essentially an ordered binary tree.
# Max Heap - Parent is always larger than children.
# Min Heap - Parent is always smaller than children.

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



class MinHeap
    attr_accessor :array, :last_position_index, :max_value, :count

    def initialize(array, last_position_index = nil)
        @array = array
        if last_position_index
            @last_position_index = last_position_index
        else
            @last_position_index = (array.size - 1)
        end
        @max_value = nil
        @count = 0

    end

    def track_max_value node_value
        if !@max_value
            @max_value = node_value
        elsif @max_value < node_value
            @max_value = node_value
        end
    end


    def add(node, k)
          value = (node_value node)
          if k < @count
            if value > @max_value
              return
            end
          end
          @array << node
          track_max_value value
          @last_position_index = last_position_index + 1
          ensure_min_heap last_position_index
    end

    # parent: ( (child_node_index -1)/2 ).floor()
    def parent_index child_node_index
        ( (child_node_index -1)/2 ).floor()
    end

    # children: [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    def children_node_indexs parent_node_index
      [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    end


    def node_value node
        if node.class == Array
          return node[1].size
        else
          return node
        end
    end


    def siftdown(parent_node_index, array_size)
      parent_value = @array[parent_node_index] # value of parent
      child_node_index = 2*parent_node_index + 1
      while child_node_index <= (array_size - 1)
        # we our child node is at the left child
        # we determine which child has the least value and change our
        # child node index accordingly
        if child_node_index < array_size - 1 && (node_value @array[child_node_index]) > (node_value @array[child_node_index+1])
          #if there is a right child and the right child is less than the left
          child_node_index += 1
        end
        # if parent value is smaller than our child node then leave the parent
        # in the same position
        if (node_value parent_value) <= (node_value @array[child_node_index])
          break
        else
          #swap position
          @array[parent_node_index] = @array[child_node_index]
          # move down to the next search
          parent_node_index = child_node_index
          child_node_index = 2*parent_node_index + 1
        end
      end

      @array[parent_node_index] = parent_value
    end

    # builds a min heap from an unsorted array
    def build_min_heap
        array_size = @array.size
        i = (array_size/2) - 1
        while i >= 0
              siftdown(i, array_size)
              i = i - 1
        end
    end

    # heapsorting on minheap will return an array in descending order
    def heapsort(k = nil)
        build_min_heap
        array_size = @array.size
        i = array_size-1

        # we are pushing the smallest number to the back of the array then
        # excluding the back of the array in the next iteration
        while i > 0
            #smallest number as of right now
            head_node_value = @array[0]
            # set head node as final node
            @array[0] = @array[i]
            # siftdown if last node value is less than it's children
            siftdown(0, i)
            # set final node as highest value
            @array[i] = head_node_value
            i = i - 1
        end
    end
end
