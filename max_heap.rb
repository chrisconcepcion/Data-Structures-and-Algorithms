class MaxHeap
    attr_accessor :array, :last_position_index

    def initialize(array, last_position_index)
        @array, @last_position_index = array, last_position_index
    end

    # we only remove max value from the heap.
    # Then we move the last value to the heap in its place and siftdown.
    def remove
        @array[0] = array[@last_position_index]
        array.delete_at @last_position_index
        @last_position_index = @last_position_index -1
        array_size = @last_position_index + 1
        if array_size > 1
           siftdown(0, array_size)
        end
    end

    # add a node to the bottom of the heap and then sift up to ensure
    # we are not violating any heap violations.
    def add(node)
          @array << node
          @last_position_index = @last_position_index + 1
          siftup @last_position_index
    end

    # parent formula ( (child_node_index -1)/2 ).floor()
    def parent_index child_node_index
        ( (child_node_index -1)/2 ).floor()
    end

    # children formula [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    def children_node_indexs parent_node_index
      [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    end

    # ensure we our node at node_index is greater than its parent
    # and recursively continue the process of sifting up until the node is the parent node or
    # we find a parent node with a greater value.
    def siftup node_index
        parent_index = nil
        parent = nil
        node = nil
        begin
            parent_index = parent_index(node_index)
            if parent_index < 0
                return
            end

            parent = @array[parent_index]
            node = @array[node_index]
            if (node_value(parent) >= node_value(node)) || ( parent_index == node_index)
                return
            else
               # replace parent node value with index node value
                @array[node_index] = parent
                @array[parent_index] = node

                # then continue to go up the array to ensure max heap is satified
                siftup parent_index
            end
        rescue Exception => e
            return e
        end
    end

    # ensure our parent node at parent_node_index is larger than it's children, if the parent node is smaller
    # than any of it's children we swap the value of the parent and the child node and continue to
    # siftdown recursively until we find a child node which is smaller or we are at the bottom of the heap.
    def siftdown(parent_node_index, array_size)
        parent_value = @array[parent_node_index] # value of parent
        child_node_index = 2*parent_node_index + 1
        while child_node_index <= (array_size - 1)
              if child_node_index < array_size - 1 && (node_value @array[child_node_index]) < (node_value @array[child_node_index+1])
                  #if there is a right child and the right child is larger than the left
                  child_node_index += 1
              end

              if (node_value parent_value) >= (node_value @array[child_node_index])
                  # if v is the largest then we move on
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

    # build a max heap by making sure all nodes aside from the bottom level of the tree are
    # greater than its parent.
    def build_max_heap
        array_size = @array.size
        i = (array_size/2) - 1
        while i >= 0
          siftdown(i, array_size)
          i = i - 1
        end
    end

    # heapsorting on maxheap will return an array in ascending order.
    # we transverse through the array from beginning to end while
    # 1. storing the highest value element of the array in a var
    # 2. replacing the highest value element in the array with an item from the end of the array
    # 3. sifting the element back down the array to ensure we have no heap violations
    # 4. move largest value we stored in a var at the array to the end of the array(replacing last value of array from step 2)
    # 5 .exclude the largest value of the array from the next iteration(decreasing the array size we are transversing)
    # from here we do continue this pattern recursively until the weakest values are in the front and the largest are in
    # the back in ascending order.
    def heapsort
        build_max_heap
        array_size = @array.size
        i = array_size-1
        while i > 0
            # largest number as of right now
            head_node_value = @array[0]
            # set head node as final node
            @array[0] = @array[i]
            # siftdown final node
            siftdown(0, i)
            # set final node as highest value(head_node_value)
            @array[i] = head_node_value
            # then we reduce the size of the array
            i = i - 1
        end
    end

    def node_value node
        #if node.class == Array
            return node.sum
        #else
        #    return node
        #end
    end
end
