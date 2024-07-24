class CellularAutomata {

  int[] cells;
  int gen;

  int[] ruleset = {0, 0, 0, 1, 1, 1, 1, 0};

  int cellSize;

  CellularAutomata(int rn, int s, boolean rs) {
    ruleset = binaryRule(rn);
    cellSize = s;

    cells = new int[width/cellSize];

    if (randomState) {
      for (int i = 0; i < cells.length; i++) {
        cells[i] = (int)random(2);
      }
    } else {

      for (int i = 0; i < cells.length; i++) {
        cells[i] = 0;
      }
      cells[cells.length/2] = 1;
    }


    gen = 0;
  }


  void generate() {
    int[] nextgen = new int[cells.length];

    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int me = cells[i];
      int right = cells[i+1];
      nextgen[i] = rules(left, me, right);
    }

    cells = nextgen;
    gen++;
  }



  void display() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) {
        fill(255);
      } else {
        fill(0);
      }
      noStroke();
      rect(i*cellSize, gen*cellSize, cellSize, cellSize);
    }
  }



  int[] binaryRule(int n) {
    int[] br = new int[8];

    int index = 7;
    while (n != 0) {
      br[index] = n%2;
      n /= 2;
      index--;
    }

    return br;
  }



  int rules (int a, int b, int c) {
    return ruleset[7 - (a*4 + b*2 + c)];
    //if (a == 1 && b == 1 && c == 1) return ruleset[0];
    //if (a == 1 && b == 1 && c == 0) return ruleset[1];
    //if (a == 1 && b == 0 && c == 1) return ruleset[2];
    //if (a == 1 && b == 0 && c == 0) return ruleset[3];
    //if (a == 0 && b == 1 && c == 1) return ruleset[4];
    //if (a == 0 && b == 1 && c == 0) return ruleset[5];
    //if (a == 0 && b == 0 && c == 1) return ruleset[6];
    //if (a == 0 && b == 0 && c == 0) return ruleset[7];
  }
}
