ArrayList<Particle> particles;
Particle att;


void setup() {
  size(1000, 1000);
  particles = new ArrayList<Particle>();
  att = new Particle(width/2, height/2, 10);

  for (int i = 0; i < 8000; i++) {
    particles.add(new Particle(random(width), random(height), 3));
  }
}



void draw() {

  for (int i = 0; i < 10; i++) {
    background(0);
    checkCollisions();
    fill(255);
    ellipse(att.x, att.y, att.radius*2, att.radius*2);

    moveParticles();
  }
  
  noStroke();
  displayParticles();
  println(particles.size());
}



void displayParticles() {
  for (Particle p : particles) {
    if (p.alive) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(p.x, p.y, p.radius*2, p.radius*2);
  }
}



void moveParticles() {
  for (Particle p : particles) {
    if (p.alive) {
      p.move(att);
    }
  }
}


void checkCollisions() {
  for (Particle p1 : particles) {
    if (p1.alive) {
      if (dist(p1.x, p1.y, att.x, att.y) <= p1.radius + att.radius) {
        p1.alive = false;
      }
      for (Particle p2 : particles) {
        if (!p2.alive) {
          if (dist(p1.x, p1.y, p2.x, p2.y) <= p1.radius + p2.radius) {
            p1.alive = false;
            break;
          }
        }
      }
    }
  }
}


void keyPressed() {
  if (key == ' ') {
    for (int i = 0; i < 5; i++) {
      particles.add(randomParticle());
    }
  }
}

Particle randomParticle() {
  float angle = random(TWO_PI);
  float x1 = random(10, 300) * sin(angle) + width/2;
  float y1 = random(10, 300) * cos(angle) + height/2;
  Particle r = new Particle(x1, y1, 4);
  return r;
}
