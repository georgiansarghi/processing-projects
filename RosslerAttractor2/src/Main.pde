

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

PeasyCam cam;

ArrayList<ArrayList<PVector>> points;

float a = .1;
float b = .1;
float c = 4;


float scl = 10;
float hue = 0;
//float generationRate = 1;

boolean rotate = false;
float rotationValue = 0;
float speed = 100;

void setup() {
  size(960, 720, P3D);

  noFill();
  colorMode(HSB);
  //textFont(createFont("Monospaced", 10));

  cam = new PeasyCam(this, 960);

  points = new ArrayList<ArrayList<PVector>>();

  for (int i = 0; i < 1; i++) {
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
    for (int i = 0; i < speed; i++) {
      PVector current = alp.get(alp.size()-1);
      current = rossler(current);
      alp.add(current);
    }

    while (alp.size() > 10000) {
      alp.remove(0);
    }


    //beginShape();
    hue = 0;
    for (PVector p : alp) {
      stroke(hue, 255, 255);
      point(p.x*scl, p.y*scl, p.z*scl);
      hue += 0.001;
      if (hue > 255) {
        hue = 0;
      }
    }
    //endShape();
  }


  println(frameRate + " " + a + " " + b + " " + c + " ");
}

PVector rossler(PVector l) {
  float dx = -l.y - l.z;
  float dy = l.x + a * l.y;
  float dz = b + l.z * (l.x - c);

  PVector n = new PVector();

  n.x = l.x + dx * .01;
  n.y = l.y + dy * .01;
  n.z = l.z + dz * .01;

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
  } else if (keyCode == UP) {
    c += 0.1;
  } else if (keyCode == DOWN) {
    c -= 0.1;
  }

  //generationRate = constrain(generationRate, 1, 1000);
}


void resetSimulation() {

  for (ArrayList<PVector> alp : points) {
    alp.clear();
    alp.add(new PVector(random(1), random(1), random(1)));
  }

  //current = new PVector(0.1, 0.1, 0.1);
}
