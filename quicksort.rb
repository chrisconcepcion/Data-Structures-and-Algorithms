module Quicksort
    # We essentially are iterating over this array with a two pointer technique
    # where one of the pointers will fall behind the other during our while
    # loop(pIndex will fall behind).
    #
    # If the pointer doesn't fall behind that means the final value in the index
    # is the highest value therefore we do it again with a smaller array excluding
    # the highest value(smaller array, highest value is sorted).
    #
    # In the case were pIndex pointer falls behind, we start to shift one element
    # element from the front of the array one spot and another ahead of it backwards.
    # until we can exclude the final value again giving us an even smaller array.
    #
    # This is done continuously until the entire array is sorted.
    def quicksort(array, from=0, to=nil)
      # demonstration array below
      # [1,5,3,2,4]
      # from = 0
      # last = 4
      if first < last
        j = partition(array, first, last)
        # j = 3, array = [1,3,2,4,5]
        # sorts left side of array, [1,3,2]
        quicksort array, from, j - 1
        # sorts right side of array, [5], we actually do not sort anything.
        quicksort array, j + 1, to
      end
      # end result of our demonstration gives us an array of
      # [1,2,3,4,5]
    end

    def partition(array, first, last)
        pivot = array[last]
        pIndex = first
        i = first
        # demonstration array below
        # [1,5,3,2,4]
        while i < last
            if array[i].to_i <= pivot.to_i
                prev_array_i = array[i]
                array[i] = array[pIndex]
                array[pIndex] = prev_array_i
                pIndex += 1
            end
            i += 1
        end
        # iteration 0, we add 1 to both i and pIndex
        # i = 1
        # pIndex = 1
        # iteration 1, we add 1 to i, but nothing to pIndex because !(array[i].to_i <= pivot.to_i) == true
        # i = 2
        # pIndex = 1

        # iteration 2
        # we now have to swap values in array since i and pIndex differs
        # [1,3,5,2,4]
        # we add 1 to both i and pIndex
        # i = 3
        # pIndex = 2

        # iteration 3, we add 1 to both i and pIndex
        # we now have to swap values in array since i and pIndex differs
        # [1,3,2,5,4]
        # we add 1 to both i and pIndex
        # i = 4
        # pIndex = 3

        # now since i == last we exit the loop and execute the below

        #then we have
        #[1,3,5,2,4]
        i = 2
        p = 5

        #[1,3,2,5,4]

        prev_array_last = array[last]
        # prev_array_last = 4
        array[last] = array[pIndex]
        # array[pIndex] = 5
        # array[last] = 5
        array[pIndex] = prev_array_last
        # array[pIndex] = 4

        # updated array [1,3,2,4,5]
        return pIndex
        # return 3
    end
end
