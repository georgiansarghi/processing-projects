class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float radius;
  
  float last = random(1);
  
  color clr;

  Ball(PVector p, PVector v, PVector a, float m, float r) {
    position = p;
    velocity = v;
    acceleration = a;
    mass = m;
    radius = r;
    clr = color(255);
  }

  Ball(PVector p, PVector v, float m, float r) {
    position = p;
    velocity = v;
    acceleration = new PVector(0, 0);
    mass = m;
    radius = r;
    clr = color(255);
  }

  Ball(PVector p, float m, float r) {
    position = p;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = m;
    radius = r;
    clr = color(255);
  }


  void update() {
    position.add(velocity);
    velocity.add(acceleration);
  }
  
  void update2() {
    velocity.sub(acceleration);
    position.sub(velocity);
  }

  void display() {
    fill(clr, 64);
    ellipse(position.x, position.y, radius*2, radius*2);
  }

  void checkLimits() {
    float h = velocity.heading() * RAD_TO_DEG;

    if (position.x <= radius && abs(h) > 90) {
      velocity.x *= -1;
      last = random(1);
    }

    if (position.x >= width - radius && abs(h) < 90) {
      velocity.x *= -1;
      last = random(1);
    }

    if (position.y <= radius && h < 0) {
      velocity.y *= -1;
      last = random(1);
    }

    if (position.y >= height - radius && h > 0) {
      velocity.y *= -1;
      last = random(1);
    }
  }

  void check(Ball b) {
    Ball a = this;
    
    if (a.position.dist(b.position) <= a.radius + b.radius && a.last != b.last) {
      
      float newLast = random(1);
      a.last = newLast;
      b.last = newLast;
      
      //float r1 = a.clr >> 16 & 0xFF;
      //float r2 = b.clr >> 16 & 0xFF;
      
      //if(r1 != r2) {
      //  a.clr = color(255, 0, 0);
      //  b.clr = color(255, 0, 0);
      //}
      
      float collisionAngle = PVector.sub(a.position, b.position).heading();
      float aAngle = a.velocity.heading();
      float aMag = a.velocity.mag();
      float axc = aMag * cos(aAngle-collisionAngle);
      float ayc = aMag * sin(aAngle-collisionAngle);

      float bAngle = b.velocity.heading();
      float bMag = b.velocity.mag();
      float bxc = bMag * cos(bAngle-collisionAngle);
      float byc = bMag * sin(bAngle-collisionAngle);

//      no mass
      //b.velocity.x = axc;
      //a.velocity.x = bxc;

      a.velocity.x = (axc * (a.mass - b.mass) + 2 * b.mass * bxc) / (a.mass + b.mass);
      b.velocity.x = (bxc * (b.mass - a.mass) + 2 * a.mass * axc) / (a.mass + b.mass);
      
      
      

      b.velocity.y = byc; // same
      a.velocity.y = ayc; // same
      
      b.velocity.rotate(collisionAngle);
      a.velocity.rotate(collisionAngle);
    }
  }
}
