Ball[] balls;


int ballsrow = 33;
int ballscol = 33;

float ir;
PVector ip, iv, ia;

//ArrayList<PVector> points;

boolean updating = false;

void setup() {
  size(1000, 1000, P2D);
  fill(0);


  //points = new ArrayList<PVector>();

  balls = new Ball[ballsrow * ballscol];

  ir = 2;


  for (int i = 0; i < ballsrow; i++) {
    for (int j = 0; j < ballscol; j++) {
      float o = width/(ballscol + 1);
      ip = new PVector(j * o + o, i * o + o);
      iv = PVector.random2D().mult(2);
      balls[ballsrow * j + i] = new Ball(ip, iv, ir);
    }
  }


  balls[0].clr = color(255, 0, 0);
}

void draw() {
  background(255);
  noStroke();

  if (updating) {
    for (int i = 0; i < balls.length; i++) {
      balls[i].update();
    }
  }

  for (int i = 0; i < balls.length; i++) {
    balls[i].display();
    balls[i].checkLimits();
  }


  for (int i = 0; i < balls.length-1; i++) {
    for (int j = i+1; j < balls.length; j++) {
      balls[i].check(balls[j]);
    }
  }

  //println(points.size());

  //stroke(255, 0, 0);


  //if (points.size() != 0) {
  //  PVector s = points.get(0);
  //  for (PVector p : points) {
  //    line(s.x, s.y, p.x, p.y);
  //    s = p;
  //  }
  //}





  //println(frameRate, frameCount);


  //if(frameCount == 3000) {
  //  save("test2.png");
  //  exit();
  //}
}

void keyPressed() {
  if (keyCode == UP) {
    for (int i = 0; i < balls.length; i++) {
      balls[i].radius++;
    }
  } else if (keyCode == DOWN) {
    for (int i = 0; i < balls.length; i++) {
      balls[i].radius--;
    }
  } else if(key == ' ') {
    updating = !updating;
  }
}
