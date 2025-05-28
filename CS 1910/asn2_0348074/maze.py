import random
from itertools import chain
import math
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
def create_maze(size):
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
    # create source
    for i in range(0, size):
        if (maze[1][i] == accessible_cell):
            maze[0][i] = accessible_cell
            global maze_source
            maze_source = 'source_x:' + str(0) + ',' + 'source_y:' + str(i)
            break
    # create destination
    for i in range(size - 1, 0, -1):
        if (maze[size - 2][i] == accessible_cell):
            maze[size - 1][i] = accessible_cell
            global maze_dest
            maze_dest = 'destin_x:' + str(size - 1) + ',' + 'destin_y:' + str(i)
            break
    lst = list(chain.from_iterable(maze))
    maze = ''.join(lst)

    return maze


# function returns the source coordinates
def get_source():
    return maze_source


# function returns the destination coordinates
def get_destination():
    return maze_dest

