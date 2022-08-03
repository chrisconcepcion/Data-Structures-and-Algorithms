module DynamicProgramming
  # Dynamic Programming is also called "DP".
  # Dynamic Programming is the act of solving large problem by breaking it
  # down into successively smaller problems.
  # Source:

  # The general idea is we gradually get to a solution by reducing the calculations
  # in a problem usually by storing previously found solutions. This is most likely
  # wrong.

  # Dynamic Programming  is an optimization technique that breaks a problem up
  # into smaller sub-problems in a recursive manner.


  # Backtracking is a prerequiste to dp.
  # What is backtracking? Anytime you have a problem where you have to make a series
  # of decisions, you might make a wrong decision. When you realize that, you
  # have to back track to the place where you made the wrong decision and try
  # something else. This is essentially what back tracking is.
  #
  # For examples, lets say we are in a maze

  https://hackernoon.com/an-introduction-to-backtracking-in-ruby-fb5z32so




   # array inject and reduce(aliases for the same function)
   inject(p1 = v1, p2 = v2) public
  #Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.
  # example:
  # (5..10).inject { |sum, n| sum + n }            #=> 45

  # example #2:
  # if array.inject(0, :+) == k # Identifying goal
  #  return true
  #end
  # this starts an accumalator at 0 and then adds each number in the array to the
  # accumalator. so if array = [1,2,3]
  # it will do... 0+1+2+3 = 6


  # ===REAL NOTES===

  # 3 Steps to backtracking
  # 1. Identifying Choices
  # 2. Identifying Constraints
  # 3. Identifying Goals

  # Lets use our leetcode questions as an example: https://leetcode.com/problems/target-sum/

  # 1. Choices
  # array = [1,2,3,4,5]
  # array = array + array.collect{|n| -n}

  def find_target_sum_ways (nums, target)


  end

  # 2. Constraints
  # You can only use the same variation of a number once
  # so you use 1, or -1




  def find_target_sum_ways(nums, target)
    # Create an array with nums.length many nils within the array.
    memo = [nil] * nums.length
    # set first array value to be an empty hash
    memo[0] = {}
    # set first value as nums as the key of memo[0] and the value as 1
    memo[0][nums[0]] = 1

    # account for nums starting with 0 since -0 is also 0
    if nums[0] == 0
      # if nums[0] is 0, add 1 to memo[0][0] value, so it would become memo[0][0] = 1
      memo[0][nums[0]] += 1
    else
      # otherwise set a new key for memo[0] using -nums[0] and set it's value to 1
      memo[0][-nums[0]] = 1
    end

    # we are starting from 1 since we have already setup memo[0] above
    1.upto(nums.length - 1) do |num_index|
      hash = {}
      # memo_index starts at 0, while num_index starts at 1
      memo[num_index - 1].keys.each do |memo_index|
        # if hash[memo_index - nums[num_index]] is undefined, set
        # hash[memo_index - nums[num_index]] = 0
        hash[memo_index - nums[num_index]] ||= 0
        # if hash[memo_index + nums[num_index]] is undefined, set
        # hash[memo_index + nums[num_index]] = 0
        hash[memo_index + nums[num_index]] ||= 0

        puts (hash[memo_index - nums[num_index]])
        hash[memo_index - nums[num_index]] += memo[num_index - 1][memo_index]
        puts (hash[memo_index - nums[num_index]])
        hash[memo_index + nums[num_index]] += memo[num_index - 1][memo_index]
        puts (hash[memo_index - nums[num_index)
        puts "next memo index"
      end
      puts (memo[num_index])
      memo[num_index] = hash
      puts (memo[num_index])
      puts "next num index"

    end
    puts memo
    memo[nums.length - 1][target] || 0
end



end

old scrap code for leetcode problem

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def find_target_sum_ways( nums,  target)
      # calculate sum


        nums_size =nums.size
       if nums_size == 1
        if  nums[0] == target
            return 1
        elsif -nums[0] == target
            return 1
        else
            return 0
        end
    else

       sum = 0
       for num in nums
            sum += num
       end

       # why do we do this?
       dp = Array.new((target + sum) / 2 + 1){0}
       dp[0] = 1


       for num in nums
         i = dp.length - 1
         while (i >= num)
             dp[i] += dp[i - num]
             i = i - 1
         end
       end
       return dp[dp.length - 1]
   end
end


def find_target_sum_ways2(nums, target)
    correct_count = 0
    # edge case for when nums contains 1 number
    nums_size =nums.size
    if nums_size == 1
        if  nums[0] == target
            return 1
        elsif -nums[0] == target
            return 1
        else
            return 0
        end
    else
        # we want to try every single combination

        i = 0

        answer = [nums[0], -nums[0]]

        i = 1
        while i < nums_size
            if i == (nums_size - 1)
                answer = possibilites answer, nums[i], true, target
            else
                answer = possibilites answer, nums[i]
            end

            i += 1
        end

        return answer
    end
    return correct_count

end

def possibilites array1, num, final = nil, target = nil
    i = 0
    count = 0
    array1_size = array1.size
    new_array = []
    if !final
         while i < array1_size
            new_array << array1[i] + num
            new_array << array1[i] - num
            i += 1
        end
    else
        while i < array1_size
            if (array1[i] + num) == target
                count += 1
            end
            if (array1[i] - num) == target
                count += 1
            end
            i += 1
        end
    end


    if final
         count
    else
         new_array
    end
end
