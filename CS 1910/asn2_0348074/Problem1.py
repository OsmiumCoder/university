# import the maze file renamed to mz
import maze as mz

maze = ""  # null string for which the maze string returned by create_maze

# get the value of n for the size of the maze
n = int(input("Enter the value of n to create a n x n maze: "))

# check if maze is too big or too small
if n <= 0 or n > 9:
    print("Invalid value")
elif n == 1:
    print("Source and destination cells are the same")
elif n == 2:
    print("Destination is reachable from the source")
else:
    # set maze to the returned string from create_maze
    maze = mz.create_maze(n)
    # print the maze to the console
    mz.print_maze(maze)
    # count the number of G's and number of R's in the maze string using count built-in
    print("There are", maze.count("G"), "green cells and", maze.count("R"), "red cells.")
