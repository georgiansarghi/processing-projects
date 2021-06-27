import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

ArrayList<ArrayList<PVector>> points;

float a = 10;
float b = 28;
float c = 2.66666666;


float scl = 10;
float hue = 0;
//float generationRate = 1;

boolean rotate = false;
float rotationValue = 0;

void setup() {
 // size(960, 720, P3D);
    fullScreen(P3D);
  noFill();
  //colorMode(HSB);
  //textFont(createFont("Monospaced", 10));

  cam = new PeasyCam(this, 960);
  
  points = new ArrayList<ArrayList<PVector>>();

  for (int i = 0; i < 300; i++) {
    points.add(new ArrayList<PVector>());
  }

  resetSimulation();
}


void draw() {
  background(0);


  if (rotate) {
    rotateY(rotationValue);
    rotationValue += 0.001;
  } else {
    rotateY(rotationValue);
  }



  translate(0, 0, -200);


  for (ArrayList<PVector> alp : points) {
    PVector current = alp.get(alp.size()-1);
    current = lorenz(current);
    alp.add(current);

    while (alp.size() > 100) {
      alp.remove(0);
    }


    beginShape();
    //hue = 0;
    for (PVector p : alp) {
      stroke(255, 0, 0);
      vertex(p.x*scl, p.y*scl, p.z*scl);
      //hue += 1;
      //if (hue > 255) {
      //  hue = 0;
      //}
    }
    endShape();
  }


  println(frameRate);
}

PVector lorenz(PVector l) {
  float dx = a * (l.y - l.x);
  float dy = l.x * (b - l.z) - l.y;
  float dz = l.x * l.y - c * l.z;

  PVector n = new PVector();

  n.x = l.x + dx * .005;
  n.y = l.y + dy * .005;
  n.z = l.z + dz * .005;

  return n;
}

void keyPressed() {
  if (key == ' ') {
    resetSimulation();
    //} else if(keyCode == UP) {
    //  generationRate *= 1.33333;
    //} else if(keyCode == DOWN ) {
    //  generationRate *= 0.66666;
  } else if (key == 'r') {
    rotate = !rotate;
  }

  //generationRate = constrain(generationRate, 1, 1000);
}


void resetSimulation() {

  for (ArrayList<PVector> alp : points) {
    alp.clear();
    alp.add(new PVector(random(0.001), random(0.001), random(0.001)));
  }

  //current = new PVector(0.1, 0.1, 0.1);
}