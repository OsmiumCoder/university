import mazeSmart as mz

# get size of maze from user
n = int(input("Enter the value of n to create a n x n maze: "))

# loop until input is greater than 2
while n <= 2:
    n = int(input("Please enter another value that is greater than 2: "))

# create and print maze
maze_str = mz.create_maze(n)
mz.print_maze(maze_str)
# get source and destination strings
source = mz.get_source()
dest = mz.get_destination()


# function to extract the coordinates from the returned strings for source and destination
def process_strings():

    # FIND AND EXTRACT SOURCE X VALUE
    src_x_start = source.find(":")  # find the first occurrence of a colon
    src_x_end = source.find(",")  # find the first occurrence of a comma
    # the x value is between the first colon and the first comma in the string
    # extract the value from after the colon and up to the comma using there indices
    source_x = source[src_x_start+1:src_x_end]

    # FIND AND EXTRACT SOURCE Y VALUE
    src_y_start = source.rfind(":")  # find the last occurrence of a colon
    # the last colon precedes the value that is the y value
    # extract everything after the last colon in the string
    source_y = source[src_y_start+1:]

    # FIND AND EXTRACT DESTINATION X VALUE
    dest_x_start = dest.find(":")  # find the first occurrence of a colon
    dest_x_end = dest.find(",")  # find the first occurrence of a comma
    # the x value is between the first colon and the first comma in the string
    # extract the value from after the colon and up to the comma using there indices
    dest_x = dest[dest_x_start+1:dest_x_end]

    # FIND AND EXTRACT THE DESTINATION Y VALUE
    dest_y_start = dest.rfind(":")  # find the last occurrence of a colon
    # the last colon precedes the value that is the y value
    # extract everything after the last colon in the string
    dest_y = dest[dest_y_start+1:]

    # create, print, and return the ordered pair string of the source and destination cells
    coordinates = "(" + source_x + "," + source_y + ")and(" + dest_x + "," + dest_y + ")"
    print("Extracted coordinates: " + coordinates)
    return coordinates


# function to compute a path if any
# takes 3 parameters, which are the maze string, size of the maze, and the coordinate string returned from process_strings()
def compute_path(maze, size, coords):
    # GET X AND Y VALUES OF SOURCE AND DESTINATION
    # coordinate pairs are first extracted from returned string from process_strings()
    src_coords = coords[0:coords.find(")")+1]  # source coordinates are from the first ( to the first )
    dest_coords = coords[coords.rfind("("):coords.rfind(")")+1]  # destination coordinates are from the last ( to the last )

    # raw x and y values are extracted from each coordinate pair
    # all values converted form str to int in order to use mathematically
    src_x = int(src_coords[1:src_coords.find(",")])  # the source x is from the 1th index up to the first occurrence of a comma in the source coordinates
    src_y = int(src_coords[src_coords.find(",") + 1:-1])  # the source y is everything after the first occurrence of a comma up to the ), which is at the last index, in the source coordinates

    dest_x = int(dest_coords[1:dest_coords.find(",")])  # the destination x is from the 1th index to the first occurrence of a comma in the destination coordinates
    dest_y = int(dest_coords[dest_coords.find(",") + 1:-1])  # the destination y is everything after the first occurrence of a comma up to the ),which is the last index, in the destination coordinates

    # INITIALIZE VALUES TO START PATH FINDING
    # path string to concatenate to when a valid move is found
    # contains the source cell to start, each cell's coordinates will be separated by a ;
    path = src_coords + ";"

    # j for the index of the cell below the current cell
    # source y is column number, source x multiplied by size and added in the event we are not starting in the first row
    # size is added to move to the index of the cell beneath the current
    j = src_y + (src_x * size) + size

    current_x = src_x  # current x value of our position to increase when we move down
    current_y = src_y  # current y value of our position to increase when we move right

    go_down = False  # boolean to determine if we can move down 1
    go_diagonal = False  # boolean to determine if we can move down 1 and over 1
    both_possible = False  # boolean if the first move can be either down or diagonal

    # CHECK IF FIRST MOVE CAN BE DOWN, DIAGONAL, OR EITHER
    # if the cell beneath the source cell is a "G" set go_down to True
    if maze[j] == "G":
        go_down = True

    # if the cell beneath the source cell and over 1 is a "G" set go_diagonal to True
    if maze[j+1] == "G":
        # increase j when a diagonal path is possible so that j is the index of the diagonal cell
        j += 1
        go_diagonal = True

    # if first move can be down or diagonal set both_possible to true in order to path find with both first moves
    if go_diagonal and go_down:
        both_possible = True

    # BEGIN PATHFINDING
    # only if a first move of down or diagonal is possible compute the possible path
    if go_diagonal or go_down:
        # loop through maze string and do not exceed the highest index of the string
        # first loop, checks with first move as a diagonal move if possible, or a down move if possible if a diagonal is not possible
        while j < len(maze):
            # FIRST ITERATION:
            # if we can move diagonal as a first move when checked for before looping j will be the index of the cell diagonal to the current
            # EVERY ITERATION AFTER THE FIRST:
            # when we move down j is increased since the next move must be a diagonal increasing j makes it the index of the diagonal cell
            # if our move can be diagonal and the diagonal is a "G", calculate and add the coordinates to the path
            if maze[j] == "G" and go_diagonal:
                # when we move diagonally, both the x and y values increase by 1
                current_x += 1
                current_y += 1

                # so long as the x and the y have not exceeded the size of the maze we can add the coordinates to the path
                if current_x < size and current_y < size:
                    path += "(" + str(current_x) + "," + str(current_y) + ");"  # concatenate the coordinates of the move to the path string

                # once we move diagonal our next move must be down, so flip the go_down and go_diagonal booleans
                go_diagonal = False
                go_down = True

            # FIRST ITERATION:
            # if we could not move diagonal as a first move when checked for before looping j will be the index of the cell beneath the current
            # EVERY ITERATION AFTER THE FIRST:
            # when we move down j is  increased since the next move must be a diagonal causing j to be the index of the cell diagonal to the current
            # if our move can be down and the down is a "G", calculate and add the coordinates to the path
            elif maze[j] == "G" and go_down:
                # once we move down increase j by 1 so that the next move, which must be diagonal, will be the diagonal cell's index
                j += 1

                # when we move down, the x value increases by 1
                current_x += 1

                # so long as the x and the y have not exceeded the size of the maze we can add the coordinates to the path
                if current_x < size and current_y < size:
                    path += "(" + str(current_x) + "," + str(current_y) + ");"

                # once we move down our next move must be diagonal, so flip the go_down and go_diagonal booleans
                go_down = False
                go_diagonal = True

            # if the cell of the next move is an "R" break out of the loop as no path will exist
            else:
                break

            # after every move check if the current x and y equal the destination x and y, respectively
            # if so print the path and end the function
            if current_x == dest_x and current_y == dest_y:
                print_path(path, True)  # runs print_path function to print path
                return None  # return None to end the function

            # after every move if we have not reached the destination increase j by the size of the maze
            # after increasing the value of j, j becomes the index of the cell beneath the current or diagonal to the current if previous move was down
            j += size

        # this block of code is designed in the event that the first move could be either down or diagonal
        # if and only if when first moves were determined
        # compute if path is possible with first move down
        if both_possible:
            # RESET VALUES TO START PATH FINDING WITH FIRST MOVE DOWN
            # path string to concatenate to when a valid move is found
            # contains the source cell to start, each cell's coordinates will be separated by a ;
            path = src_coords + ";"

            # j for the index of the cell below the current cell
            # # source y is column number, source x multiplied by size and added in the event we are not starting in the first row
            # size is added to move to the index of the cell beneath the current
            j = src_y + (src_x * size) + size

            current_x = src_x  # current x value of our position to increase when we move down
            current_y = src_y  # current y value of our position to increase when we move right

            # set go down to True so that the first move can be down
            # set diagonal to False so that the first move has to be down if possible
            go_down = True
            go_diagonal = False

            # loop through maze string and do not exceed the highest index of the string
            # second loop, checks with first move as a down if possible
            while j < len(maze):
                # FIRST ITERATION:
                # go_down is true, if the cell beneath the current is a "G" then down can be the first move
                # EVERY ITERATION AFTER THE FIRST:
                # when we move down j is  increased since the next move must be a diagonal causing j to be the index of the cell diagonal to the current
                # if our move can be down and the down is a "G", calculate and add the coordinates to the path
                if maze[j] == "G" and go_down:
                    # once we move down increase j by 1 so that the next move, which will be diagonal, will be the diagonal cell's index
                    j += 1
                    # when we move down, the x value increases by 1
                    current_x += 1

                    # so long as the x and the y have not exceeded the size of the maze we can add the coordinates to the path
                    if current_x < size and current_y < size:
                        path += "(" + str(current_x) + "," + str(current_y) + ");"

                    # once we move down our next move must be diagonal, so flip the go_down and go_diagonal booleans
                    go_down = False
                    go_diagonal = True

                # FIRST ITERATION:
                # go_diagonal is false, this forces the first move to be a down
                # EVERY ITERATION AFTER THE FIRST:
                # when we move down j is also increased since the next move must be a diagonal causing j to be the index of the diagonal cell
                # if our move can be diagonal and the diagonal is a "G", calculate and add the coordinates to the path
                elif maze[j] == "G" and go_diagonal:
                    # when we move diagonally, both the x and y values increase by 1
                    current_x += 1
                    current_y += 1

                    # so long as the x and the y have not exceeded the size of the maze we can add the coordinates to the path
                    if current_x < size and current_y < size:
                        path += "(" + str(current_x) + "," + str(current_y) + ");"  # concatenate the coordinates of the move to the path string

                    # once we move diagonal our next move must be down, so flip the go_down and go_diagonal booleans
                    go_diagonal = False
                    go_down = True

                # if the cell of the next move is an "R" break out of the loop as no path will exist
                else:
                    break

                # after every move check if the current x and y equal the destination x and y, respectively
                # if so print the path and end the function
                if current_x == dest_x and current_y == dest_y:
                    print_path(path, True)  # runs print_path function to print path
                    return None  # return None to end the function

                # after every move if we have not reached the destination increase j by the size of the maze
                # after increasing the value of j, j becomes the index of the cell beneath the current or diagonal to the current if previous move was down
                j += size

        # if after computing a possible path with first move down or with first move diagonal
        # and we still have not reached the destination print the fact that there is no valid path
        if current_x != dest_x or current_y != dest_y:
            print_path(path, False)  # runs the print_path to print no valid zigzag path

    # if no first move exists print there is no valid path
    else:
        print_path(path, False)  # runs the print_path to print no valid zigzag path


# function to print the valid zigzag path if there is one
# print_path() has 2 parameters the first of which is the path to be printed, and the second to validate the existence of a path
def print_path(path, valid):
    # if the path is valid, valid will be true and we can print the path
    if valid:
        # everytime we add a coordinate to the path a ; is added to the end
        # in printing the path we only go up to the last index so we do not print the last ;
        # as per the instructions the the path once printed should not include a ; at the end
        print("Valid zigzag path: " + path[:-1])

    # if the path is not valid, valid is false so we print a path is not found
    else:
        print("Valid zigzag path not found!")


# run compute_path to find the path if any
compute_path(maze_str, n, process_strings())
