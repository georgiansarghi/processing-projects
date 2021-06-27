class Projectile {
  float vx, vy;
  float px, py;
  float ax, ay;
  float dt, r = 20;
  
  
  
  Projectile(float px, float py
           , float vx, float vy
           , float ax, float ay
           , float dt) {
             
    this.px = px;
    this.py = py;
    this.vx = vx;
    this.vy = vy;
    this.ax = ax;
    this.ay = ay;
    this.dt = dt;
  }
  
  
  
  void update() {
    if(px >= width - r || px <= r) {
      vx = -vx;
    }
    
    if(py >= height - r || py <= r) {
      vy = -vy;
    }
    
    px = px + vx*dt;
    py = py + vy*dt;
    vx = vx + ax*dt;
    vy = vy + ay*dt;
  }
  
  
  
  void display() {
    fill(0, 255, 0);
    ellipse(px, py, r*2, r*2);
  }
}