# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @param {Integer} k
# @return {Integer[][]}
def k_smallest_pairs(nums1, nums2, k)

    heap = MinHeap.new([], (0) )
    nums1_length = nums1.size
    nums2_length = nums2.size
    new_array = []

    i = 0
    z = 0
    k_counter = 0
    max_value_for_k = 0
    break_at_index = false
    index_to_refactor_calc = nums2_length - 2
    while i < (nums1_length )
        while z < nums2_length


            if break_at_index
               if z >= break_at_index
                   break
               end
            end
            summed_value = (nums1[i]) + (nums2[z])
            if k_counter < k
                if summed_value > max_value_for_k
                    max_value_for_k = summed_value
                end
            end

            if k_counter >= k
                if summed_value >= max_value_for_k
                    break_at_index = z
                    index_to_refactor_calc = break_at_index/2
                end
            end

            if (z >= index_to_refactor_calc && k_counter >= k)
                    heap.array = (heap.heapsort k, true)
                    max_value_for_k = (heap.array.last).sum
                    index_to_refactor_calc = index_to_refactor_calc * 4
            end




            heap.array << [nums1[i], nums2[z]]
            #heap.add [nums1[i], nums2[z]]
            k_counter = k_counter + 1



            z = z + 1
        end
        i = i + 1
        z = 0
        if break_at_index && break_at_index == 0
            break
        end
    end

    return heap.heapsort k, true
    #return heap.array.size

    # diagnosis helpers
    #return max_value_for_k
    #return break_at_index
    #return new_array
    #return new_array.count
end



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


    def add(node, k = nil)
          #value = (node_value node)
          #if k && k < @count
          #    if value > @max_value
          #        return
          #    end
          #end
          @array << node
          #track_max_value value
          @last_position_index = last_position_index + 1
          ensure_min_heap last_position_index
          @count = @count + 1

    end

    # parent: ( (child_node_index -1)/2 ).floor()
    def parent_index child_node_index
        ( (child_node_index -1)/2 ).floor()
    end

    # children: [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    def children_node_indexs parent_node_index
      [( (2 * parent_node_index) + 1), ( (2 * parent_node_index) + 2)]
    end

    # samething as heapify, assumes part of the array is already sorted, fixes
    # one or a few heap violations
    def ensure_min_heap node_index
        parent_index = nil
        parent = nil
        node = nil
        begin
            parent_index = parent_index(node_index)
            parent = @array[parent_index]
            node = @array[node_index]

            if ((node_value parent) < (node_value node))
                return
            else
              @array[parent_index] = node
              @array[@last_position_index] = parent
              ensure_min_heap parent_index
            end
        rescue Exception => e

        end
    end

    def node_value node
        if node.class == Array
          return node.sum
        else
          return node
        end
    end

    def sorted_elements num_of_elements = nil, sorted_array = [], current_node_indexes = [0]
        if num_of_elements >= sorted_array.count
            current_node_indexes.each do |node_index|
                sorted_array << @array[node_index]
                if num_of_elements >= sorted_array.count

                    sorted_elements num_of_elements, sorted_array, (children_node_indexs node_index)
                else
                  return sorted_array
                end
            end
        else
          return sorted_array
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
          #other wise we swap the parent node with the child node, swapping up
          # the lower value to replace the higher value
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
        i = ( (array_size/2) - 1 )
        while i > -1
            siftdown(i, array_size)
            i = i - 1
        end
    end

    # heapsorting on minheap will return an array in descending order
    def heapsort(k = nil, build = nil)
        if build
            build_min_heap
        end
        array_size = @array.size
        k_array = []
        k_counter = 0
        # we are pushing the smallest number to the back of the array then
        # excluding the back of the array in the next iteration
        i = array_size-1
        while i > 0
            #smallest number as of right now
            head_node_value = @array[0]
            # set head node as final node
            @array[0] = @array[i]
            # siftdown if last node value is less than it's children
            siftdown(0, i)
            # set final node as highest value
            @array[i] = head_node_value


            if k
                k_array << head_node_value
                k_counter = k_counter + 1
                if k_counter == k

                    break
                end
            end
            i = i - 1
        end
        # strongest value

        if k
          if k_counter < k
              return @array.reverse
          else
              return k_array
          end

        end
    end
end
