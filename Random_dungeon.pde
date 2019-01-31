//Made by Ian Martin, August 2018

//Global cellSize
int cellSize = 10;
//array of all cells.
ArrayList<Cell> cells = new ArrayList<Cell>();
ArrayList<Cell> toDraw = new ArrayList<Cell>();
int rows, cols, num = 0;

void setup()
{
  size(610, 610);
  rows = height/cellSize;
  cols = width/cellSize;
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      Cell C = new Cell(i, j);
      cells.add(C);
    }
  }
  build_dungeon(100, 0.99, 0.2);
  background(0);
}

void mousePressed()
{
  toDraw.clear();
  for(int i =0; i < cells.size(); i++)
  {
   cells.get(i).alive = false; 
  }
  build_dungeon(100, 0.99, 0.2);
  background(0);
  num = 0;
}

void draw()
{
  if(num >= toDraw.size() + 60)
  {
    mousePressed();
  }
  toDraw.get(num%toDraw.size()).show();
  num++;
}


void build_dungeon(int starting_chance, float bias_percentage, float bias)
{
  //Priority queue
  CellQueue queue = new CellQueue();
  //Visited array
  ArrayList<Cell> visited = new ArrayList<Cell>();
  //grab the middle cell
  Cell C = cells.get(index(rows/2, cols/2));
  //set it's alive to true, and input starting chances. 
  C.alive = true;
  C.chances = starting_chance;
  //No direction Bias.
  C.direction_bias = -1;
  //Now add it to the queue.
  queue.push(C, C.chances);

  while (queue.empty() == false)
  {
    //Grab a cell
    Cell cell = queue.pop();
    //if it hasn't been visited...
    boolean all_good = true;
    for (int i = 0; i < visited.size(); i++)
    {
      if (visited.get(i) == cell)
      {
        all_good = false;
        i = visited.size();
      }
    }
    
    if (all_good)
    {
      //show the cell and mark it as visited
      cell.alive = true;
      //cell.show();
      toDraw.add(cell);
      visited.add(cell);
      int[] dirs = new int[4];
      int strong = floor(cell.chances * bias_percentage);
      int weak = floor(cell.chances * bias_percentage * bias);
      //check the direction bias.
      switch(cell.direction_bias)
      {
      case 0:
        //Bias towards upward
        dirs[0] = strong;
        dirs[1] = weak;
        dirs[2] = 0; //no need to check backwards
        dirs[3] = weak;
        break;
      case 1:
        //Bias towards left
        dirs[0] = weak;
        dirs[1] = strong;
        dirs[2] = weak;
        dirs[3] = 0; //no need to check backwards
        break;
      case 2:
        //Bias towards down
        dirs[0] = 0; //no need to check backwards
        dirs[1] = weak;
        dirs[2] = strong;
        dirs[3] = weak;
        break;
      case 3:
        //Bias towards right
        dirs[0] = weak;
        dirs[1] = 0; //no need to check backwards
        dirs[2] = weak;
        dirs[3] = strong;
        break;
      default:
        //No bias
        dirs[0] = strong;
        dirs[1] = strong;
        dirs[2] = strong;
        dirs[3] = strong;
        break;
      }
      //Biases have been set
      for (int i = 0; i < 4; i++)
      {
        if (floor(random(0, 100)) < dirs[i])
        {
          //success, add it to the queue
          switch(i)
          {
          case 0:
            if(index(floor(cell.indexes.x), floor(cell.indexes.y-1)) > -1)
            {
             queue.push(cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y-1))), dirs[i]);
             cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y-1))).direction_bias = 0;
             cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y-1))).chances = strong;
            }
            break;
          case 1:
            if(index(floor(cell.indexes.x-1), floor(cell.indexes.y)) > -1)
            {
             queue.push(cells.get(index(floor(cell.indexes.x-1), floor(cell.indexes.y))), dirs[i]);
             cells.get(index(floor(cell.indexes.x-1), floor(cell.indexes.y))).direction_bias = 1;
             cells.get(index(floor(cell.indexes.x-1), floor(cell.indexes.y))).chances = strong; 
            }
            break;
          case 2:
            if(index(floor(cell.indexes.x), floor(cell.indexes.y+1)) > -1)
            {
             queue.push(cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y+1))), dirs[i]); 
             cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y+1))).direction_bias = 2;
             cells.get(index(floor(cell.indexes.x), floor(cell.indexes.y+1))).chances = strong;
            }
            break;
          case 3:
            if(index(floor(cell.indexes.x+1), floor(cell.indexes.y)) > -1)
            {
             queue.push(cells.get(index(floor(cell.indexes.x+1), floor(cell.indexes.y))), dirs[i]);
             cells.get(index(floor(cell.indexes.x+1), floor(cell.indexes.y))).direction_bias = 3; 
             cells.get(index(floor(cell.indexes.x+1), floor(cell.indexes.y))).chances = strong;
            }
            break;
          }
        }
      }
    }
  }
}

int index(int x, int y)
{
  if (x < 0 || x > cols-1 || y < 0 || y > rows-1 || x*(width/cellSize) + y > cells.size()-1)
  {
    return -1;
  }
  return x*(width/cellSize) + y;
}
