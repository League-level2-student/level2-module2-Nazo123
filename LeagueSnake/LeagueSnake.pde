//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

  //Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;


  // Add a constructor with parameters to initialize each variable.

   Segment(int xe, int ye) {

    x = xe;
    y = ye;
 
  }
}




//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int foodX;
int foodY;
int direction = DOWN;
int score = 0 ;
ArrayList<Segment> tail = new ArrayList<Segment>();




//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
  head = new Segment(((int)random(50)*10), ((int)random(50)*10));
  frameRate(20);
  dropFood();
}

void dropFood() {
  //Set the food in a new random location
  foodX = ((int)random(50)*10);
  foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0, 0, 0);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(200, 5, 5);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(0, 255, 0);
  manageTail();
  rect(head.x, head.y, 10, 10);
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail
for(int i=0; i < tail.size();i++){
  rect(tail.get(i).x,tail.get(i).y,10,10);
}
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
checkTailCollision();
drawTail();
tail.add(new Segment(head.x,head.y));
tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment

for (int i = 0; i<tail.size();i++){
 
  if(head.x==tail.get(i).x&head.y==tail.get(i).y){
   tail.clear();
   break; 
  }
  
}

}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == CODED) {
    if (direction == LEFT) {
      if (keyCode == UP) {
        direction = UP;
      } else if (keyCode == DOWN){
        direction = DOWN;
      }
    } else if (direction==UP) {

      if (keyCode==RIGHT) {
        direction=RIGHT;
      } else if(keyCode == LEFT){
        direction=LEFT;
      }
    } else if (direction==RIGHT) {

      if (keyCode==UP) {
        direction=UP;
      } else if(keyCode == DOWN){
        direction=DOWN;
      }
    } else {
      if (keyCode==RIGHT) {
        direction=RIGHT;
      } else if (keyCode == LEFT){
        direction=LEFT;
      }
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.


  switch(direction) {
  case UP:
    // move head up here 
    head.y -=10;
    break;
  case DOWN:
    // move head down here 
    head.y +=10;
    break;
  case LEFT:
    // figure it out 
    head.x -=10;
    break;
  case RIGHT:
    // mystery code goes here 
    head.x +=10;
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
  //If the snake leaves the frame, make it reappear on the other side

  if (head.x>=500&direction==RIGHT) {
    head.x=-10;
  }
  if (head.y>=500&direction==DOWN) {
    head.y=-10;
  }
   if (head.x<=-10&direction==LEFT) {
    head.x=500;
  }
  if (head.y<=-10&direction==UP) {
    head.y=500;
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if (foodX==head.x&foodY==head.y) {
    score++;
    dropFood();
     tail.add(new Segment(head.x,head.y));
  }
}
