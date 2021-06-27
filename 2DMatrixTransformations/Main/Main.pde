import controlP5.*;

ControlP5 cp5;

ArrayList<PVector> points;
ArrayList<ArrayList<PVector>> ts;
Simple2DTransform T;
int nts = 60;

void setup() {
  size(960, 720);
  //fullScreen();
  fill(0, 0, 0, 32);


  points = new ArrayList<PVector>();

  T = new Simple2DTransform(PI/6, 1, 1, 100, 100);

  points.add(new PVector(-50, 50));
  points.add(new PVector(50, 50));
  points.add(new PVector(50, -50));
  points.add(new PVector(-50, -50));

  ts = new ArrayList<ArrayList<PVector>>();
  for (int i = 0; i < nts; i++) {
    ts.add(new ArrayList<PVector>());
  }

  setupGUI();
}

void draw() {
  background(255);



  pushMatrix();
  translate(width/2, height/2);
  scale(1, -1);

  //stroke(0, 0, 0, 128);
  //line(0, -height/2, 0, height/2);
  //line(width/2, 0, -width/2, 0);


  noStroke();
  beginShape();
  for (PVector p : points) {

    vertex(p.x, p.y);
  }
  endShape(CLOSE);

  ArrayList<PVector> prev = points;
  int index = 0;
  for (ArrayList<PVector> t : ts) {
    t = applyTransformation(prev);

    index++;
    if (index == nts) fill(255, 0, 0);
    else fill(0, 0, 0, 32);

    beginShape();
    for (PVector p : t) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    prev = t;
  }

  popMatrix();
  
  fill(0, 0, 0, 32);
}


ArrayList<PVector> applyTransformation(ArrayList<PVector> pts) {
  ArrayList<PVector> res = new ArrayList<PVector>();

  for (PVector p : pts) {
    res.add(T.transform(p));
  }

  return res;
}

void setAngle(float value) {
  T.setAngle(value * DEG_TO_RAD);
}

void setScaleX(float value) {
  T.setSx(value);
}

void setScaleY(float value) {
  T.setSy(value);
}

void setTranslateX(float value) {
  T.setTx(value);
}

void setTranslateY(float value) {
  T.setTy(value);
}

void setupGUI() {

  cp5 = new ControlP5(this);

  cp5.addSlider("setAngle")
    .setLabel("angle")
    .setRange(-180, 180)
    .setSize(width/4, 20)
    .setPosition(10, 10)
    .setValue(0);

  cp5.addSlider("setScaleX")
    .setLabel("scale x")
    .setRange(0, 2)
    .setSize(width/4, 20)
    .setPosition(10, 40)
    .setValue(1);

  cp5.addSlider("setScaleY")
    .setLabel("scale y")
    .setRange(0, 2)
    .setSize(width/4, 20)
    .setPosition(10, 70)
    .setValue(1);

  cp5.addSlider("setTranslateX")
    .setLabel("translate x")
    .setRange(-width/2, width/2)
    .setSize(width/4, 20)
    .setPosition(10, 100)
    .setValue(0);


  cp5.addSlider("setTranslateY")
    .setLabel("translate y")
    .setRange(-height/2, height/2)
    .setSize(width/4, 20)
    .setPosition(10, 130)
    .setValue(0);
}