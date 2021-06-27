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
    p.normalize().div(2).rotate(random(TWO_PI));
    x += p.x;
    y += p.y;
    
  }
  

}