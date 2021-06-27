CA ca;

int cellSize = 5;
int ruleNumber = 30;
boolean randomState = false;

boolean saving = false;

void setup() {
  size(1920, 1000);
  background(255);
  frameRate(600);
  reset();
}

void draw() {
  ca.display();

  if (ca.gen < height/cellSize) {
    ca.generate();
  }
  
  
  if(saving) {
    saving = false;
    save(ruleNumber + "ca.png");
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
    ruleNumber = (int)random(0, 256);
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
  ca = new CA(ruleNumber, cellSize, randomState);
}