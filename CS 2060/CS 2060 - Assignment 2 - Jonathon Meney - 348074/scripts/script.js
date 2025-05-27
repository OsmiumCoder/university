// PAGE EVENT LISTENERS
window.onload = makeBoard;
window.onkeydown = makeMove;

// GLOBALS
var size;
var board;
var currentRow;
var currentCol;
var penDown;

/**
 * Initializes and displays a new board.
 */
function makeBoard() {
    // for new board
    // start pen up at (0, 0)
    penDown = false;
    currentRow = 0;
    currentCol = 0;

    // find the table to fill with the board 
    // and clear old board
    var table = document.getElementById("boardTable");
    table.innerHTML = "";

    // get size from radio group, 50 default
    size = getSize();
    // array for storing drawn to positions
    board = new Array(size);

    for (let row = 0; row < size; row++) {
        // board becomes 2D Array
        board[row] = new Array(size);

        // insert a new row into the table
        var tableRow = table.insertRow();

        for (let col = 0; col < size; col++) {
            // insert new cell into newest row
            var tableCell = tableRow.insertCell();

            // cell ids of the form "rowXcolX"
            tableCell.setAttribute("id", "row" + row + "col" + col);

            // "?" character is a location not drawn on
            tableCell.innerHTML = "?"
            
            // update board array with all locations that have not been drawn on
            board[row][col] = "?";
        }
    }

    // set turtle at (0, 0)
    // turtle is "@" character
    document.getElementById("row0col0").innerHTML = "@";
}

/**
 * On key press moves the turtle if valid key is pressed and move is in bounds. 
 */
function makeMove() {
    var key = window.event.key;
    var turtle = "@"

    // determines if the pen is up or down and what to draw in either case
    // if the pen is up it will draw whatever is in the cell we are moving from "?" or "*"
    var symbolToDraw = penDown ? "*" : board[currentRow][currentCol];

    // current table cell of the turtle
    var current = getNextCell();

    switch (key) {
        // move up
        case "w":
        case "W":
            if (currentRow > 0) {
                current.innerHTML = symbolToDraw;
                board[currentRow][currentCol] = symbolToDraw;
                currentRow--;
            }
            break;

        // move down
        case "s":
        case "S":
            if (currentRow < size-1) {
                current.innerHTML = symbolToDraw;
                board[currentRow][currentCol] = symbolToDraw;
                currentRow++;
            }
            break;

        // move left
        case "a":
        case "A":
            if (currentCol > 0) {
                current.innerHTML = symbolToDraw;
                board[currentRow][currentCol] = symbolToDraw;
                currentCol--;
            }
            break;

        // move right
        case "d":
        case "D":
            if (currentCol < size-1) {
                current.innerHTML = symbolToDraw;
                board[currentRow][currentCol] = symbolToDraw;
                currentCol++;
            }
            break;

        // toggle pen up or down
        case "p":
        case "P":
            penDown = !penDown;
            break;

        // invalid button press
        default:
            break;
    }
    
    // update new current cell with the turtle character
    getNextCell().innerHTML = turtle;
    
    // auto scroll when turtle moves up and down past the screen if scrollable
    getNextCell().scrollIntoView({block: 'center'});
    
}

/**
 * Returns the table cell element of the board where the turtle currently is.
 * 
 * @returns the <td> cell element where the turtle currently exists
 */
function getNextCell() {
    return document.getElementById("row" + currentRow + "col" + currentCol)
}

/**
 * Returns the size of the board to be drawn. Defaults to 50 if none are selected.
 * 
 * @returns the selected size in the radio group form for the size of the board
 */
function getSize() {
    var radioGroup = document.getElementsByName("boardSize");

    for (let i = 0; i < radioGroup.length; i++) {
        var current = radioGroup[i];
        if (current.checked) {
            switch (current.value) {
                case "20":
                    return 20;
                    
                case "35":
                    return 35;
                
                case "50":
                    return 50;
                
                case "100":
                    return 100;
            }
        }
    }
    return 50;
}