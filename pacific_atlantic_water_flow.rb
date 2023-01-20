# 75/113 test passing

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
    x_strongest = {}
    y_strongest = {}
    #return [[0,0]]

    checker = CoordinateChecker.new(heights)
    checker.all_qualified_candidates


    #return checker.processed_coordinates_results
    return qualified_coordinates = checker.qualified_coordinates







end


class CoordinateChecker
    attr_accessor :heights, :last_x, :last_y, :qualified_coordinates, :x_strongest, :y_strongest, :cannot_go
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
    end

    def all_qualified_candidates
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
           qualified = true
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


                if @cannot_go[[val_y, val_x].to_s] != true
                    val = @heights[val_y][val_x]
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
            qualified = true
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
