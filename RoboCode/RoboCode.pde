//Level 0
void level0()
{
  exampleSolution();
}

//Level 1
void level1()
{
  exampleSolution();
}

//Level 2
void level2()
{
  exampleSolution();
}


























































void exampleSolution()
{
  while (true)
  {
    if (wallInFront())
    {
      if (wallOnRight())
      {
        turnLeft();
      } else
      {
        turnRight();
        moveForward();
      }
    } else
    {
      if (wallOnRight())
      {
        moveForward();
      } else
      {
        turnRight();
        moveForward();
      }
    }
  }
}

maze m = new maze();
int currentMove = 0, currentMaze = 0;
int[] moves = new int[1024];

void runMaze0()
{
  m.reset(); 
  resetMoves(); 
  currentMove = 0;
  m.loadMaze("maze0.txt"); 
  try {
    level0();
  }
  catch(Exception e) {
  }
  m.reset(); 
  currentMove = 0;
}

void runMaze1()
{
  resetMoves(); 
  m.reset(); 
  currentMove = 0;
  m.loadMaze("maze1.txt"); 
  try {
    level1();
  }
  catch(Exception e) {
  }
  m.reset(); 
  currentMove = 0;
}

void runMaze2()
{
  resetMoves(); 
  m.reset(); 
  currentMove = 0;
  m.loadMaze("maze2.txt"); 
  try {
    level2();
  }
  catch(Exception e) {
  }
  m.reset(); 
  currentMove = 0;
}

void resetMoves()
{
  for (int i = 0; i < moves.length; ++i)
    moves[i] = 0;
}

void moveForward()
{
  moves[currentMove++] = 1;
  if (m.moveForward()) moves[currentMove++] = 7;
}

void turnRight()
{
  moves[currentMove++] = 2;
  m.turnRight();
}

void turnLeft()
{
  moves[currentMove++] = 3;
  m.turnLeft();
}

boolean wallInFront()
{
  moves[currentMove++] = 4;
  return m.wallInFront();
}

boolean wallOnRight()
{
  moves[currentMove++] = 5;
  return m.wallOnRight();
}

boolean wallOnLeft()
{
  moves[currentMove++] = 6;
  return m.wallOnLeft();
}

void runMove(int move)
{
  switch(moves[move])
  {
  case 0:
    break;
  case 1:
    m.moveForward();
    break;
  case 2:
    m.turnRight();
    break;
  case 3:
    m.turnLeft();
    break;
  case 4:
    m.wallInFront();
    break;
  case 5:
    m.wallOnRight();
    break;
  case 6:
    m.wallOnLeft(); 
    break;
  default:
    break;
  }
}

void runNextMaze()
{
  switch(++currentMaze)
  {
  case 0: 
    runMaze0(); 
    break;
  case 1: 
    runMaze1(); 
    break;
  case 2: 
    runMaze2(); 
    break;
  default:
    gameState = 0;
    break;
  }
}

int gameState = 1;
void setup()
{
  size(400, 400);
  background(255);
  runMaze0();
}

int counter = 60;
void draw()
{ 
  switch(gameState)
  {
  case 0:
  background(0);
    break;
    
  case 1:
    m._draw();
    if (counter < 0)
    {
      if (currentMove >= 1024 || moves[currentMove] == 7 || moves[currentMove] == 0)
        runNextMaze();
      runMove(currentMove++);
      counter = 15;
    }
    --counter;
    break;
  }
}
