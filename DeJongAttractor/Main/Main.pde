import peasy.*;

PeasyCam cam;

float a, b, c, d, p, q, r, e, f;
float x, y, z, t1, t2;

boolean saving = false;


ArrayList<PVector> points;

void setup() {
  size(960, 720, P3D);
  //fullScreen();
  background(0);
  stroke(255, 255, 255, 128);

  cam = new PeasyCam(this, width);

  points = new ArrayList<PVector>();

  //a = -0.709; 
  //b = 1.638; 
  //c = 0.452; 
  //d = 1.740;

  a = 1.4;
  b = -2.3;
  c = 2.4;
  d = -2.1;
  p = 1;
  q = 1;
  r = 1;
  e = 1;
  f = 1;


  //a = 2.01;
  //b = -2.53;
  //c = 1.61;
  //d = -0.33;


  x = 4;
  y = 4;
  z = 4;
  
  colorMode(HSB);

  //frameRate(5);
  //strokeWeight(3);
}

void draw() {
  background(0);
  
  if(frameRate > 30) 
    generate(100);
  

  for(PVector p: points) {
    stroke(map(p.x+p.y+p.z, -10, 10, 0, 255), 255, 255);
    point(p.x * 200, p.y * 200, p.z * 200);
  }

  if (saving) {
    saving = false;
    save((int)random(5000) + "dejong.png");
  }

  println(frameRate);
}

void generate(int n) {
  
  for (int i = 0; i < n; i++) {
    t1 = sin(a*y) - cos(b*x) + cos(p*z);
    t2 = sin(c*x) - cos(d*y) + cos(q*z);
    z = sin(e*y) - cos(f*z) + cos(r*x);
    x = t1;
    y = t2;
    points.add(new PVector(x, y, z));
  }
}

void ketPressed() {
  if (key == 's') {
    saving = true;
  }
}