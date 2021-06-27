import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

PeasyCam cam;

boolean withBoxes = true;
boolean noColor = false;
boolean rotate = true;
float toGenerate;
float rotationValue = 0;

ArrayList<PVector> startingPoints;
ArrayList<PVector> generatedPoints;

PVector current;

void setup() {
  size(1080, 1080, P3D);

  cam = new PeasyCam(this, 1280);

  startingPoints = new ArrayList<PVector>();
  generatedPoints = new ArrayList<PVector>();

  // tetrahedron's cartesian coordinates
  //( 1,  1,  1)
  //(−1, −1,  1)
  //(−1,  1, −1)
  //( 1, −1, −1)

  startingPoints.add(new PVector(width/2, -height/2, -height/2));
  startingPoints.add(new PVector(-width/2, height/2, -height/2));
  startingPoints.add(new PVector(width/2, height/2, height/2));
  startingPoints.add(new PVector(-width/2, -height/2, height/2));

  resetSimulation();
}

void draw() {
  background(0);

  if (rotate) {
    rotateX(rotationValue);
    rotateY(rotationValue);
    rotateZ(rotationValue);
    rotationValue += 0.001;
  } else {
    rotateX(rotationValue);
    rotateY(rotationValue);
    rotateZ(rotationValue);
  }
  
  
  for (PVector p : startingPoints) {
    pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(8);
    popMatrix();
  }

  if (generatedPoints.size() < toGenerate) {
    generate(100);
  }


  for (PVector p : generatedPoints) {
    if (withBoxes) {
      pushMatrix();
      if (noColor) {
        fill(255);
      } else {
        noStroke();
        fill(
          p.x / width / 2 * 64 + 128, 
          p.y / width / 2 * 128 + 128, 
          p.z / width / 2 * 64);
      }

      translate(p.x, p.y, p.z);
      box(6);
      popMatrix();
    } else {
      if (noColor) {
        stroke(255);
      } else {
        stroke(
          p.x / width / 2 * 128 + 128, 
          p.y / width / 2 * 128 + 128, 
          p.z / width / 2 * 128 + 128);
      }
      point(p.x, p.y, p.z);
    }
  }

  //println(frameRate + " " + generatedPoints.size());
}

void generate() {
  int index = (int)random(4);

  PVector choice = startingPoints.get(index);

  float x = (choice.x + current.x)/2;
  float y = (choice.y + current.y)/2;
  float z = (choice.z + current.z)/2;


  current = new PVector(x, y, z);

  generatedPoints.add(current);
}

void generate(float n) {
  for (int i = 0; i < n; i++) {
    generate();
  }
}

void resetSimulation() {
  generatedPoints.clear();
  current = PVector.random3D();
  toGenerate = 6000;
}

void keyPressed() {
  if (key == ' ') {
    resetSimulation();
  } else if (key == 'c') {
    noColor = !noColor;
    resetSimulation();
  } else if (key == 'b') {
    withBoxes = !withBoxes;
    resetSimulation();
  } else if (key == 'r') {
    rotate = !rotate;
  } else if (keyCode == UP) {
    toGenerate *= 1.3333;
    toGenerate = constrain(toGenerate, 10, 100000);
  } else if (keyCode == DOWN) {
    toGenerate *= 0.6666;
    toGenerate = constrain(toGenerate, 10, 100000);
  }
}