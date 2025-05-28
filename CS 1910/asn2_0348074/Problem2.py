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

    # FIND SOURCE COORDINATES
    sCoordinates = ""  # null string to be filled as "xy" for the x and y coordinates of the source cell

    # loop through each character to see if it is a digit
    for sourceCoord in mz.get_source():
        if sourceCoord.isdigit():
            # we know get_ source() will the string "source_x:a,source_y:b"
            # Therefore the first digit found will always be the x value and the second digit will always be the y value
            # when a digit is found it is added to the null string
            sCoordinates += sourceCoord

    # when printing we access the sting sCoordinates which is in the form "ab"
    # the 0th index being our "x" value and the 1st index being our "y" value
    print("The coordinates of the source cell are (" + sCoordinates[0] + "," + sCoordinates[1] + ").")

    # FIND DESTINATION COORDINATES
    dCoordinates = ""  # null string to be filled as "xy" for the x and y coordinates of the destination cell

    # loop through each character to see if it is a digit
    for destCoord in mz.get_destination():
        if destCoord.isdigit():
            # we know get_ destination() will the string "destin_x:a,destin_y:b"
            # Therefore the first digit found will always be the "x" value and the second digit will always be the "y" value
            # when a digit is found it is added to the null string
            dCoordinates += destCoord

    # when printing we access the sting dCoordinates which is in the form "ab"
    # the 0th index being our "x" value and the 1st index being our "y" value
    print("The coordinates of the destination cell are (" + dCoordinates[0] + "," + dCoordinates[1] + ").")

    # COUNT "G" IN SOURCE ROW
    row = ""  # empty string to be filled with a substring of maze that is the contents of a row
    rowNumber = 0  # the row number to compare to the "x" value of the source cell
    sourceRowCount = 0  # number of "G" found in the substring

    # loop through maze string and create substrings of each row
    # index begins at zero and increases by the size of the maze, n
    for index in range(0, len(maze), n):
        # create a substring from the maze string which is the contents of a row
        # the substring is from the index of the first cell in the row to the index of the last cell in the row
        row = maze[index:index+n]

        # if the "x" value of the source cell is equal to the row number we know the row substring is the row with the source cell in it
        if int(sCoordinates[0]) == rowNumber:
            # loop through each character in the row substring
            for cell in row:
                # once we find a G in the source row we add to the count
                if cell == "G":
                    sourceRowCount += 1
            # once row is found and counted break out of loop
            break
        # if the row substring is not the row the source cell is in increase the rowNumber by 1 before looping again
        else:
            rowNumber += 1

    print("Number of green cells in the source row:", sourceRowCount)

    # COUNT "R" IN DESTINATION COLUMN
    destColCount = 0  # number of "R" found in destination column

    # loop through all indices of the column for which the destination cell is located
    for col in range(int(dCoordinates[1]), len(maze), n):
        # if and only if the maze string at the value of a column index is "R" increase the count by 1
        if maze[col] == "R":
            destColCount += 1

    print("Number of red cells in the destination col:", destColCount)
