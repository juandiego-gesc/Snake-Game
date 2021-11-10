class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y,   // location
        size;   // width and height

  float limitX, limitY;

  boolean on = false;
  boolean coin = false;

  // Cell Constructor
  Cell(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() 
  {
    stroke(0);
    //fill(255);
    rect(x,y,size, size);
  }
}
