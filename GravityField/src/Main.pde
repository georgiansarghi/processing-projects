

int S = 5;
float M = 10;

ArrayList<Body> bodies;

void setup() {
  size(1000, 1000, P2D);
  //fullScreen();
  bodies = new ArrayList<Body>();
  smooth(16);
  stroke(0);
  strokeWeight(1);
  frameRate(120);
}



void draw() {
  background(0);
  translate(width/2, height/2);
  scale(1, -1);

  for (int i = -width/2; i < width/2; i += S) {
    for (int j = -height/2; j < height/2; j += S) {
      PVector g = new PVector(0, 0);

      for (Body b : bodies) {
        g = g.add(b.field(i, j));
      }

      g = g.add(field(i, j));
      g.normalize().mult(M);
      stroke(200);
      strokeWeight(2);
      line(i, j, i+g.x, j+g.y);
    }
  }
  fill(255);
   for (Body b : bodies) {
    ellipse(b.x, b.y, 10, 10);
  }

}

void mouseClicked() {
  bodies.add(new Body(10E12, mouseX - width/2, -mouseY + height/2));
}


void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  S = constrain(S-e, 1, 100);
  // println(S);
}

void keyPressed() {
  save("test"+random(1000)+".png");
  
  if (keyCode == UP) {
    S += 1;
  } else if (keyCode == DOWN && S > 1) {
    S -= 1;
  } else if (keyCode == LEFT && M > 0.2) {
    M -= 1;
  } else if (keyCode == RIGHT) {
    M += 1;
  }
}


PVector field(float x, float y) {
  PVector v = new PVector(mouseX - width/2 - x, -mouseY + height/2 - y);
  float magsq = v.magSq();
  if(magsq == 0) return new PVector(0, 0);
  PVector n = v.normalize().mult(10E12 / magsq);
  return n;
}
