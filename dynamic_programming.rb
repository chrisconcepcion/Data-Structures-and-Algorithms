#### Solving Dynamic Programming Problems.
# The 3 skills required:
# 1. Techniques(Backtracking, MEMOIZATION)
# 2. Strategy(MEMOIZATION, Tabulation)
# 3. Forumlation Method

### Techniques requires for Dynamic Programming problems.
# 1. Backtracking.
# 2. Memoization

##BACKTRACKING

# Backtracking is an problem solving algorithm that uses a brute force for
# finding a desired output.

# You can indentify backtracking problems as they typically ask for a subset
# of all possibilities.

# The term backtracking suggests that if the current solution is not suitable,
# then backtrack and try other solutions. Recursion is used in this approach.

# Backtracking isn't exactly a specific algorithm but more of guidelines to
# create an algorithm, so it is actually a technique.

# Source for this example: https://hackernoon.com/an-introduction-to-backtracking-in-ruby-fb5z32so
module Backtracking
    # Returns true if any combination of elements in the array when combined equate
    # to sum, otherwise return false.
    def exact_sum?(sum, array)
        # We found the answer, return true.
        return true if sum==0
        # Edge case: if sum is less than 0 or array is empty, there is no solution.
        return false if sum < 0 || array.empty?
        # Recursively call exact_sum? with sum minus the first element of
        # the array. We reduce the sum because if we get it to 0, we have an
        # answer.
        exact_sum?(sum - array[0], array[1,array.length]) ||
        # Or we attempt to redo the recursively call exact_sum but with the
        # first element in the array removed. This way we can try all
        # possible combinations of sums of the array to see if any equate
        # to sum.
        exact_sum?(sum, array[1,array.length])
    end
end

# We can demonstrate how this solves problems by going through all possibilities
# on a smaller sized array.

# sum = 5
# array = [1,2,3]

# Step 1
# If we keep reduce sum by all values in array, we get -1(1+2+3 = 6). False

# Step 2
# If we remove first element and reduce sum by all values in array, we get 0(2+3 = 5). True

# Step 3(continuing for the sake of explanating)
# If we remove first element and reduce sum by all values in array, we get 3(3 = 3). False

# Step 4
# When keeping 1 and removing 2, all values sum up to 4(1+3). False

# Step 5
# When keeping 1 and removing 2 and 3, all values sum up to 1. False

# Step 6
# When removing 1 and keeping 2 and removing 3, all values sum up to 2. False

# Step 7
# When keeping 1 and keeping 2 and removing 3, all values sum up to 3. False

# After exhausting all possibilities we have 1 correct answer out of all possibilities.

##MEMOIZATION

# Memoization is an optimization technique that ensures a method doesn't run for
# the same input more than once by keeping a record of the results for the given
# inputs.

# Memoization is a common strategy for dynamic programming.
# Example:

# You are climbing a staircase. It takes n steps to reach the top.

# Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
def climb_stairs(n, memo = Hash.new)
    # No steps to go up means 0 solutions.
    return 0 if n < 0
    # If n is 0, there is 1 solution.
    return 1 if n == 0
    # If value has been previously calculated, return the value.
    return memo[n] if memo.has_key?(n)
    # Step backwards recurisively until all previous subproblems have been solved
    # in order to solve the current problem.
    memo[n] = climb_stairs(n-1, memo) + climb_stairs(n-2, memo)
end


### Common Strategies for Dynamic Programming problems.
# Source: https://www.interviewcake.com/concept/python/bottom-up?

## Top-down, also known as "Memoization"
# Creating a method that calls a function recursively typically to collect
# solutions to subproblems.
# Example:

# O(n) space and O(n) time.
# IMPORTANT: O(n) space often creates stack overflow error/ran out of memory.
def product_one_to_n(n)
    # Assuming n >= 1
    if n > 1
      return n * product_one_to_n(n-1)
    else
      return 1
    end
end



## Bottom-up, also known as "Tabulation"
# IMPORTANT: O(1) space, O(N) time.
# Essentially we try to get the entire calculation to compute in linear time.
def product_one_to_n(n)
    # Assuming n >= 1
    result = 1
    index = 1
    while index < n
        result = result * index

        # Increase index.
        index = index + 1
    end

end

### Formulation Strategy

#Source: https://www.youtube.com/watch?v=aPQY__2H3tE

#1. Visual Examples
#	1. -It's a great way to see connections and underlying patterns in the problem that can later be relevant to finding a solution. Diagramming out what makes a valid sequence. A model that shows up all the time in dynamic programming is the directed acyclic graph. Imagine each element of the is a node in a graph and we construct a directed edge from one node to another if the node on the right contains a larger value.



#2. Find an Appropriate Sub Problem
	#1. Sub problem is essentially a simpler version of our overall problem.
	#2. This is a bit tricky to figure out so what we need to do is start stating what we know.

	   #For example:
	   #in the LIS problem we know the answer is a subset of the original sequence. Our subset is a starting point and an ending point in the sequence.

	   #We can make the problem smaller by saying.
	   #Subproblem: LIS[k] = LIS ending at index k
#3. Finding Relationships Between Subproblems.
	#1. how can we figure out the subproblems for ending at index 4?

	   [3,1,8,2,5]

	   LIS[4]  = ?

	   #So now lets solve some subproblems
	   #LIS[0] is asking whats the longest increasing sequence ending at index 0? it's 1 because there is only 1 number.

	   LIS[0] = 1

	   #Now lets do more

	   LIS[1] = 1 because there is no increasing sequence that leads to 1 in [3,1]
	   LIS[2] = 1,  [3,1,8] as 1 is less than 5 and nothing else is less than 5 sequence.
	   LIS[3] = 2,     [3,1,8,2,5] as 1, and 2 are less than 5.
	   LIS[4] = 3 becomes 3.

	   #Now look at the formula we have
	   LIS[4] = 1 + [LIS[0], LIS[2], LIS[3]].max, we skip storing LIS[1] has the same answer as LIS[0]




#4. Generalize the Relationship

	#How do we solve LIS[5]?

	#A = [3,1,8,2,5]

	#We choose subproblems where:

	answer = 0
	index = 0
	while index < 5
		if A[index] <  A[5] and LIS[index] > answer
			answer = LIS[index]
		end
		index = index + 1
	end

	LIS[5] = 1 + answer


	#5. Implementing by solving subproblems in order.

	#We have to solve all sub problems answering our problem so lets write a function which is essentially an algo to solve any of these problems.


	def find_longest_increasing_sequence array
		#solved_subproblems = []
		# first subproblem is 1
		#solved_subproblems << 1

		index = 1
		while index < array.size
			solved_subproblems = subproblem array, index, solved_subproblems
			index = index + 1
		end

		return solved_subproblems.max
	end


	def subproblem array, index_of_subproblem, solved_subproblems

		answer = 1
		index = 0
		while index < index_of_subproblem
			if array[index] <  array[index_of_subproblem] and solved_subproblems[index] > answer
				answer = solved_subproblems[index]
			end
			index = index + 1
		end

		solved_subproblems[index_of_subproblem] = answer

		return solved_subproblems
	end
