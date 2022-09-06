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
