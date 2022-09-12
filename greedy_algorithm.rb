# Greedy Algo Paradigm
# Makes Greedy(Optimal) choice at every step in the problem.

#NOTE:
# The difference between dynamic programming and greedy algorithms is that with
# dynamic programming, there are overlapping subproblems, and those subproblems
# are solved using memoization. "Memoization" is the technique whereby solutions
# to subproblems are used to solve other subproblems more quickly.

# The greedy choice is based on some rule, something along the line
# “select the largest number, select the smallest number”, etc…. We call this
# the greedy criteria.

# Simple example problem:

# Find N numbers in this array that gives you the largest sum.
array = [1,-2,5,-5, 6, 8] n = 4

# So we would select
[8, 6, 5, 1]

# The greedy criteria in the problem above is selecting the largest number
# available until we have n amount of elements.

# There are two conditions to that must be met in order to consider creating
# a greedy algorithm to solve a problem:

#1. Greedy choice property: a overall optimal solution can be reached by
# choosing the optimal choice at each step.

#2. Optimal Substructure: A problem has an optimal substructure if an optimal
# solution to the entire problem contains the optimal solutions to the sub-problems.

# What this means is if a greedy choice selection solves each sub-problem and
# when all sub-problems are solved, it solves the entire problem.

# Let go over the same problem again and go through all the solve problems.


array = [1,-2,5,-5, 6, 8] n = 1

answer = [8]

# This is very straight forward, we know 8 solves this problem.

array = [1,-2, 5, -5, 6, 8] n = 2

answer = [8, 6]

# This is very straight forward, we know 8, 6 ar solves this problem.

array = [1,-2, 5, -5, 6, 8] n = 3

answer = [8, 6, 5]

# This was too simple of an explanation so lets do the coding part so you can
# see how this looks like in practice:

# Find N numbers in this array that gives you the largest sum.
def largest_sum array, n
    subproblem_collector = []
    # While our subproblems solved is less than n, keep collection subproblems.
    # Also stop if we run out of array elements.
    while subproblem_solved.size < n || array.empty?
        # Get highest value, our greedy critera.
        highest_val = array.max
        # Add highest val to our subproblem_collector array
        subproblem_collector << highest_val
        # Delete highest value from our array
        array.delete(highest_val)
    end

    # return our answer, a collection of subproblems.
    subproblem_collector
end

# Now lets run our function with the input from earlier:
array = [1,-2,5,-5, 6, 8]
n = 4
largest_sum array, n

# Before the while loop.
array = [1,-2, 5, -5, 6, 8]
subproblem_collector = []

# This is how array and subproblem_collector changes as we go through our while
# loop.

# Step 1.
array = [1,-2, 5, -5, 6]
subproblem_collector = [8]

# Step 2.
array = [1,-2, 5, -5]
subproblem_collector = [8, 6]

# Step 3.
array = [1,-2, -5]
subproblem_collector = [8, 6, 5]

# Step 4.
array = [-2, -5]
subproblem_collector = [8, 6, 5, 1]

# 100% Fastest and 100% least memory used HARD solution.
# https://leetcode.com/problems/course-schedule-iii/

# @param {Integer[][]} courses
# @return {Integer}
def schedule_course(courses)
    # Sort by course end date in ascending order.
    courses = courses.sort { |a, b| (a[1]) <=>  b[1] }

    # We will use a heap here as removal from an extreme(highest value, lowest value)
    # is inexpensive compared to an array.

    # The plan is we sort by closest end date.
    # Add the course when eligible by end date.
    # When it's a course is not eligible we check:
    # 1. If we remove the most expensive course(days consumed to complete)
    # will the current course have a lower cost.
    # 2. If we remove the most expensive course(days consumed to complete)
    # will the current course be eligible by end date.
    # If the course meets those 2 requirements we:
    # 1. Remove the most expensive course.
    # 2. Deduct the most expensive course cost from days_elapsed.
    # 3. Add our new course.
    # 4. Update days_elapsed to account for new course cost.

    days_elapsed = 0
    index = 0
    courses_size = courses.size
    heap = nil
    while index < courses_size
        # Define course.
        course = courses[index]
        # Define last day.
        course_last_day = course[1]
        # Define duration.
        course_duration = course[0]
        # If course duration is equal to or less than the course last day.
        if course_duration <= course_last_day
            # If course last day is greather than days elapsed + course duration.
            if course_last_day >= (days_elapsed + course_duration)
                # When heap is undefined, we initalize the maxheap.
                if heap == nil
                    heap = MaxHeap.new([course],0)
                else
                    # Add course to heap.
                     heap.add course
                end

                # Update days elapsed to account for course cost.
                days_elapsed = days_elapsed + course_duration
            else
                # When it's a course is not eligible we check:
                # 1. If we remove the most expensive course(days consumed to complete)
                # will the current course have a lower cost.
                # 2. If we remove the most expensive course(days consumed to complete)
                # If the course meets those 2 requirements we:
                # 1. Remove the most expensive course.
                # 2. Deduct the most expensive course cost from days_elapsed.
                # 3. Add our new course.
                # 4. Update days_elapsed to account for new course cost.

                # Deduct the most expensive course cost from days_elapsed
                # by using a temp var called adjusted_days_elapsed.
                adjusted_days_elapsed = days_elapsed - heap.array.first[0]
                if (heap.array.first[0] > course_duration) && (course_last_day >= (adjusted_days_elapsed + course_duration) )
                    # Remove the most expensive course.
                    heap.remove
                    # Add our new course.
                    heap.add course
                    # Update days_elapsed to account for new course cost.
                    days_elapsed = adjusted_days_elapsed + course_duration
                end

            end

        end
        # Increment index.
        index = index + 1
    end

    # If we initialized a heap then show the count.
    if heap
        heap.array.count
    # Otherwise return 0 as we did not add any elements to our heap.
    else
        0
    end

end


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
            return node[0]
        #else
        #    return node
        #end
    end
end
