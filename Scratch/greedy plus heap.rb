Greedy Algo Paradigm

Makes Greedy or Optimal choice at every step in the problem.

The greedy choice is based on some rule, something along the line “select the largest number, select the smallest number”, etc…

Example Problem:


array = [1,-2,5,-5, 6, 8] n = 4


Find N numbers in this array that gives you the largest sum.

So we would select

[8, 6, 5, 1]


When to use a greedy algo…


Two conditions:

1. Greedy choice property: a overall optimal solution can be reached by choosing the optimal choice at each step.
2. Optimal Substructure: A problem has an optimal substructure if an optimal solution to the entire problem contains the optimal solutions to the sub-problems.


What this means is if a greedy choice selection solves each sub-problem and when all sub-problems are solved, it solves the entire problem.


The greedy criteria is how you are selecting the greedy choice.


Here's a problem where we used both heap and greedy: Task Scheduler - https://leetcode.com/problems/task-scheduler/

# @param {Character[]} tasks
# @param {Integer} n
# @return {Integer}
def least_interval(tasks, n)
    # tasks is an array with a task denoted as a letter("A" for example).
    # Each task takes one unit of time to complete.
    # The cpu can either complete a task or idle.
    # n is a cooldown period required before running the a task again.
    # For example when n=2 and task "A" is performed, we must wait
    # 2 units of time before we can run task "A" again. We can "idle"
    # or run another task to consume the 2 units of time.

    # We are being asked what's the minimum units of time to complete all
    # tasks.

    # solution possibilities.
    # 1. Gather all unique sets of tasks with group by
    # 2. sort them by highest count
    # 3. run the tasks with highest count first and then go onto the next tasks
    # 4. If we run out of tasks, we idle.

    # 1.

    bananas_from_unique_lots = tasks

    grouped_bananas = bananas_from_unique_lots.group_by{|lot_number| lot_number }

    # 2
    grouped_bananas.keys.each {|key| grouped_bananas[key] = grouped_bananas[key].size }

    # 3
    count = 0

    count = deplete_first_item_in_array count, grouped_bananas, n


    return count





end

def deplete_first_item_in_array count, grouped_bananas, n, debug = []

    just_deleted = false
    grouped_bananas = grouped_bananas.sort_by{|k, v| -v}.to_h
    if grouped_bananas.keys.size > 0
        count = count + 1

        start_banana_lot_number = grouped_bananas.keys[0]

        grouped_bananas[start_banana_lot_number] = grouped_bananas[start_banana_lot_number] - 1

        debug << start_banana_lot_number

        # when we have no bananas left, aside lot bin
            if grouped_bananas[start_banana_lot_number] < 1
                # set aside lot bin when done
                grouped_bananas = grouped_bananas.except start_banana_lot_number

                just_deleted = true

                #return grouped_bananas.keys

                if grouped_bananas.keys.size == 0
                    return count
                end
            end




        i = 1
        g = 0
        if grouped_bananas.keys.size > 1
            key_size = grouped_bananas.keys.size
            while ((i <  key_size ) && (g < n) )



                if grouped_bananas[grouped_bananas.keys[i]] != nil

                    grouped_bananas[grouped_bananas.keys[i]] =(grouped_bananas[grouped_bananas.keys[i]] - 1)

                    debug << grouped_bananas.keys[i]

                    count = count + 1


                end
                i = i + 1
                g = g + 1

            end
        end

        i = grouped_bananas.keys.size - 1
        while i > 0
            if grouped_bananas[grouped_bananas.keys[i]] < 1
                # set aside lot bin when done
                grouped_bananas = grouped_bananas.except grouped_bananas.keys[i]

                 if grouped_bananas.keys.size == 0
                    return count

                end
            end
            i = i - 1
        end





        if !just_deleted
            while g < (n )
                debug << "idle"
                count = count + 1
                g = g + 1
            end

        end


        deplete_first_item_in_array count, grouped_bananas, n, debug
    else
        return count

    end



end
