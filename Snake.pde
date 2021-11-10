class Snake //Probablemente tenga que ser sanke head, ya veremos
{   //probablemnete esto se pueda hacer con inheritance, miro despues que funcione
   // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
    int x,y;   // x,y location
    float size,   // width and height
          speed; // Speed at which the snake is moving

  int limitX, limitY;


  /*
    [0] = up
    [1] = down
    [2] = left
    [3] = right
  */
  boolean[] directions;

  // Cell Constructor
  Snake(float x, float y, float size, float speed) {
    this.x = (int)x;
    this.y = (int)y;
    this.size = size;
    this.speed = speed;

    directions = new boolean[4];
  }
  void setLimits(int cols, int rows) {
    limitX = cols - 1;
    limitY = rows - 1;
    if (x == -1 || x >= limitX + 1 || y == -1 || y >= limitX + 1)
    {
      speed = 0;
    }
  } 

  //Esto hay que adaptarlo para que sean los cuadritos los que cambien en la matriz
  void moveHead() {
     //<>//
    //while (speed != 0) {
   
      float dx = directions[2] ? -speed : (directions[3] ? speed : 0), //<>// //<>//
          dy = directions[0] ? -speed : (directions[1] ? speed : 0 );
        
      
      speed = (dx == 0 && dy == 0) ? 0 : speed;

      x += dx;
      y += dy;

      // x = Math.min(Math.max(x, 0), limitX);
      // y = Math.min(Math.max(y, 0), limitY);
    //}
 //<>//
  }
    //intento de hacerlo quitando y poniendo

//   Snake moveHead() {
//     float dx = directions[2] ? -speed : (directions[3] ? speed : 0), //<>//
//         dy = directions[0] ? -speed : (directions[1] ? speed : 0 );

//     // x += dx;
//     // y += dy;
//     float newX = (float)x + dx,
//     newY = (float)y + dy;   

    
//     // newX = Math.min(Math.max(newX, 0), limitX);
//     // newY = Math.min(Math.max(newY, 0), limitY);

//     return new Snake(newX, newY, size, speed);
//   }


void display() 
    {
        stroke(255);
        fill(255);
        rect(x,y,size, size);
    }

}
