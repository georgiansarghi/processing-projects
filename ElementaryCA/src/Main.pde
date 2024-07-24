CellularAutomata CellularAutomata;

int cellSize = 4;
int ruleNumber = 86;
boolean randomState = false;

boolean saving = false;

int ruleNumberIndex = 0;
int[] nrs = {73,126,45,30};

void setup() {
  size(960, 960);
  background(32);
  frameRate(100);
  reset();
}

void draw() {
  CellularAutomata.display();

  if (CellularAutomata.gen < height/cellSize) {
    CellularAutomata.generate();
  }
  
  
  if(saving) {
    saving = false;
    save(ruleNumber + "CellularAutomata.png");
  }
}

void keyPressed() {
  if (keyCode == UP) {
    cellSize++;
    reset();
  } else if (keyCode == DOWN) {
    cellSize--;
    reset();
  } else if (key == 'r') {

    ruleNumberIndex += 1;
    ruleNumber = nrs[ruleNumberIndex % 4];
    
    //ruleNumber = (int)random(0, 256);

    reset();
  } else if (key == ' ') {
    randomState = !randomState;
    reset();
  } else if(key == 's') {
    saving = true;
  }

  println(ruleNumber + " " + cellSize);
}

void reset() {
  CellularAutomata = new CellularAutomata(ruleNumber, cellSize, randomState);
}
