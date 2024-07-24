class Particle {
  public float x;
  public float y;
  public float radius;
  public boolean alive = true;

  
  
  public Particle(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
  
  

  public void move(Particle attractor) {
    float newx = attractor.x - x;
    float newy = attractor.y - y;
    PVector p = new PVector(newx, newy);
    p.normalize().div(0.25).rotate(random(TWO_PI) - PI);
    x += p.x;
    y += p.y;
   
    x = max(0, x);
    x = min(width, x);
    y = max(0, y);
    y = min(height, y);
  }
}
