ArrayList<CoastlineLine> lines;


void setup() {
  size(1200, 1200);
  stroke(255);
  fill(255, 0, 0, 127);
  reset();
}


void draw() {
  background(0);
  displayLines();
}



void generate() {
  ArrayList<CoastlineLine> next = new ArrayList<CoastlineLine>();

  for (CoastlineLine l : lines) {
    next.addAll(l.getNext());
  }

  lines = next;
}



void displayLines() {
  for (CoastlineLine l : lines) {
    l.display();
  }
}



void reset() {
  lines = new ArrayList<CoastlineLine>();

  lines.add(new CoastlineLine(new PVector(400, 400), new PVector(width-400, 400), height/8, .6));
  lines.add(new CoastlineLine(new PVector(width-400, 400), new PVector(width-400, height-400), height/8, .6));
  lines.add(new CoastlineLine(new PVector(width-400, height-400), new PVector(400, height-400), height/8, .6));
  lines.add(new CoastlineLine(new PVector(400, height-400), new PVector(400, 400), height/8, .6));
}



void keyPressed() {
  if (key == ' ') {
    generate();
  } else if (key == 'r') {
    reset();
  }
}
