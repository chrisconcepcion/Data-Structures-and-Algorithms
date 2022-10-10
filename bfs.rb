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

# Methodology on solving graphs and tree based problems with DFS and BFS.

# 1. Understanding the problem.

# 2. Creating a visualization, maybe via drawing.

# 3. Solve a simple use case.



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

### Example Problems
#%93.86 on Leetcode Medium https://leetcode.com/problems/clone-graph/submissions/

# Definition for a Node.
# class Node
#     attr_accessor :val, :neighbors
#     def initialize(val = 0, neighbors = nil)
#		  @val = val
#		  neighbors = [] if neighbors.nil?
#         @neighbors = neighbors
#     end
# end

# @param {Node} node
# @return {Node}
def cloneGraph(node)
    # Attempting to unerstand the problem:
    # An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.
    # This means when supplied [[2,4],[1,3],[2,4],[1,3]]:
    #
    # The neighbors of node 1 are 2 and 4.
    # The neighbors of node 2 are 1 and 3.
    # The neighbors of node 3 are 2 and 4.
    # The neighbors of node 4 are 1, and 3.

    # When our node is nil, we return nil.
    if node == nil
        return nil
    # When our node has no neighbors, create a deep copy and return the deep
    # copy.
    elsif  node.neighbors.empty?
        node_copy = Node.new(node.val)
    else
        # Create a deep copy of all nodes.
        return bfs_cloning(node)

    end
end

# Create a deep copy of all nodes.
# cloned_nodes is our storage for deep clone of original nodes.
def bfs_cloning(node, cloned_nodes = {})

    # Store the original node value so we can reference it later when returning
    # the answer to the problem.
    og_node_val = node.val

    # Initalize an array which we will be using like a queue with our node as
    # the first item.
    queue = [node]

    # Transverse through our queue.
    while queue.size > 0
        # Remove first item in queue and set it as our node.
        node = queue.shift

        # If we do NOT have a deep copy of the node  already in our deep cloned storage, we create
        # a deep copy.
        cloned_node = nil
        if cloned_nodes[node.val] == nil
            cloned_nodes[node.val] = {node: Node.new(node.val), complete: false}
        end

        # If our node has NOT been completed(node cloned and neighbors set properly).
        # This is an important check as it prevents us from essentially being
        # in an infinite loop.
        if !cloned_nodes[node.val][:complete]
            # Set our cloned node var. This is the deep copy of an original node.
            cloned_node = cloned_nodes[node.val][:node]

            # Set up vars that will help transverse in our while loop.
            neighbor_index = 0
            neighbors_size = node.neighbors.size

            # Start our while loop, we will be using this loop to enumerate through
            # the node.neighbors array.
            while neighbor_index < neighbors_size
                # Assign neighbor var.
                neighbor = node.neighbors[neighbor_index]

                # Add neighbor to queue.
                queue.push(neighbor)
                # If we do not have the neighbor already in our deep cloned storage, we create
                # a deep copy of the neighbor node.
                if cloned_nodes[neighbor.val] == nil
                    cloned_nodes[neighbor.val] = {node: Node.new(neighbor.val), complete: false}
                end

                # Add our deep copy of neighbor node as a neigher of our
                # cloned node.
                cloned_node.neighbors.push(cloned_nodes[neighbor.val][:node])

                # Update index value.
                neighbor_index = neighbor_index + 1
            end
            cloned_nodes[node.val][:complete] = true
        end
    end

    return cloned_nodes[og_node_val][:node]

end



# Leetcode 207 https://leetcode.com/problems/course-schedule/submissions/

# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish(num_courses, prerequisites)
    prerequisites_size = prerequisites.size
    # If there are only two courses(single prerequisite pair)
    # return true as both can be taken in order of b1 and then a1.
    if (prerequisites_size == 1)
        return true
    else

        queue = []

        # b1 is the only course u can take from the array.
        # Be aware that a course in a1 found in another array with the same
        # value means that course cannot be taken.
        courses_can_be_taken = 0

        # Notes to self:
        # Need something to store prerequisite data, maybe a hash.
        # Need to push prerequisite course ahead of the course required.
        # Need to be aware that if a prerequiste to a course cannot
        # have a prequiste that is a course or else we will have to return false.

        # prerequiste_data hash
        # key is the course value
        # value should be a hash,
        # value : {
        #  prequisites_completed: boolean
        #  prequisites: array
        #  completed: boolean
        #  prequisite_to: array
        # }

        prerequiste_data = {}

        index = 0
        while index <  prerequisites_size
             prerequisite = prerequisites[index]
             course = prerequisite[0]
             course_prerequisite = prerequisite[1]
            # If course is NOT in prerequiste_data....
            # 1. Add the course to prerequiste_data
            # 2. Add it's prequisites
            if !prerequiste_data[course]
                prerequiste_data[course] = {prequisites_completed:  false, completed: false, prequisites: [course_prerequisite], prequisite_to: []}
            else
                prerequiste_data[course][:prequisites].push  course_prerequisite
            end

            # If course_prerequisite is NOT in prerequiste_data....
            # 1. Add the course_prerequisite to prerequiste_data.
            # 2. Add course which this is a prerequiste_to in our hash.
            if !prerequiste_data[course_prerequisite]
                prerequiste_data[course_prerequisite] = {prequisites_completed:  false, completed: false, prequisites: [], prequisite_to: [course]}
            else
                prerequiste_data[course_prerequisite][:prequisite_to].push course
            end

             index = index + 1
        end

        # Put all courses with no prerequiste in front of queue, push courses
        # with prerequistes to back of queue.
        prerequiste_data.keys.each do |key|
            if prerequiste_data[key][:prequisites] == []
                queue.unshift key
            else
                queue.push key
            end

        end


        while queue.size > 0
            course = queue.shift
            # if course has no requiste,
            # 1. mark it complete
            # 2. update completed course count
            # 3. remove prerequiste from courses that require
            # the completed course
            # 4. push courses with no prerequiste to front of queue
            if (prerequiste_data[course][:prequisites] == []) && (prerequiste_data[course][:completed] == false)
                prerequiste_data[course][:completed] = true
                if prerequiste_data[course][:prequisite_to].size > 0
                    prerequiste_data[course][:prequisite_to].each do |course_|
                        prerequiste_data[course_][:prequisites].delete(course)
                        if prerequiste_data[course_][:prequisites] == []
                            index = queue.index(course_)

                            if index
                                if index == queue.size - 1
                                    queue.pop
                                else
                                    queue[index] = queue.pop
                                end

                                queue.unshift(course_)
                            end
                        end
                    end
                end
            # If a course has a prerequiste
            # 1. check if the prerequiste is completed and if so
            # 2. mark as completed
            # 3. remove prerequiste from courses that require
            # the completed course
            # 4. push courses with no prerequiste to front of queue
            elsif prerequiste_data[course][:prequisites] && prerequiste_data[course][:completed] == false
                if prerequiste_data[prerequiste_data[course][:prequisites][0]][:completed]
                    prerequiste_data[course][:completed] = true
                    if prerequiste_data[course][:prequisite_to].size > 0
                        prerequiste_data[course][:prequisite_to].each do |course_|
                            prerequiste_data[course_][:prequisites].delete(course)
                            if prerequiste_data[course_][:prequisites] == []
                                index = queue.index(course_)
                                if index
                                    if index == queue.size - 1
                                        queue.pop
                                    else
                                        queue[index] = queue.pop
                                    end

                                    queue.unshift(course_)
                                end
                            end
                        end
                    end
                end
            end
        end

        # Check if all courses have been completed.
        # success will equal nil if all courses have been completed.
        success = prerequiste_data.keys.detect{|k| prerequiste_data[k][:completed] == false}
        if success == nil
            return true
        else
            return false
        end
    end
end
