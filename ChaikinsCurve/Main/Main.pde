import controlP5.*;

ControlP5 cp5;

PVector[] points;
ArrayList<PVector> start;

boolean started = false;

int index = 0;
int N = 0;
float T = .25;

int generation = 0;

Controller slider;

void setup() {
  size(1800, 720);
  noFill();

  points = new PVector[N];
  start = new ArrayList<PVector>();

  cp5 = new ControlP5(this);
  slider = cp5.addSlider("changeT")
    .setLabel("t")
    .setPosition(10, 10)
    .setSize(256, 16)
    .setRange(0, .5)
    .setValue(.25);

  slider.setVisible(false);

  textFont(createFont("Monospaced", 10));
}


void draw() {
  background(255);
  noFill();
  stroke(0);

  reset(generation);

  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape();


  stroke(0, 0, 255, 64);

  beginShape();
  for (PVector p : start) {
    vertex(p.x, p.y);
    ellipse(p.x, p.y, 5, 5);
  }
  endShape();

  fill(0);
  text(N, 10, height-20);
}

void keyPressed() {
  if (key == ' ') {
    if (!started && N > 1) {
      points = new PVector[N];
      int i = 0;
      for (PVector p : start) {
        points[i++] = p;
      }
      started = true;
      slider.setVisible(true);
    }
    if (started) {
      generate();
    }
  }
}


void mousePressed() {
  if (!started) {
    start.add(new PVector(mouseX, mouseY));
    N++;

    println(N, "added");
  }
}


void generate() {
  PVector[] next = new PVector[N*2 - 2];
  N = N*2 - 2;
  int ix = 0;


  for (int i = 1; i < points.length; i++) {
    PVector p1 = points[i].copy().sub(points[i-1]).mult(T).add(points[i-1]); 
    PVector p2 = points[i].copy().sub(points[i-1]).mult(1-T).add(points[i-1]);

    next[ix++] = p1;
    next[ix++] = p2;
  }

  points = next;
  generation++;
}

void generate(int n) {
  for (int i = 0; i < n; i++) {
    generate();
  }
}

void changeT(float t_) {
  T = t_;
  reset(generation);
}

void reset(int gen) {
  N = start.size();
  points = new PVector[N];

  int i = 0;
  for (PVector p : start) {
    //PVector pp = new PVector(p.x, p.y + map(sin((frameCount+p.x) * 0.01), -1, 1, -100, 100));
    points[i++] = p;
  }

  generation = 0;
  generate(gen);
}