ArrayList<PVector> pts;

ArrayList<ArrayList<Float>> A;
ArrayList<Float> B;

void setup() {
  size(800, 800);

  pts = new ArrayList<PVector>();
  A = new ArrayList<ArrayList<Float>>();
  B = new ArrayList<Float>();
}

void draw() {
  background(255);
  strokeWeight(2);
  stroke(0);

  for (PVector p : pts) {
    point(p.x, p.y);
  }
}

void mouseReleased() {
  PVector newPoint = new PVector(mouseX, mouseY);
  pts.add(newPoint);
  computePolynomial();
}

void computePolynomial() {
  int n = pts.size();
  
  A.clear();
  for (PVector p : pts) {
    ArrayList row = new ArrayList<Float>();
    for(int i = 0; i < n; i++) {
      row.add(pow(p.x, i));
    }
    A.add(row);
    B.add(p.y); 
  }
}