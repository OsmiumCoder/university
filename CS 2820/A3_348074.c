#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// ISSUES
// Issue 1: printCurrentPositions is prototyped without pointers as the parameters, 
//          but its declared with pointers as the parameters.
//          Fix makes declaration not use pointers, as the positions aren't being changed simply used to print the positions.

// Issue 2: moveHare and moveTortoise are being passed the current positions by value. Therefore,
//          they do not get modified in the main() scope.
//          Fix changes the position parameters to be pointers and thus the positions are passed by reference.

// Issue 3: when the turtle or hare slips and they would fall to a negative position they are reset to 0 and not 1.
//          Fix changes the slips to reset to 1 instead.


void moveHare(int hr, int* hPos); // NEW: changed int hPos to int* hPos
void moveTortoise(int tr, int* tPos); // NEW: changed int tPos to int* tPos
void printCurrentPositions(const int harePos, const int tortPos);

int main(void) {
  int harePos = 1;    //initialize all variables
  int tortPos = 1;
  int hareRand, tortRand;
  int turns = 1;
  puts("BANG !!!!!");
  puts("AND THEY'RE OFF !!!!!");
  srand(time(NULL));
  while(harePos<70&&tortPos<70&&turns<100){   //Execute the race
    hareRand = (rand()%10)+1;   //Get number for random actions
    tortRand = (rand()%10)+1;

    // NEW: added & to pass address
    moveTortoise(tortRand, &tortPos);
    moveHare(hareRand, &harePos);
    printCurrentPositions(harePos, tortPos);

    turns++;
  }
  if(tortPos>=70&&harePos>=70){   //Display final message based on result
    puts("IT WAS A TIE!!");
  }
  else if(tortPos>=70){
    puts("TORTIOSE WINS!!! YAY!!!");
  }
  else if(harePos>=70){
    puts("Hare wins. Yuch.");
  }
  else{
    puts("Turns maximum reached.");
  }
}

// NEW: added * to all refrences of tPos to update position
void moveTortoise(const int tr, int* tPos){
  switch(tr){
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
      *tPos+=3;
      break;
    case 6:
    case 7:
      if(*tPos<=6){
        *tPos=1; // NEW: changed to 1 from 0
      }
      else{
        *tPos-=6;
      }
      break;
    case 8:
    case 9:
    case 10:
      *tPos+=1;
      break;
  }
}

// NEW: added * to all refrences of hPos to update position
void moveHare(const int hr, int *hPos){
  switch(hr){
    case 1:
    case 2:
      break;
    case 3:
    case 4:
      *hPos+=9;
      break;
    case 5:
      if(*hPos<=12){
        *hPos=1; // NEW: changed from 0 to 1
      }
      else{
        *hPos-=12;
      }
      break;
    case 6:
    case 7:
    case 8:
      *hPos+=1;
      break;
    case 9:
    case 10:
      if(*hPos<=2){
        *hPos=1; // NEW: changed from 0 to 1
      }
      else{
        *hPos-=2;
      }
      break;
  }
}

// NEW: removed * from parameters as they don't need to be pointers/pass by reference
void printCurrentPositions(const int harePos, const int tortPos){
  //Consider all cases for formatting - neither finished(check order), both finished, one finished
  if(harePos>=70&&tortPos>=70){ //Both finished
    for(int i=0;i<70;i++){
      printf(" ");
    }
    printf("|OUCH!!!\n");
  }
  else if(harePos<70&&tortPos<70){  //Neither finished
    if(harePos>tortPos){  //Hare is ahead
      for(int i=0;i<tortPos;i++){
        printf(" ");
      }
      printf("T");
      for(int j=tortPos+1;j<harePos;j++){
        printf(" ");
      }
      printf("H");
      for(int k=harePos+1;k<70;k++){
        printf(" ");
      }
      printf("|\n");
    }
    else if(tortPos>harePos){   //Tortiose is ahead
      for(int i=0;i<harePos;i++){
        printf(" ");
      }
      printf("H");
      for(int j=harePos+1;j<tortPos;j++){
        printf(" ");
      }
      printf("T");
      for(int k=tortPos+1;k<70;k++){
        printf(" ");
      }
      printf("|\n");
    }
    else{ //Tied
      for(int i=0;i<tortPos;i++){
        printf(" ");
      }
      printf("OUCH!!!");
      for(int j=tortPos+7;j<70;j++){
        printf(" ");
      }
      printf("|\n");
    }
  }
  else if(harePos>=70&&tortPos<70){ //Hare is finished
    for(int i=0;i<tortPos;i++){
      printf(" ");
    }
    printf("T");
    for(int j=tortPos+1;j<70;j++){
      printf(" ");
    }
    printf("|H\n");
  }
  else if(tortPos>=70&&harePos<70){ //Tortoise is finished
    for(int i=0;i<harePos;i++){
      printf(" ");
    }
    printf("H");
    for(int j=harePos+1;j<70;j++){
      printf(" ");
    }
    printf("|T\n");
  }
}
