#include<stdio.h>
#define MAX 50

// ISSUES
// Issue 1: The Command Array is not implemented. A command is executed as soon as its entered.
//			Fix implements array and a while loop to walk through it and execute commands after 9 has been entered.

// Issue 2: If a move walks off the list the move simply won't be made, instead it should stop at the wall.
//			Fix uses the properties of OR in if statements and the fact that an assignment is always true.

// Comments beginning with NEW are fixes to these issues

int position_row, position_column, direction, penDown, walk;

int is_valid_command(int command){
	if(command > 0 && command <= 9) 
		return 1;
	return 0;
}

void printFloor(int floor[][MAX]){
	for(int i =0; i<MAX; i++){
		for(int j= 0; j<MAX; j++){
		if(floor[i][j] == 1) printf("*");
		else printf(" ");
		}
		printf("\n");
	}
}


void execute_command(int command, int floor[][MAX]){
	
	if(!walk){
		
		if(command == 1){
				penDown = 1;
			}
		else if(command == 2){
				penDown = 0;
			}
		else if(command == 3){
			if(direction > 1) direction--;
				else direction = 4;
			}
		else if(command == 4){
			if(direction < 4) direction++;
			else direction = 1;
				
			}
		else if(command == 6){
				printFloor(floor);
			}
	}
	
	else {
		
		if(direction == 1){
			// NEW: added (command = MAX - position_column - 1)
			if(position_column + command < MAX || (command = MAX - position_column - 1)){
				for(int i = 0; i<= command; i++){
					if(penDown) floor[position_row][position_column + i] = 1;
				}
				position_column += command;
			}
			
		}
		else if(direction == 2){
			// NEW: added (command = MAX - position_row - 1)
			if(position_row + command < MAX || (command = MAX - position_row - 1)){
				for(int i = 0; i<= command; i++){
					if(penDown) floor[position_row + i][position_column] = 1;
				}
				position_row += command;
			}
			
		}
		else if(direction == 3){
			// NEW: added (command = position_column)
			if(position_column - command >= 0 || (command = position_column)){
				for(int i = 0; i<= command; i++){
					if(penDown) floor[position_row][position_column - i] = 1;
				}
				position_column -= command;
			}
			
		}
		else{
			// NEW: added (command = position_row)
			if(position_row - command >= 0 || (command = position_row)){
				for(int i = 0; i<= command; i++){
					if(penDown) floor[position_row-i][position_column] = 1;
				}
				position_row -= command;
			}
			
		}
		
	}

}

// NEW: command array and index counter
int commands[1000] = {0};
int i = 0; // NEW: index to at store in commands array

int main()
{
	int rows, columns;
	int floor[MAX][MAX];
	//direction: 1-> right, 2-> down, 3-> left, 4->up
	int command, command1;
	position_row = 0;
	position_column = 0;
	direction = 1;
	penDown = 0;
	walk = 0;
	//Initialize floor with zeros   
	for (rows = 0; rows < MAX; rows++)
		 for (columns = 0; columns < MAX; columns++)
			 floor[rows][columns] = 0;
	 
	 //Keeps on running until command 9 is entered
	 do{
		 scanf("%d", &command);
		 if(is_valid_command(command)) // NEW: check if command is valid before adding to array
		 {
			commands[i] = command; // NEW: add command to array
			i++; // NEW: increase index counter
		 }
		 
		  if (command == 5)
			  {
			  scanf(",%d", &command1);
			  // NEW: Removed old walk toggle
			  // walk = 1;
			  commands[i] = command1; // NEW: add command1 to array
			  i++; // NEW: increase index counter
			  }
		// NEW: remove old walk toggle
		//   else{
		// 	  walk = 0;
		//   }

		// NEW: remove command execution, supposed to only execute after command 9
		// if(is_valid_command(command) && walk)
		// 	execute_command(command1,floor);
		// else if(is_valid_command(command)&& !walk)
		// 	execute_command(command,floor);
	 }
	 while(command != 9);

	 // NEW: all that follows
	 // execute commands
	 i = 0;
	 while (commands[i] != 9)
	 {
		if (commands[i] == 5)
		{
			i++;
			walk = 1;
		}
		else
		{
			walk = 0;
		}

		execute_command(commands[i],floor);
		i++;
	 }
	 
	 
	 return 0;
  
}