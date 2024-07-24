class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float radius;
  
  float last = random(1);
  
  color clr;

  Ball(PVector p, PVector v, PVector a, float r) {
    position = p;
    velocity = v;
    acceleration = a;
    radius = r;
    clr = color(0, 255, 0);
  }

  Ball(PVector p, PVector v, float r) {
    position = p;
    velocity = v;
    acceleration = new PVector(0, 0);
    radius = r;
    clr = color(0, 200, 055);
  }

  Ball(PVector p, float r) {
    position = p;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    radius = r;
    clr = color(0, 255, 0);
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
    // stroke(255);
    fill(clr);
    ellipse(position.x, position.y, radius*2, radius*2);
    //line(position.x, position.y, position.x + velocity.x*10, position.y + velocity.y*10);
  }

  void checkLimits() {
    float h = velocity.heading() * RAD_TO_DEG;

    if (position.x <= 0 && abs(h) > 90) {
      velocity.x *= -1;
      last = random(1);
    }

    if (position.x >= width && abs(h) < 90) {
      velocity.x *= -1;
      last = random(1);
    }

    if (position.y <= 0 && h < 0) {
      velocity.y *= -1;
      last = random(1);
    }

    if (position.y >= height && h > 0) {
      velocity.y *= -1;
      last = random(1);
    }
  }

  void check(Ball b) {
    Ball a = this;
    float d = a.position.dist(b.position);
    if (d <= a.radius + b.radius && a.last != b.last) {
      
      float c1 = a.clr >> 16 & 0xFF;
      float c2 = b.clr >> 16 & 0xFF;
      
      if(c1 != c2) {
        a.clr = color(255, 0, 0);
        b.clr = color(255, 0, 0);
      }
      
      //if(b.radius > 6) {
      //  points.add(new PVector(b.position.x, b.position.y));
      //}
      
      float newLast = random(1);
      a.last = newLast;
      b.last = newLast;
      
      
      float collisionAngle = PVector.sub(a.position, b.position).heading();
      float aAngle = a.velocity.heading();
      float aMag = a.velocity.mag();
      float axc = aMag * cos(aAngle-collisionAngle);
      float ayc = aMag * sin(aAngle-collisionAngle);

      float bAngle = b.velocity.heading();
      float bMag = b.velocity.mag();
      float bxc = bMag * cos(bAngle-collisionAngle);
      float byc = bMag * sin(bAngle-collisionAngle);

      b.velocity.x = axc;
      b.velocity.y = byc;

      a.velocity.x = bxc;
      a.velocity.y = ayc;
      
      b.velocity.rotate(collisionAngle);
      a.velocity.rotate(collisionAngle);
    }
  }
}
