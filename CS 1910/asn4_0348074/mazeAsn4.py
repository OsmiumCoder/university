import random
from itertools import chain
import math
import numpy as np
import colorama
from colorama import init, Fore

init()  # colorama needs to be initialized in order to be used


# this function prints the maze
def print_maze(maze):
    ln = len(maze)
    lnn = int(math.sqrt(ln))
    print('A ',lnn,' x ',lnn,' maze created by the maze module is given below:')
    for index in range(0, ln):
        if index > 0 and index % lnn == 0:
            print("\n")
        element = maze[index]
        if element == 'Y':
            print(Fore.YELLOW, f'{element}', end="")
        elif element == 'G':
            print(Fore.GREEN, f'{element}', end="")
        else:
            print(Fore.RED, f'{element}', end="")
    colorama.init(autoreset=True)
    print("")

# This function finds the number of neighboring accessible cells
def find_neighbors(maze, cell_info):
    fn = 0
    if (maze[cell_info[0] - 1][cell_info[1]] == 'G'):
        fn += 1
    if (maze[cell_info[0] + 1][cell_info[1]] == 'G'):
        fn += 1
    if (maze[cell_info[0]][cell_info[1] - 1] == 'G'):
        fn += 1
    if (maze[cell_info[0]][cell_info[1] + 1] == 'G'):
        fn += 1
    return fn


# this function creates a maze of size, size x size using Prim's algorithm
def create_maze(problem_num):
    if problem_num == 0:
        size = int(input("Enter the value of n to create a n x n maze: "))
        while size <= 2:
            size = int(input("Please enter another value that is greater than 2: "))
    elif problem_num == 1:
        size = int(random.random() * 8)+3
    else:
        print("Error state in create_maze: Rerun code with a valid value or 0 or 1")
        exit()

    accessible_cell = 'G'  # green cell
    blocked_cell = 'R'  # red cell
    null_cell = 'Y'  # yellow cell
    # create a maze with null cells
    maze = []
    for i in range(0, size):
        line = []
        for j in range(0, size):
            line.append(null_cell)
        maze.append(line)
    # randomly pick a cell and make it accessible
    # make sure that the random cell is not on the edge
    start_row = int(random.random() * size)
    start_col = int(random.random() * size)
    if start_row == 0:
        start_row += 1
    if start_row == size - 1:
        start_row -= 1
    if start_col == 0:
        start_col += 1
    if start_col == size - 1:
        start_col -= 1
    maze[start_row][start_col] = accessible_cell
    # add the neighboring cells of the accessible_cell to the list
    # update the neighboring cells status to blocked
    blocks = []
    blocks.append([start_row - 1, start_col])
    blocks.append([start_row, start_col - 1])
    blocks.append([start_row, start_col + 1])
    blocks.append([start_row + 1, start_col])
    maze[start_row - 1][start_col] = blocked_cell
    maze[start_row][start_col - 1] = blocked_cell
    maze[start_row][start_col + 1] = blocked_cell
    maze[start_row + 1][start_col] = blocked_cell
    # repeat till list is not empty
    while (blocks):
        random_block = blocks[int(random.random() * len(blocks)) - 1]
        if (random_block[1] != 0):
            if (maze[random_block[0]][random_block[1] - 1] == null_cell and maze[random_block[0]][
                random_block[1] + 1] == accessible_cell):
                fns = find_neighbors(maze, random_block)

                if (fns < 2):
                    # Denote the new path
                    maze[random_block[0]][random_block[1]] = accessible_cell

                    # Mark the new blocks
                    # Upper cell
                    if (random_block[0] != 0):
                        if (maze[random_block[0] - 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] - 1][random_block[1]] = blocked_cell
                        if ([random_block[0] - 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] - 1, random_block[1]])

                    # Bottom cell
                    if (random_block[0] != size - 1):
                        if (maze[random_block[0] + 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] + 1][random_block[1]] = blocked_cell
                        if ([random_block[0] + 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] + 1, random_block[1]])

                    # Leftmost cell
                    if (random_block[1] != 0):
                        if (maze[random_block[0]][random_block[1] - 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] - 1] = blocked_cell
                        if ([random_block[0], random_block[1] - 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] - 1])

                # Delete block
                for block in blocks:
                    if (block[0] == random_block[0] and block[1] == random_block[1]):
                        blocks.remove(block)

                continue

        # Check if it is an upper block
        if (random_block[0] != 0):
            if (maze[random_block[0] - 1][random_block[1]] == null_cell and maze[random_block[0] + 1][
                random_block[1]] == accessible_cell):

                fns = find_neighbors(maze, random_block)
                if (fns < 2):
                    # Denote the new path
                    maze[random_block[0]][random_block[1]] = accessible_cell

                    # Mark the new blocks
                    # Upper cell
                    if (random_block[0] != 0):
                        if (maze[random_block[0] - 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] - 1][random_block[1]] = blocked_cell
                        if ([random_block[0] - 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] - 1, random_block[1]])

                    # Leftmost cell
                    if (random_block[1] != 0):
                        if (maze[random_block[0]][random_block[1] - 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] - 1] = blocked_cell
                        if ([random_block[0], random_block[1] - 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] - 1])

                    # Rightmost cell
                    if (random_block[1] != size - 1):
                        if (maze[random_block[0]][random_block[1] + 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] + 1] = blocked_cell
                        if ([random_block[0], random_block[1] + 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] + 1])

                # Delete block
                for block in blocks:
                    if (block[0] == random_block[0] and block[1] == random_block[1]):
                        blocks.remove(block)

                continue

        # Check the bottom block
        if (random_block[0] != size - 1):
            if (maze[random_block[0] + 1][random_block[1]] == null_cell and maze[random_block[0] - 1][
                random_block[1]] == accessible_cell):

                fns = find_neighbors(maze, random_block)
                if (fns < 2):
                    # Denote the new path
                    maze[random_block[0]][random_block[1]] = accessible_cell

                    # Mark the new blocks
                    if (random_block[0] != size - 1):
                        if (maze[random_block[0] + 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] + 1][random_block[1]] = blocked_cell
                        if ([random_block[0] + 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] + 1, random_block[1]])
                    if (random_block[1] != 0):
                        if (maze[random_block[0]][random_block[1] - 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] - 1] = blocked_cell
                        if ([random_block[0], random_block[1] - 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] - 1])
                    if (random_block[1] != size - 1):
                        if (maze[random_block[0]][random_block[1] + 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] + 1] = blocked_cell
                        if ([random_block[0], random_block[1] + 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] + 1])

                # Delete block
                for block in blocks:
                    if (block[0] == random_block[0] and block[1] == random_block[1]):
                        blocks.remove(block)

                continue

        # Check the right block
        if (random_block[1] != size - 1):
            if (maze[random_block[0]][random_block[1] + 1] == null_cell and maze[random_block[0]][
                random_block[1] - 1] == accessible_cell):

                fns = find_neighbors(maze, random_block)
                if (fns < 2):
                    # Denote the new path
                    maze[random_block[0]][random_block[1]] = accessible_cell

                    # Mark the new blocks
                    if (random_block[1] != size - 1):
                        if (maze[random_block[0]][random_block[1] + 1] != accessible_cell):
                            maze[random_block[0]][random_block[1] + 1] = blocked_cell
                        if ([random_block[0], random_block[1] + 1] not in blocks):
                            blocks.append([random_block[0], random_block[1] + 1])
                    if (random_block[0] != size - 1):
                        if (maze[random_block[0] + 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] + 1][random_block[1]] = blocked_cell
                        if ([random_block[0] + 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] + 1, random_block[1]])
                    if (random_block[0] != 0):
                        if (maze[random_block[0] - 1][random_block[1]] != accessible_cell):
                            maze[random_block[0] - 1][random_block[1]] = blocked_cell
                        if ([random_block[0] - 1, random_block[1]] not in blocks):
                            blocks.append([random_block[0] - 1, random_block[1]])

                # delete block
                for block in blocks:
                    if (block[0] == random_block[0] and block[1] == random_block[1]):
                        blocks.remove(block)

                continue

        # delete the block from the list
        for block in blocks:
            if (block[0] == random_block[0] and block[1] == random_block[1]):
                blocks.remove(block)

    # replace null cells with blocked cells on the edges
    for i in range(0, size):
        for j in range(0, size):
            if (maze[i][j] == null_cell):
                maze[i][j] = blocked_cell
    # create accessible_cell in the first row
    for i in range(0, size):
        if (maze[1][i] == accessible_cell):
            maze[0][i] = accessible_cell
            #global maze_source
            #maze_source = 'source_x:' + str(0) + ',' + 'source_y:' + str(i)
            break
    # create accessible_cell in the last row
    for i in range(size - 1, 0, -1):
        if (maze[size - 2][i] == accessible_cell):
            maze[size - 1][i] = accessible_cell
            #global maze_dest
            #maze_dest = 'destin_x:' + str(size - 1) + ',' + 'destin_y:' + str(i)
            break

    # transpose of generated maze (t-maze)
    mazeAry = np.array(maze)
    mazeT = mazeAry.T

    #create accessible cell in the first row of t-maze
    my_input = []
    count = 0
    for i in range(size):
        if mazeT[1][i] == accessible_cell:
            my_input.insert(count, i)
            count = count + 1
    rd = random.randint(0, count-1)
    mazeT[0][my_input[rd]] = accessible_cell
    #maze_source_row = 'source_x:' + str(0) + ',' + 'source_y:' + str(my_input[rd])
    maze_source_row = [['source_x:',0],['source_y:',my_input[rd]]]

    #create accessible cell in the last row of t-maze
    my_input = []
    count = 0
    for i in range(size):
        if mazeT[size-2][i] == accessible_cell:
            my_input.insert(count, i)
            count = count + 1
    rd = random.randint(0, count-1)
    mazeT[size-1][my_input[rd]] = accessible_cell
    #maze_dest_row = 'destin_x:' + str(size - 1) + ',' + 'destin_y:' + str(my_input[rd])
    maze_dest_row = [['destin_x:',size - 1],['destin_y:',my_input[rd]]]

    # create accessible cell in the first col of t-maze
    my_input = []
    count = 0
    for i in range(size):
        if mazeT[i][0] == accessible_cell:
            my_input.insert(count, i)
            count = count + 1
    rd = random.randint(0, count - 1)
    mazeT[my_input[rd]][0] = accessible_cell
    #maze_source_col = 'source_x:' + str(my_input[rd]) + ',' + 'source_y:' + str(0)
    maze_source_col = [['source_x:',my_input[rd]],['source_y:',0]]

    #create accessible cell in the last col of t-maze
    my_input = []
    count = 0
    for i in range(size):
        if mazeT[i][size-1] == accessible_cell:
            my_input.insert(count, i)
            count = count + 1
    rd = random.randint(0, count-1)
    mazeT[my_input[rd]][size-1] = accessible_cell
    #maze_dest_col = 'destin_x:' + str(my_input[rd]) + ',' + 'destin_y:' + str(size-1)
    maze_dest_col = [['destin_x:',my_input[rd]],['destin_y:',size - 1]]

    #set random source and destination
    rdd = random.randint(0, 10)
    global maze_source
    global maze_dest
    if rdd <= 7:
        maze_source = maze_source_row
        maze_dest = maze_dest_row
        # add a few more greens randomly
        for i in range(size):
            for j in range(size):
                rd = random.randint(0, 10)
                if rd <= 3:
                    mazeT[i][j] = accessible_cell

        #prioritize source from the first half
        for i in range(size//2):
            rd = random.randint(0, 10)
            if rd <= 8:
                mazeT[0][i] = accessible_cell
        my_input = []
        count = 0
        rd = random.randint(0, 10)
        if rd <= 8:
            for i in range(size//2):
                if mazeT[0][i] == accessible_cell:
                    my_input.insert(count, i)
                    count = count + 1
            if count == 0:
                rd = 0
                mazeT[0][0] == accessible_cell
                my_input.insert(count, 0)
            else:
                rd = random.randint(0, count - 1)
            #maze_source_row = 'source_x:' + str(0) + ',' + 'source_y:' + str(my_input[rd])
            maze_source_row = [['source_x:',0],['source_y:',my_input[rd]]]
            maze_source = maze_source_row
        #prioritize dest from the second half
        for i in range((size//2)+1, size):
            rd = random.randint(0, 10)
            if rd <= 8:
                mazeT[size-1][i] = accessible_cell
        my_input = []
        count = 0
        rd = random.randint(0, 10)
        if rd <= 8:
            for i in range((size // 2)+1, size):
                if mazeT[size-1][i] == accessible_cell:
                    my_input.insert(count, i)
                    count = count + 1
            if count == 0:
                rd = 0
                my_input.insert(count, size-1)
                mazeT[size-1][size-1] == accessible_cell
            else:
                rd = random.randint(0, count - 1)
            #rd = random.randint(0, count - 1)
            #maze_dest_row = 'destin_x:' + str(size - 1) + ',' + 'destin_y:' + str(my_input[rd])
            maze_dest_row = [['destin_x:',size - 1],['destin_y:',my_input[rd]]]
            maze_dest = maze_dest_row
    else:
        maze_source = maze_source_col
        maze_dest = maze_dest_col


    mazeLst = mazeT.tolist()
    lstS = list(chain.from_iterable(mazeLst))
    maze = ''.join(lstS)

    return maze


# function returns the source coordinates
def get_source():
    return maze_source


# function returns the destination coordinates
def get_destination():
    return maze_dest

def test_maze():
    sStr = [["source_x",0],["source_y",1]]
    dStr = [["destin_x",4],["destin_y",3]]
    return "GGGGRGGGGRGGGRGGGGGGRRRGR",sStr,dStr

