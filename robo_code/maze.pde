class maze
{
  boolean grid[][] = {
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, 
    {false, false, false, false, false, false, false, false}, };
  int x, y, dir, gridWidth = grid.length, gridHeight = grid[0].length;
  int checkDirection = -1; 
  boolean checkResualt;
  int finsihX = 3, finishY = 7;
  int gridSize = 40;

  maze()
  {
    reset();
  }

  void reset()
  {
    this.x = 3;
    this.y = 0;
    this.dir = 0;
    this.checkDirection = -1;
    this.checkResualt = false;
  }

  void loadMaze(String filename)
  {
    BufferedReader reader = createReader(filename);
    String line = null;
    int j = gridHeight -1 ;
    try 
    {
      while ((line = reader.readLine()) != null && j >= 0) 
      {
        for (int i = 0; i < gridWidth; ++i)
        {
          if (line.charAt(i) == '#') grid[i][j] = true;
          else grid[i][j] = false;
        }
        --j;
      }
      reader.close();
    }
    catch (IOException e) 
    {
      e.printStackTrace();
    }
  }
  
  void _draw()
  {
    background(128);
    drawGrid();
    drawRobot();
  }

  void drawGrid()
  {
    for (int i = 0; i < grid.length; ++i)
    {
      for (int j = 0; j < grid[i].length; ++j)
      {
        if (grid[i][j]) fill(128);
        else fill(10);
        rect(i * gridSize + 40, (gridHeight - 1 - j) * gridSize + 40, gridSize, gridSize);
      }
    }
    fill(0, 0, 255);
    rect(gridSize * 4 + 5, gridSize + 5, gridSize-10, gridSize-10);
  }

  void drawRobot()
  {
    fill(200, 210, 220);
    rect(x * gridSize + 45, (gridHeight - 1 - y) * gridSize + 45, 30, 30);

    fill(0, 0, 0);
    drawBarInDirection(dir);
    drawBarInDirection((dir + 1) % 4);
    drawBarInDirection((dir + 3) % 4);

    if (checkDirection >= 0)
    {
      if (!checkResualt) fill(0, 255, 0);
      else             fill(255, 0, 0);
      drawBarInDirection(checkDirection);
    }
  }

  void drawBarInDirection(int direction)
  {
    switch(direction)
    {
    case 0: 
      rect(x * gridSize + 40 + 10, (gridHeight - 1 - y) * gridSize + 40 + 10, 20, 5);
      break;
    case 1: 
      rect(x * gridSize + 40 + 25, (gridHeight - 1 - y) * gridSize + 40 + 10, 5, 20);
      break;
    case 2: 
      rect(x * gridSize + 40 + 10, (gridHeight - 1 - y) * gridSize + 40 + 25, 20, 5);
      break;
    case 3: 
      rect(x * gridSize + 40 + 10, (gridHeight - 1 - y) * gridSize + 40 + 10, 5, 20);
      break;
    }
  }

  boolean moveForward()
  {
    checkDirection = -1;
    if (blockInDirection(dir)) return false;
    switch(dir)
    {
    case 0: 
      ++y;
      break;
    case 1: 
      ++x; 
      break;
    case 2: 
      --y; 
      break;
    case 3: 
      --x; 
      break;
    }
    return (y == 7 && x == 3);
  }

  boolean safeMazeLookup(int xpos, int ypos)
  {
    if (xpos >= 0 && ypos >= 0 && xpos < gridWidth && ypos < gridHeight)
    {
      return grid[xpos][ypos];
    }
    return true;
  }

  void turnRight()
  {
    checkDirection = -1;
    dir = (dir + 1) % 4;
  }

  void turnLeft()
  {
    checkDirection = -1;
    dir = (dir + 3) % 4;
  }

  boolean blockInDirection(int direction)
  {
    //if(direction == 0 && y == 7 && x == 3)return false;
    switch(direction)
    {
    case 0: 
      return safeMazeLookup(x, y+1); 
    case 1: 
      return safeMazeLookup(x+1, y); 
    case 2: 
      return safeMazeLookup(x, y-1); 
    case 3: 
      return safeMazeLookup(x-1, y);
    }
    return true;
  }

  boolean blockInFront()
  {
    checkDirection = dir;
    checkResualt = blockInDirection(checkDirection);
    return checkResualt;
  }

  boolean blockOnRight()
  {
    checkDirection = ((dir+1) % 4);
    checkResualt = blockInDirection(checkDirection);
    return checkResualt;
  }

  boolean blockOnLeft()
  {
    checkDirection = ((dir+3) % 4);
    checkResualt = blockInDirection(checkDirection);
    return checkResualt;
  }
}
