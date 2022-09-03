module BinarySearch
  # Source: https://medium.com/@andrewsouthard1/binary-search-implementation-in-ruby-9636a4bf373c

  # Cool ruby gem for binary search and binary index:
  # https://github.com/tyler/binary_search


  # the idea of binary search is to split the array in half
  # for example we have an array like so [1,2,3,4,5,6,7,8,9]
  # [1,2,3,4] [5] [6,7,8,9] and 5 being the middle point
  # we pick a half by how close we are in the array
  # so lets say n = 3
  # our middle will become 4, and then 3... and we got our answer

  #example when n == 1
  # 7 items, size 7 array
  # [1,2,6,7,8,44,56]
  # i = 0
  # j = 6
  # middle = 3
  # array[middle] > n
  # j = middle - 1 = 2
  # middle = 1
  # array[middle] > n
  # j = middle - 1 = 0
  # middle = 0
  # array[middle] == n



  #example when n == 7
  # 7 items, size 7 array
  # [1,2,6,7,8,44,56]
  # i = 0
  # j = 6
  # middle = 3
  # array[middle] < n
  # i = middle(3) + 1 = 4
  # middle = 10/2 = 5
  # array[middle] > n
  # j = middle - 1 = 4
  # middle = 8/2 = 4
  # array[middle] = n




  # fail to find case
  #example when n == 99
  # 7 items, size 7 array
  # [1,2,6,7,8,44,56]
  # i = 0
  # j = 6
  # middle = 3
  # array[middle] < n
  # i = middle + 1 = 4
  # middle = (i + j)/2 = 5
  # array[middle] < n
  # i = middle(5) + 1 = 6
  # middle = (6 + 6)/2 = 6
  # now we return false


  #example when n == 56
  # 7 items, size 7 array
  # [1,2,6,7,8,44,56]
  # i = 0
  # j = 6
  # middle = 3
  # array[middle] < n
  # i = middle + 1 = 4
  # middle = (i + j)/2 = 5
  # array[middle] < n
  # i = middle(5) + 1 = 6
  # middle = (6 + 6)/2 = 6
  # array[middle] == n

  def binary_search(n, array)
      i = 0
      final_index = array.size - 1

      while i <= final_index
          # calculate middle
          middle = (i + final_index)/2
          if array[middle] == n
              return true
          elsif array[middle] < n
              i = middle + 1
          # when array[middle] > n
          else
              final_index = middle - 1
          end
      end
      false
  end

    # testing for finding all values
    array = [1,2,6,7,8,44,56]
    results = []
    i = 0
    while i < array.size
        results << binary_search(array[i], array)
        i = i + 1
    end

    # final test, testing for a non-available value
    results << binary_search(69, array)

    # we should get 7 true consequentively and a false at the end
    results == [true, true, true, true, true, true, true, false]
end
