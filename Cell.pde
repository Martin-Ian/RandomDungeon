class Cell
{
  //This boolean sets the alive state on or off
  boolean alive = false;
  //This stores the maximum chance for any direction
  int chances;
  //this value (0-3) stores the direction that it's parent was
  int direction_bias;
  //this PVector stores the position
  PVector pos;
  //This PVector stores the indeces
  PVector indexes;

  //Basic constructor
  Cell(int x, int y)
  {
    indexes = new PVector(x, y);
    pos = new PVector(x*cellSize, y*cellSize);
  }

  //On draw function. if the cell is alive
  //it will be represented by a white square
  void show()
  {
    if (alive)
    {
      noStroke();
      fill(map(dist(pos.x, pos.y, width/2, height/2), 0, width/2, 255, 100));
      rect(pos.x, pos.y, cellSize, cellSize);
    }
  }
}
