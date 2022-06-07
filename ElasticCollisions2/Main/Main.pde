Ball[] balls;

int ballsrow = 11;
int ballscol = 11;

float ir, im;
PVector ip, iv, ia;

boolean updating = true;


//ArrayList <PVector> points;

int target = 220;

void setup() {
  size(1000, 1000, P2D);
  strokeWeight(2);
  
  //points = new ArrayList<PVector>();

  balls = new Ball[ballsrow * ballscol];

  randomSeed(0);

  for (int i = 0; i < ballsrow; i++) {
    for (int j = 0; j < ballscol; j++) {
      float o = width/(ballscol + 1);
      //o = 50;
      ip = new PVector(j * o + o, i * o + o);
      float ra = random(TWO_PI);
      iv = new PVector(cos(ra), sin(ra)).mult(2);//PVector.random2D().mult(5);
      //iv = new PVector(0, 0);
      ia = new PVector(random(0, 0), 0);
      //ir = random(5, 15);
      ir = 8;
      im = ir*ir;
      //iv = new PVector(5, 4);
      balls[ballsrow * j + i] = new Ball(ip, iv, ia, im, ir);
    }
  }
  
  //balls[0].velocity.x = 2.99999;
  //balls[0].velocity.y = 2.00001;
  //balls[0].clr = color(255, 0, 0);


  //balls[target].radius = 20;
  //balls[target].mass = 100;
  //balls[target].velocity = new PVector(0, 0);

  //balls[0].position.x += 1./500000;
  //balls[0].clr = color(255, 0, 0);


}

void draw() {
  background(255);
  noStroke();

  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
    balls[i].display();
    balls[i].checkLimits();
  }

  for (int i = 0; i < balls.length-1; i++) {
    for (int j = i+1; j < balls.length; j++) {
      balls[i].check(balls[j]);
    }
  }

  //if (red(balls[target].clr) == 255) {
  //  points.add(new PVector(balls[target].position.x, balls[target].position.y, 255));
  //} else {
  //  points.add(new PVector(balls[target].position.x, balls[target].position.y, 0));
  //}
  
  
  //stroke(0);
  //noFill();
  //beginShape();
  //for (PVector p : points) {
  //  if(p.z == 255) {
  //    stroke(255, 0, 0, 128);
  //  } else {
  //    stroke(0, 128);
  //  }
  //  vertex(p.x, p.y);
  //}
  //endShape();

  //println(frameRate, frameCount, points.size());
  
  //if(frameCount == 5000) {
  //  save(int(random(100)) + "elastic2.png");
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
  } else if (key == ' ') {
    updating = !updating;
  } else if (key == 's') {
    save(int(random(100)) + "elastic.png");
  }
}
