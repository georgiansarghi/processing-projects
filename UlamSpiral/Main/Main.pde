Ulam spiral;

float gridSize = 200;
int speed = 1;

void setup() {
  size(1000, 1000);
  frameRate(1000);
  noStroke();
  
  gridSize += (gridSize+1)%2;
  reset();
}

void draw() {
  // meglio fare cosi che cambiare il frameRate
  for (int i = 0; i < speed; i++) {
    if (!spiral.end()) {
      spiral.generate();
      spiral.display();
    }
  }
}

void reset() {
  background(200);
  println("speed: " + speed + ", grid: " + gridSize);
  spiral = new Ulam(gridSize);
  spiral.display();
}

void keyPressed() {
  if (key == ' ') {
    reset();
  } else if (keyCode == UP) {
    gridSize += 2;
    gridSize = constrain(gridSize, 1, width);
    reset();
  } else if (keyCode == DOWN) {
    gridSize -= 2;
    gridSize = constrain(gridSize, 1, width);
    reset();
  } else if (keyCode == RIGHT) {
    speed += 1;
    speed = constrain(speed, 1, width);
  } else if (keyCode == LEFT) {
    speed -= 1;
    speed = constrain(speed, 1, width);
  }
}
