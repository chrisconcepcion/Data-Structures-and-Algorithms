# A pointer is simply a reference to an object.

# Two pointer is the technique of creating two pointers while enumerating
# over an array, list or even a string seperated into characters to process two
# elements instead of one.

# The common setup is to have a fast pointer and a slower pointer. Fast pointer
# is recording a value at a higher index(when using enumerating over
# an array) than the slow pointer.

# Two pointer technique is a prerequiste for linked listed as it's often used
# to find efficent solutions for linked list specifically.

# EXAMPLE #1

# Below is the classic two pointer problem called two_sum. We will solve this
# problem using a hash instead of a slow pointer as it's actually the more efficent
# solution.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
    # We know we need to return 2 indexes, this appears to be a classic two pointer problem.

    # Instead of using a slow pointer, we store all values in a hash instead as it's more efficient than
    # attempting to use a slow pointer. We will call it mem_pointer.

    #Set a hash key as the first array value and 0(index) as the value.
    mem_pointer = {nums[0]=> 0}

    # We set fast pointer in our while loop.
    index = 1
    nums_count = nums.count
    while index < nums_count
        # Set faster pointer.
        fast_pointer = nums[index]

        # Check if we have a key in mem_pointer that when added to fast_pointer
        # will equate to target.
        # The return value if not nil will be the solution as our key
        # is a value in the array and the value in the hash is it's index.
        solution = mem_pointer[target - fast_pointer]

        # If we have a solution, return it along with the current index.
        if solution
            return [solution, index]
        end

        # Set our fast_pointer value as the hash key and it's index as the hash value.
        mem_pointer[fast_pointer] = index

        # Increase index.
        index = index + 1
    end
end

# Example #2

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    # Gets all values for both linked list.
    l1_values = get_all_values_from_linked_list l1
    l2_values = get_all_values_from_linked_list l2

    # Reverses the numbers in an array of numbers.
    l1_values_reversed = l1_values.reverse
    l2_values_reversed = l2_values.reverse

    # Sum the values of both linked lists.
    # We have each value for both linked list in their own.
    # We join the array as a string and then convert to an int.
    # Then we sum up both values.
    sum_of_linked_listed = l1_values_reversed.join("").to_i + l2_values_reversed.join("").to_i

    # Reverse the sum of both linked list and convert to linked list.
    vals_of_summed_linked_list = sum_of_linked_listed.to_s.split("").reverse

    # Create the first list node which we will store as a var to return
    # as our answer.
    answer_node = ListNode.new(vals_of_summed_linked_list.first.to_i)

    # Enumerate through the array of values needed to put together our answer.
    # With each enumeration we connect the previous list node to the current
    # list node to complete the linked list.
    list_size = vals_of_summed_linked_list.size
    index = 1
    current_node = answer_node
    while index < list_size
        # Create next list node.
        next_node = ListNode.new(vals_of_summed_linked_list[index].to_i)
        # Connect current list node to next list node.
        current_node.next = next_node
        # Now we set our current node to the next node.
        current_node = next_node
        # Increase the index.
        index = index + 1
    end

    return answer_node
end

# Gets all values in a linked list.
def get_all_values_from_linked_list linked_list
    return_array = []
    # Add first value of our linked list to the return array.
    return_array << linked_list.val
    # Enumerate through the linked list starting from the second node.
    # as we enumerate, we add the current node value to our return array.
    while linked_list.next
        linked_list = linked_list.next
        return_array << linked_list.val
    end

    return_array
end
