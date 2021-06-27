import controlP5.*;

ControlP5 cp5;

ArrayList<PVector> points;
ArrayList<ArrayList<PVector>> ts;



ArrayList<Simple2DTransform> T;

int levels = 1;
int nf = 4;
int selected = 0;


void setup() {
  size(1000, 1280);
  //fullScreen();



  points = new ArrayList<PVector>();

  T = new ArrayList<Simple2DTransform>();

  for (int i = 0; i < nf; i++) {
    T.add(new Simple2DTransform(0, 1, 1, 0, 0));
  }

  points.add(new PVector(-225, 450));
  points.add(new PVector(225, 450));
  points.add(new PVector(225, -450));
  points.add(new PVector(-225, -450));

  ts = new ArrayList<ArrayList<PVector>>();

  ts.add(new ArrayList<PVector>());


  applyChanges();

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

  fill(0, 0, 0, 8);
  noStroke();
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape(CLOSE);

  noFill();
  stroke(0);
  
  for (ArrayList<PVector> t : ts) {

    beginShape();
    for (PVector p : t) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  popMatrix();

  fill(0, 0, 0, 32);
}

void keyPressed() {
  if (key == ' ') {
    generateNext();
  } else if (key == '1') {
    setSelection(0);
  } else if (key == '2') {
    setSelection(1);
  } else if (key == '3') {
    setSelection(2);
  } else if (key == '4') {
    setSelection(3);
  } else if (key == '5') {
    setSelection(4);
  }
}

void setSelection(int s) {
  if(nf > s) {
    selected = s;
  }
}

void generateNext() {
  if (ts.size() < 10000) {
    ArrayList<ArrayList<PVector>> next = new ArrayList<ArrayList<PVector>>();

    for (ArrayList<PVector> s : ts) {
      for (Simple2DTransform t : T) {
        next.add(applyTransformation(s, t));
      }
    }

    ts = next;
  } else {
    println("cant handle it");
  }
}

void applyChanges() {
  ts.clear();
  ts.add(new ArrayList<PVector>());
  ts.get(0).addAll(points);

  for (int i = 0; i < levels; i++) {
    generateNext();
  }
}


ArrayList<PVector> applyTransformation(ArrayList<PVector> pts, Simple2DTransform t) {
  ArrayList<PVector> res = new ArrayList<PVector>();

  for (PVector p : pts) {
    res.add(t.transform(p));
  }

  return res;
}

void setAngle(float value) {
  T.get(selected).setAngle(value * DEG_TO_RAD);
  applyChanges();
}

void setScaleX(float value) {
  T.get(selected).setSx(value);
  applyChanges();
}

void setScaleY(float value) {
  T.get(selected).setSy(value);
  applyChanges();
}

void setTranslateX(float value) {
  T.get(selected).setTx(value);
  applyChanges();
}

void setTranslateY(float value) {
  T.get(selected).setTy(value);
  applyChanges();
}

void setupGUI() {
  cp5 = new ControlP5(this);

  cp5.addSlider("setAngle")
    .setLabel("angle")
    .setRange(-90, 90)
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
    .setRange(-400, 400)
    .setSize(width/4, 20)
    .setPosition(10, 100)
    .setValue(0);


  cp5.addSlider("setTranslateY")
    .setLabel("translate y")
    .setRange(-400, 400)
    .setSize(width/4, 20)
    .setPosition(10, 130)
    .setValue(0);
}