Projectile p;
ArrayList<PVector> pts;

void setup() {
  size(1200, 800, P2D);
  frameRate(120);
  pts = new ArrayList<PVector>();
  p = new Projectile(50, 70, 700, 1200, 0., -10000, .001);
}


void draw() {
  background(255);
  translate(0, height);
  scale(1, -1);
  p.update();
  p.display();
  pts.add(new PVector(p.px, p.py));
  strokeWeight(2);
  for(PVector p: pts) {
    point(p.x, p.y);
  }
}