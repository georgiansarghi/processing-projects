ArrayList<PVector> startingPoints;
ArrayList<PVector> generatedPoints;

PVector current;

float toGenerate = 300000;
float generationRate = 1000;

boolean saving = false;

int sides = 3;
float ratio = 2;

int radius = 25;

int maxSides = 20;

color colors[];

void setup() {
  size(1350, 900, P2D);
  frameRate(30);
  background(0);
  
  stroke(0, 128);
  noFill();

  strokeWeight(1);
  colors = new color[maxSides];
  
  textFont(createFont("Monospaced", 10));
  radius = width/3 - 5;
  resetSimulation();
  
  smooth(8);
}



void draw() {
  noFill();

  if (generatedPoints.size() < toGenerate) {
    generate(generationRate);
  }

  //for (PVector p : generatedPoints) {
  //  point(p.x, p.y);
  //}

  if(random(1) < .2) {
    println(frameRate, generatedPoints.size());
  }
  
  if(saving) {
    save("chaosgame" + sides + "" + (int)random(100) + ".png");
    saving = false;
  }
  
  fill(0);
  text("s = " + sides + ", r = " + ratio, 10, height-20);
}



void generate() {
  int index = (int)random(sides);
  PVector choice = startingPoints.get(index);
  
  current.add(PVector.sub(choice, current).mult(1-1./ratio));
 // println(random(1.5, 1.1));
  
  if(generatedPoints.size() > 10) {
    stroke(colors[index]);
    point(current.x, current.y);
  }
  generatedPoints.add(current.copy());
}




void generate(float n) {
  for (int i = 0; i < n; i++) {
    generate();
  }
}






void keyPressed() {
  if (key == ' ') {
    resetSimulation();
  } else if(keyCode == LEFT && sides > 3) {
    sides--;
    resetSimulation();
  } else if(keyCode == RIGHT && sides < maxSides) {
    sides++;
    resetSimulation();
  } else if (keyCode == UP) {
    ratio += 1;
    resetSimulation();
  } else if (keyCode == DOWN && ratio > 2) {
    ratio -= 1;
    resetSimulation();
  } else if(key == 's') {
    saving = true;
  }

  generationRate = constrain(generationRate, 1, 10000);
}



public void generateInitialPoints() {
  startingPoints = new ArrayList<PVector>();
  
  float angle = TWO_PI / sides;

  for (int i = 0; i < sides; i++) {
    float x0 = radius * cos(angle * i - PI/2) + width/2;
    float y0 = radius * sin(angle * i - PI/2) + height/2 + 100;
    startingPoints.add(new PVector(x0, y0));
  }
}


void resetSimulation() {
  background(0);
  current = new PVector(width/2, height/2);
  
  
  for(int i = 0; i < maxSides; i++) {
    colors[i] = color(random(256), random(256), random(256));
  }
  
  generatedPoints = new ArrayList<PVector>();
  generateInitialPoints();
}
