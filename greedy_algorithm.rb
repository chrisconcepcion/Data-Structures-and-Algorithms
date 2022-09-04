# Greedy Algo Paradigm
# Makes Greedy(Optimal) choice at every step in the problem.

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
