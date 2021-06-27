class TimesTable {
  public float times;
  public float modulo;
  public float radius;

  public TimesTable(float x, float m, float r) {
    times = x;
    modulo = m;
    radius = r;
    
  }
  
  public void connect(float index1, float index2) {
    float angle = TWO_PI / modulo;
    float xp1 = radius * sin(angle * index1) + width/2;
    float yp1 = radius * cos(angle * index1) + height/2;
    float xp2 = radius * sin(angle * index2) + width/2;
    float yp2 = radius * cos(angle * index2) + height/2;
    
    //frame.line(xp1, yp1, xp2, yp2);
    line(xp1, yp1, xp2, yp2);
    
  }
  
  public void displayTimesTable() {
    
    //frame.beginDraw();
    //frame.colorMode(HSB);
    //frame.background(0);
    //frame.stroke(hu, 255, 255);
    strokeWeight(1);
    ellipse(width/2, height/2, 2*radius + 1, 2*radius + 1);
   // strokeWeight(1);
    stroke(hue, 255, 255, 128);
    for(float n = 0; n < modulo; n ++) {
      float i1 = (n*times) % modulo;
      connect(n, i1);
    }
    //frame.endDraw();
    //ellipse(width/2, height/2, radius*2, radius*2);
  }
}