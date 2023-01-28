# Problem: https://leetcode.com/problems/pacific-atlantic-water-flow/
# Sloppy passing solution

# @param {Integer[][]} heights
# @return {Integer[][]}
def pacific_atlantic(heights)
    # Return an array of coordinates/cell where rain water can flow to BOTH
    # Pacific and Atlantic Ocean.

    # The coordinates/cell should have the highest value when going to the
    # either 2 of the 4 paths to an ocean(2 per path).

    # Left and up is PACIFIC.
    # Right and down is ATLANTIC.

    # Ideas:
    # Check if each cell can make it to both oceans,
    # [0, y] will always have access to PACIFIC
    # [x, 0] will always have access to PACIFIC
    #
    # [0, last_y] will always have access to ATLANTIC
    # [last_x, y] will always have acess to ATLANTIC
    #
    # Make a method that checks for easy conditions first
    # then check for other conditions afterwards.
    # Auto disqualify coordinates/cells that fail one condition.
    #
    # Lets create a hash that contains strongest values for x and y
    #return [[0,0]]

    checker = CoordinateChecker.new(heights)
    checker.all_qualified_candidates


    #return checker.processed_coordinates_results
    return qualified_coordinates = checker.qualified_coordinates
    #return checker.pacific_qualified.keys
    #return checker.atlantic_qualified.keys







end


class CoordinateChecker
    attr_accessor :heights, :last_x, :last_y, :qualified_coordinates, :x_strongest, :y_strongest, :cannot_go, :pacific_qualified, :atlantic_qualified
    def initialize heights
       @heights = heights
       @last_x_index = (heights[0].size - 1)
       @last_y_index = (heights.size - 1)
       @qualified_coordinates = []
       # Hash that contains coordinate results
       # if it's in the hash, it's been processed
       # Hash keys are just the coordinate array converted to a string.
       @processed_coordinates_results = {}
       @cannot_go = {}

       @pacific_qualified = {}
       @atlantic_qualified = {}

    end





    def all_qualified_candidates
        # Find all coordinates that reach pacific ocean
        collect_pacific_qualified


        # Find all coordinates that reach atlantic ocean
        collect_atlantic_qualified


        atlantic_qualified_keys = @atlantic_qualified.keys
        atlantic_qualified_size = atlantic_qualified_keys.size
        index = 0

        while index < atlantic_qualified_size
            coordinate = atlantic_qualified_keys[index]
            if @pacific_qualified[coordinate]
                y_coordinate = coordinate.gsub("[", "").gsub("]", "").split(",")[0].to_i
            x_coordinate = coordinate.gsub("[", "").gsub("]", "").split(",")[1].to_i
                @qualified_coordinates << [y_coordinate, x_coordinate]
            end

            # increase index
            index = index + 1
        end
    end

    def collect_pacific_qualified
        # collect known to qualify coordinates
        heights_y_size  = @heights.size
        y_index = 0
        while y_index < heights_y_size
            @pacific_qualified[[y_index, 0].to_s] = true
            y_index = y_index + 1
        end

        heights_x_size = @heights[0].size
        x_index = 0
        while x_index < heights_x_size
            @pacific_qualified[[0, x_index].to_s] = true
            x_index = x_index + 1
        end

        # now we need to transverse nodes linked to qualified coordinates and ignore
        # 1. qualified coorinates
        # - check @pacific_qualified for non-true and non-false
        # 2. coordinates in our list of possibilities so we don't have duplicates
        # we need a determinate for processing and failure
        keys = @pacific_qualified.keys
        keys_index = 0
        while keys.size > 0

            key =  keys.shift
            y_coordinate = key.gsub("[", "").gsub("]", "").split(",")[0].to_i
            x_coordinate = key.gsub("[", "").gsub("]", "").split(",")[1].to_i
            possible_linked_nodes = []


            # north
            if y_coordinate < @last_y_index
             possible_linked_nodes << [y_coordinate + 1, x_coordinate]
             end
            # east
            if x_coordinate < @last_x_index
                possible_linked_nodes << [y_coordinate, x_coordinate + 1]
            end
            # south
            if y_coordinate > 0
                possible_linked_nodes << [y_coordinate - 1, x_coordinate]
            end
            # west
            if x_coordinate > 0
                possible_linked_nodes << [y_coordinate, x_coordinate - 1]
            end

            possible_index = 0
            while possible_index < possible_linked_nodes.size

                north_node = possible_linked_nodes[possible_index]
                 if !@pacific_qualified[north_node.to_s] && north_node[0] > 0 && north_node[1] > 0 && @heights[north_node[0]][north_node[1]] >= @heights[y_coordinate][x_coordinate]
                    @pacific_qualified[north_node.to_s] = true
                    keys << north_node.to_s
                end
                possible_index = possible_index + 1
            end

        end
    end

     def collect_atlantic_qualified
        # collect known to qualify coordinates
        heights_y_size  = @heights.size
        y_index = 0
        while y_index < heights_y_size
            @atlantic_qualified[[y_index, @last_x_index].to_s] = true
            y_index = y_index + 1
        end

        heights_x_size = @heights[0].size
        x_index = 0
        while x_index < heights_x_size
            @atlantic_qualified[[@last_y_index, x_index].to_s] = true
            x_index = x_index + 1
        end

        # now we need to transverse nodes linked to qualified coordinates and ignore
        # 1. qualified coorinates
        # - check @pacific_qualified for non-true and non-false
        # 2. coordinates in our list of possibilities so we don't have duplicates
        # we need a determinate for processing and failure
        keys = @atlantic_qualified.keys
        keys_index = 0
        while keys.size > 0
            key =  keys.shift
            y_coordinate = key.gsub("[", "").gsub("]", "").split(",")[0].to_i
            x_coordinate = key.gsub("[", "").gsub("]", "").split(",")[1].to_i
            possible_linked_nodes = []


            # north
            if y_coordinate < @last_y_index
             possible_linked_nodes << [y_coordinate + 1, x_coordinate]
             end
            # east
            if x_coordinate < @last_x_index
                possible_linked_nodes << [y_coordinate, x_coordinate + 1]
            end
            # south
            if y_coordinate > 0
                possible_linked_nodes << [y_coordinate - 1, x_coordinate]
            end
            # west
            if x_coordinate > 0
                possible_linked_nodes << [y_coordinate, x_coordinate - 1]
            end


            possible_index = 0
            possible_linked_nodes_size = possible_linked_nodes.size
            while possible_index < possible_linked_nodes_size
                 north_node = possible_linked_nodes[possible_index]
                 if !@atlantic_qualified[north_node.to_s] && north_node[0] < @last_y_index && north_node[1] < @last_x_index
                    north_node_val = @heights[ north_node[0] ][ north_node[1] ]

                    if north_node_val >= @heights[y_coordinate][x_coordinate]

                        @atlantic_qualified[north_node.to_s] = true
                        keys << north_node.to_s
                    end

                end
                possible_index = possible_index + 1
            end
        end
    end

    def collect_pacific_qualified_2
        # collect known to qualify coordinates
        heights_y_size  = @heights.size
        heights_x_size = @heights[0].size
        y_index = 0
        while y_index < heights_y_size
            @atlantic_qualified[[y_index, heights_x_size - 1].to_s] = true
            y_index = y_index + 1
        end


        x_index = 0
        while x_index < heights_x_size
            @atlantic_qualified[[heights_y_size - 1, x_index].to_s] = true
            x_index = x_index + 1
        end

    end



















    def all_qualified_candidates_2
         # Transverse the array...
        y_index = 0
        heights_size = @heights.size
        while y_index < heights_size
            row = @heights[y_index]

            x_index = 0
            column_size = row.size
            while x_index < column_size
                # 1. check for qualifications
                value = row[x_index]
                if qualify_and_store_coordinate_results(value, x_index, y_index)
                    # 3. storing qualified coordinations

                    @qualified_coordinates << [y_index, x_index]
                end


                # increase column index
                x_index = x_index + 1
            end
            # 2. update our strongest hashes?



            # update our index
            y_index = y_index + 1
        end
    end

    def qualify_and_store_coordinate_results(value, x_index, y_index, requested_qualification = nil)
        coordinate = [y_index, x_index]

        if y_index > 0
            #if @processed_coordinates_results[[y_index - 1, x_index].to_s] != nil && @processed_coordinates_results[[y_index - 1, x_index].to_s]["pacific_qualification"] != nil && @processed_coordinates_results[[y_index - 1, x_index].to_s]["atlantic_qualification"] != nil
            north_val = @heights[y_index - 1][x_index]
            if north_val ==  value
               @processed_coordinates_results[coordinate.to_s] = @processed_coordinates_results[[y_index - 1, x_index].to_s]

                end
            #end
        end

        if x_index > 0
             #if @processed_coordinates_results[[y_index, x_index - 1].to_s] != nil && @processed_coordinates_results[[y_index, x_index - 1].to_s]["pacific_qualification"] != nil && @processed_coordinates_results[[y_index, x_index - 1].to_s]["atlantic_qualification"] != nil
            west_val = @heights[y_index][x_index - 1]
                if west_val ==  value
                     @processed_coordinates_results[coordinate.to_s] = @processed_coordinates_results[[y_index, x_index - 1].to_s]

                end
            #end
        end

        # Check if the coordinate has already been qualified
        # If it has been qualified then we return the results.

        processed_corrdinate = @processed_coordinates_results[coordinate.to_s]
        if processed_corrdinate != nil
            if requested_qualification == nil


                if processed_corrdinate["pacific_qualification"] == nil
                    @cannot_go = {}
                    @cannot_go[[y_index, x_index].to_s] = true
                    processed_corrdinate["pacific_qualification"] = pacific_qualification value, x_index, y_index
                end

                if processed_corrdinate["atlantic_qualification"] == nil
                    @cannot_go = {}
                    @cannot_go[[y_index, x_index].to_s] = true
                    processed_corrdinate["atlantic_qualification"] = atlantic_qualification value, x_index, y_index
                end


                if processed_corrdinate["pacific_qualification"] && processed_corrdinate["atlantic_qualification"]
                    return true
                else
                    return false
                end
            else
                qualification = processed_corrdinate[requested_qualification]
                if processed_corrdinate[requested_qualification] != nil
                    return processed_corrdinate[requested_qualification]
                else
                    # finish this
                    if requested_qualification == "pacific_qualification"
                        coordinate_result_hash = {}
                        coordinate_result_hash["pacific_qualification"] = pacific_qualification value, x_index, y_index

                        #@processed_coordinates_results[coordinate.to_s] = coordinate_result_hash
                        return coordinate_result_hash["pacific_qualification"]
                    elsif requested_qualification == "atlantic_qualification"
                        coordinate_result_hash = {}
                        coordinate_result_hash["atlantic_qualification"] = pacific_qualification value, x_index, y_index

                        #@processed_coordinates_results[coordinate.to_s] = coordinate_result_hash
                        return coordinate_result_hash["atlantic_qualification"]
                    end
                end
            end
        # Else we
        # 1. qualify the coordinate.
        # 2. store the results.
        else

            if requested_qualification != nil
                 # finish this
                    if requested_qualification == "pacific_qualification"
                        coordinate_result_hash = {}
                        coordinate_result_hash["pacific_qualification"] = pacific_qualification value, x_index, y_index
                        return coordinate_result_hash["pacific_qualification"]
                        #@processed_coordinates_results[coordinate.to_s] = coordinate_result_hash


                    elsif requested_qualification == "atlantic_qualification"
                        coordinate_result_hash = {}
                        coordinate_result_hash["atlantic_qualification"] = atlantic_qualification value, x_index, y_index
                        return coordinate_result_hash["atlantic_qualification"]
                        #@processed_coordinates_results[coordinate.to_s] = coordinate_result_hash
                    end
            else
                @cannot_go = {}
                @cannot_go[[y_index, x_index].to_s] = true

                coordinate_result_hash = {}
                coordinate_result_hash["pacific_qualification"] = pacific_qualification value, x_index, y_index
                 @cannot_go = {}
                @cannot_go[[y_index, x_index].to_s] = true
                coordinate_result_hash["atlantic_qualification"] = atlantic_qualification value,  x_index, y_index
                @processed_coordinates_results[coordinate.to_s] = coordinate_result_hash

            end
        end


        processed_corrdinate = @processed_coordinates_results[coordinate.to_s]
        if requested_qualification
            return processed_corrdinate[requested_qualification]
        else
            if processed_corrdinate["pacific_qualification"] && processed_corrdinate["atlantic_qualification"]
                return true
            else
                return false
            end

        end


    end



    def pacific_qualification value, x_index, y_index
        qualified = false
        # When coordinate is in the far left column
        # or
        # when coordinate is in the top column it automatically qualifies.
        if x_index == 0 || y_index == 0
           return true
        end

        # Testing non-simple scenarios.
        if qualified == false
            temp_value = value
            # We need to test all valid values in all 4 directions
            vals = []
            # north
            if y_index > 0
                vals << [y_index - 1, x_index]
            end

            # west
            if x_index > 0
                vals << [y_index, x_index - 1]
            end

            # south
            if y_index < @last_y_index
                vals << [y_index + 1, x_index]
            end

            # east
            if x_index < @last_x_index
                vals << [y_index, x_index + 1]
            end




            vals_index = 0
            vals_size = vals.size
            while vals_index < vals_size
                val_coordinate = vals[vals_index]
                val_y = val_coordinate[0]
                val_x = val_coordinate[1]
                val = @heights[val_y][val_x]



                if @cannot_go[[val_y, val_x].to_s] != true

                    if val <= temp_value
                        @cannot_go[[val_y, val_x].to_s] = true
                        qualified = qualify_and_store_coordinate_results(val, val_x, val_y, "pacific_qualification")
                    end

                    if qualified
                        break
                    end
                end

                vals_index = vals_index + 1
            end
        end

        qualified
    end

    def atlantic_qualification value, x_index, y_index
        qualified = false
        # When coordinate is in the far right column
        # or
        # when coordinate is in the bottom column it automatically qualifies.
        if x_index == @last_x_index || y_index == @last_y_index
            return true
        end

        if qualified == false
            temp_value = value
            # We need to test all valid values in all 4 directions
            vals = []
            # north
            if y_index > 0
                vals << [y_index - 1, x_index]
            end

            # west
            if x_index > 0
                vals << [y_index, x_index - 1]
            end

            # south
            if y_index < @last_y_index
                vals << [y_index + 1, x_index]
            end

            # east
            if x_index < @last_x_index
                vals << [y_index, x_index + 1]
            end

            vals_index = 0
            vals_size = vals.size
            while vals_index < vals_size
                val_coordinate = vals[vals_index]
                val_y = val_coordinate[0]
                val_x = val_coordinate[1]
                if !@cannot_go[[val_y, val_x].to_s]
                    val = @heights[val_y][val_x]
                    if val <= temp_value
                        @cannot_go[[val_y, val_x].to_s] = true
                        qualified = qualify_and_store_coordinate_results(val, val_x, val_y, "atlantic_qualification")
                    end

                    if qualified
                        break
                    end
                end


                vals_index = vals_index + 1
            end

        end
        qualified
    end
end
