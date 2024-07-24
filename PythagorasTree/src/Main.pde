import controlP5.*;

ArrayList<Square> tree;

float trunkAngle = 45;

ControlP5 cp5;

float angle = QUARTER_PI;
int depht = 5;
float side = 100;

PVector a, b, c, d;

void setup() {
  //size(1450, 900);
  fullScreen();



  cp5 = new ControlP5(this);

  tree = new ArrayList<Square>();

  generateTree();

  cp5.addSlider("changeAngle")
    .setLabel("angle")
    .setSize(200, 20)
    .setRange(0, HALF_PI)
    //.setValue(0)
    .setValue(QUARTER_PI)
    .setPosition(10, 10);

  cp5.addSlider("changeDepht")
    .setLabel("depht")
    .setSize(200, 20)
    .setRange(1, 16)
    .setValue(1)
    .setPosition(10, 40);

  cp5.addSlider("changeSide")
    .setLabel("side")
    .setSize(200, 20)
    .setRange(10, 200)
    .setValue(100)
    .setPosition(10, 70);

  smooth(16);

  generateTree();
}

void draw() {
  background(0);


  for (Square s : tree) {
    if (true) {
      s.display();
    }
  }


  if (random(1) < 0.01)
    println(frameRate);
}


void changeAngle(float a_) {
  angle = a_;
  generateTree();
}


void changeDepht(int d_) {
  depht = d_;
  generateTree();
}

void changeSide(int s_) {
  side = s_;
  generateTree();
}

void generateTree(PVector p1, PVector p2, PVector p3, PVector p4, int limit) {
  if (limit > 0) {
    Square sq = new Square();
    sq.v0 = new PVector(p1.x, p1.y);
    sq.v1 = new PVector(p2.x, p2.y);
    sq.v2 = new PVector(p3.x, p3.y);
    sq.v3 = new PVector(p4.x, p4.y);
    sq.level = limit;
    tree.add(sq);


    PVector pc = p2.copy().sub(p1).rotate(-angle).mult(cos(angle)).add(p1);

    PVector p5 = new PVector(pc.x, pc.y).sub(p1).rotate(-HALF_PI).add(p1);
    PVector p6 = new PVector(pc.x, pc.y).sub(p1).add(p5);

    PVector p8 = new PVector(pc.x, pc.y).sub(p2).rotate(HALF_PI).add(p2);
    PVector p7 = new PVector(pc.x, pc.y).sub(p2).add(p8);

    generateTree(p5, p6, pc, p1, limit-1);
    generateTree(p7, p8, p2, pc, limit-1);
  }
}

void generateTree() {
  tree.clear();
  a = new PVector(-side + width/2, -side + height -100-side);
  b = new PVector(side + width/2, -side + height -100-side);
  c = new PVector(side + width/2, side + height -100-side);
  d = new PVector(-side + width/2, side + height -100-side);
  generateTree(a, b, c, d, depht);
}


void keyPressed() {
  if(key == 's') {
    save(random(1000) + "pt.png");
  }
}
