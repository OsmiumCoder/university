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

    # return the ordered pairs of the source and destination cells
    return "(" + source_x + "," + source_y + ")and(" + dest_x + "," + dest_y + ")"


coordinates = process_strings()  # assign the returned string from process_strings()
print("Extracted coordinates: " + coordinates)  # print the extracted coordinates
