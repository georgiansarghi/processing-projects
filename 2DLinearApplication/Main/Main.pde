import controlP5.*;
ControlP5 cp5;

LinearTransformation LT;

ArrayList<PVector> rpoints;

void setup() {
  size(800, 800, P2D);
  textFont(createFont("Monospaced", 12));

  LT = new LinearTransformation();
  cp5 = new ControlP5(this);

  rpoints = new ArrayList<PVector>();
  
  for(int i = 0; i < 1000; i++) {
    rpoints.add(PVector.random2D().mult(random(1)));
  }


  cp5.addSlider("change_a")
    .setLabel("a")
    .setPosition(10, 10)
    .setSize(width/2 - 20, 15)
    .setRange(-2, 2)
    .setValue(1);
    
  cp5.addSlider("change_b")
    .setLabel("b")
    .setPosition(10, 30)
    .setSize(width/2 - 20, 15)
    .setRange(-2, 2)
    .setValue(0);
    
  cp5.addSlider("change_c")
    .setLabel("c")
    .setPosition(width/2 + 5, 10)
    .setSize(width/2 - 20, 15)
    .setRange(-2, 2)
    .setValue(0);
    
  cp5.addSlider("change_d")
    .setLabel("d")
    .setPosition(width/2 + 5, 30)
    .setSize(width/2 - 20, 15)
    .setRange(-2, 2)
    .setValue(1);
}



void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  scale(1, -1);
  
  stroke(128);
  strokeWeight(2);
  fill(128);
  
  for(PVector p: rpoints) {
    point(p.x * 200, p.y * 200);
    //ellipse(p.x, p.y, 100, 100);
  }
  
  stroke(255);
  strokeWeight(2);
  fill(255);
  
  for(PVector p: rpoints) {
    PVector t = LT.getTransformed(p);
    point(t.x * 200, t.y * 200);
  }
  
  
  popMatrix();
}

void displayGrid() {
}


void change_a(float x) {
  LT.a = x;
}
void change_b(float x) {
  LT.b = x;
}

void change_c(float x) {
  LT.c = x;
}

void change_d(float x) {
  LT.d = x;
}