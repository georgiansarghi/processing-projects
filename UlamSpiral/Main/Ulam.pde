class Ulam { //<>//
  public float cellSize;
  public float gridSize;

  float row, col;

  boolean firstSide;
  int sideLenght;
  int sidePosition;
  int direction;
  int currentNumber;


  public Ulam(float gs) {
    cellSize = width/gs;
    gridSize = gs;

    direction = 0;
    currentNumber = 1;
    sidePosition = 1;
    sideLenght = 2;
    firstSide = true;

    col = int(gs/2) * cellSize;
    row = int(gs/2) * cellSize;
  }


  public void generate() {
    if (sidePosition < sideLenght) {
      currentNumber++;
      sidePosition++;
    } else {
      currentNumber++;
      sidePosition = 2;
      direction = (direction + 1) % 4;
      firstSide = !firstSide;
      if (firstSide) {
        sideLenght++;
      }
    }

    move();
  }



  public void  move() {
    if (direction == 0) {
      row += cellSize;
    } else if (direction == 1) {
      col += cellSize;
    } else if (direction == 2) {
      row -= cellSize;
    } else if (direction == 3) {
      col -= cellSize;
    }
  }



  public void display() {
    if (isPrime(currentNumber)) {
      fill(0);
    } else {
      fill(255);
    }

    rect(row, col, cellSize, cellSize);
  }



  public boolean end() {
    return currentNumber > (gridSize*gridSize);
  }


  public boolean isPrime(int n) {
    if (n <= 1)
      return false;
    else if (n <= 3)
      return true;
    else if (n % 2 == 0 || n % 3 == 0)
      return false;


    for (int i = 5; i*i <= n; i += 6) {
      if ( n % i == 0 || n % (i + 2) == 0)
        return false;
      i = i + 6;
    }

    return true;
  }
}