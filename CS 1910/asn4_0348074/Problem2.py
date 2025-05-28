import mazeAsn4 as mz
import math

print("******PROBLEM 1******")

# CREATE AND PRINT MAZE
maze_str = mz.create_maze(0)
mz.print_maze(maze_str)

# GET COORDINATES
# get source in the format [["source_x", a],["source_y", b]]
source = mz.get_source()
src_x = source[0][1]  # first item in source list is X list, second item in X list is X value
src_y = source[1][1]  # second item in source list is Y list, second item in Y list is Y value

# get source in the format [["destin_x:", a],["destin_y:", b]]
destination = mz.get_destination()
dest_x = destination[0][1]  # first item in destination list is X list, second item in X list is X value
dest_y = destination[1][1]  # second item in destination list is Y list, second item in Y list is Y value

# print source and destination coordinates
print("Source coordinates: X:", src_x, "Y:", src_y)
print("Destination coordinates: X:", dest_x, "Y:", dest_y)


# PATHFINDING FUNCTION
# function to compute path
def compute_path(maze, src, dest):
    # find the size of the maze from the sqrt of the length of the maze string
    # truncate to integer so not to be a float
    size = int(math.sqrt(len(maze)))

    # DETERMINE SOURCE AND DESTINATION VALUES
    src_i = src[0][1]  # first item in source list is X list, second item in X list is X value
    src_j = src[1][1]  # second item in source list is Y list, second item in Y list is Y value
    dest_i = dest[0][1]  # first item in destination list is X list, second item in X list is X value
    dest_j = dest[1][1]  # second item in destination list is Y list, second item in Y list is Y value

    # list T for partial paths beginning with the source coordinates
    T = [[(src_i, src_j)]]

    # as long as a partial path still exists loop pathfinding algorithm
    while len(T) > 0:
        # VALUES FOR PARTIAL PATH
        # remove the first list element from T and assign it to E
        E = T.pop(0)

        # get last tuple element in E which are the coordinates of the last cell in the partial path/current location
        last = E[-1]
        i = last[0]  # the first item of the last tuple is the X value of the current location
        j = last[1]  # the second item of the last tuple is the Y value of the current location

        # INDICES OF CELLS
        index = j + i * size  # index of the current location in the maze string
        dia_left_index = index + size - 1  # index of the diagonal down left cell
        down_index = index + size  # index of the down cell
        dia_right_index = index + size + 1  # index of the diagonal down right cell

        # BEGIN PATHFINDING FOR CURRENT PARTIAL PATH
        # DIAGONAL LEFT
        # if the index of the diagonal left move has not exceeded the len of the maze string
        # check if move is possible
        if dia_left_index < len(maze):
            # check if move is valid
            if maze[dia_left_index] == "G":
                # check that we do not go over the bounds of the size of the maze by moving
                if j - 1 >= 0 and i + 1 < size:
                    # append the diagonal left move as a tuple to list E
                    E.append((i + 1, j - 1))
                    # append copy of the current partial path E to T to compute possible further path on successive
                    # iterations
                    T.append(E.copy())
                    # remove last tuple we just added from list E to compute any more partial paths with other moves
                    del E[-1]

        # DOWN
        # if the index of the down move has not exceeded the len of the maze string
        # check if move is possible
        if down_index < len(maze):
            # check if move is valid
            if maze[down_index] == "G":
                # check that we do not go over the bounds of the size of the maze by moving
                if i + 1 < size:
                    # append the down move as a tuple to list E
                    E.append((i+1, j))
                    # append copy of the current partial path E to T to compute possible further path on successive
                    # iterations
                    T.append(E.copy())
                    # remove last tuple we just added from list E to compute any more partial paths with other moves
                    del E[-1]

        # DIAGONAL RIGHT
        # if the index of the diagonal right move has not exceeded the len of the maze string
        # check if move is possible
        if dia_right_index < len(maze):
            # check if move is valid
            if maze[dia_right_index] == "G":
                # check that we do not go over the bounds of the size of the maze by moving
                if i + 1 < size and j + 1 < size:
                    # append the diagonal right move as a tuple to list E
                    E.append((i+1, j+1))
                    # append copy of the current partial path E to T to compute possible further path on successive
                    # iterations
                    T.append(E.copy())
                    # remove last tuple we just added from list E to compute any more partial paths with other moves
                    del E[-1]

        # CHECK FOR VALID PATH
        # loop through list T looking at each path list
        for path in T:
            # first item of last tuple in path list is X value
            # and second item of last tuple in path list is Y value
            # if these X and Y values match the destination coordinates a valid path has been found
            if path[-1][0] == dest_i and path[-1][1] == dest_j:
                return path  # return list path to be printed

    # if after computing all possible paths no path has been found
    # return empty list
    return []


# variable to hold returned path from compute path
the_path = compute_path(maze_str, source, destination)

valid_path_count = 0  # variable to increase as a valid path is found
maze_dict = {}  # empty dictionary to add mazes with valid paths to

# PRINT PATH IF VALID
# if the problem 1 returned path is not empty a path was found
if len(the_path) > 0:
    print("Valid path found:", the_path)

    # COUNT PATH IF FOUND IN PROBLEM 1
    # increase the count of valid maze path
    valid_path_count += 1
    # create new key value pair for dictionary in the format:
    # MazeX : [maze string, returned path], where X is maze number
    maze_dict["Maze"+str(valid_path_count)] = [maze_str, the_path]

# if the returned path was empty no path is valid
else:
    print("A valid path does not exist!")


print("******PROBLEM 2******")

# FIND 10 VALID MAZES
# loop through maze creation and pathfinding until 10 mazes with valid paths are found
while valid_path_count < 10:
    # CREATE NEW MAZE
    # create a new maze which will have random size n between 3 and 9 inclusive
    nth_maze = mz.create_maze(1)

    # GET NEW COORDINATES
    # get source in the format [["source_x", a],["source_y", b]]
    nth_source = mz.get_source()
    # get source in the format [["destin_x:", a],["destin_y:", b]]
    nth_destination = mz.get_destination()

    # variable to hold path of current maze attempt
    attempt = compute_path(nth_maze, nth_source, nth_destination)

    # if the current maze attempt is not an empty list after computing a path
    # we have found a valid maze and path
    if len(attempt) > 0:
        # increase the count of valid maze path
        valid_path_count += 1
        # create new key value pair for dictionary in the format:
        # MazeX : [maze string, returned path], where X is maze number
        maze_dict["Maze"+str(valid_path_count)] = [nth_maze, attempt]

# WRITE DICTIONARY OF VALID MAZES TO TXT FILE
# open, or create if none exist, file named maze.txt in write mode
file = open("maze.txt", "w")
# loop through each key in the valid maze dictionary
for mazeX, pathX in maze_dict.items():
    # write the maze dictionary key-value pair ending with a newline
    file.write(mazeX+":"+str(pathX)+"\n")
# close the maze.txt file
file.close()

print("Successfully created maze.txt with dictionary keys and values!")
