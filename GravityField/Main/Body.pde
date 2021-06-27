class Body {
  float mass;
  float x, y;
  
  
  public Body(float mass, float x, float y) {
    this.mass = mass;
    this.x = x;
    this.y = y;
  }
  
  
  
  public Body() {
    this.mass = 0;
    this.x = 0;
    this.y = 0;  
  }
  
  PVector field(float x, float y) {
    PVector v = new PVector(this.x - x, this.y - y);
    float magsq = v.magSq();
    if(magsq == 0) return new PVector(0, 0);
    PVector n = v.normalize().mult(mass / magsq);      
    return n;
  }
}