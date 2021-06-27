ArrayList<LandscapeLine> lines;


void setup() {
  size(800, 400);
  stroke(0);
  randomSeed(158);
  fill(255, 0, 0, 127);
  reset();
}


void draw() {
  background(255);
  displayLines();
}



void generate() {
  ArrayList<LandscapeLine> next = new ArrayList<LandscapeLine>();
  
  for(LandscapeLine l: lines) {
    next.addAll(l.getNext());
  }
  
  lines = next;
}



void displayLines() {
  for(LandscapeLine l: lines) {
    l.display();
  }
}



void reset() {
  lines = new ArrayList<LandscapeLine>();
  lines.add(new LandscapeLine(new PVector(0, height/2), new PVector(width, height/2), height/2, .6));
}



void keyPressed() {
  if(key == ' ') {
    generate();
  } else if(key == 'r') {
    reset();
  } else if(key == 's') {
    print("111");
    save("landscape2.png");
  }
}