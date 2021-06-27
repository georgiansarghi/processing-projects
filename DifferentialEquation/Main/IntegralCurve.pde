class IntegralCurve {
  ArrayList<PVector> points;
  float dt = 0.001;

  IntegralCurve(float startx, float starty) {
    println(startx, starty);
    points = new ArrayList<PVector>();
    points.add(new PVector(startx, starty));
  }

  void display() {
    if (points.size() < 10000) {
      for (int i = 0; i < 500; i++) {
        PVector p = points.get(points.size()-1);
        float dy = f(p.x, p.y);

        PVector rr = new PVector(1, dy);
        rr.normalize();

        PVector n = new PVector(p.x + rr.x * dt, p.y + rr.y * dt);
        points.add(n);
      }
    }

    strokeWeight(1);
    stroke(0, 0, 255);
    noFill();

    beginShape();
    for (PVector p : points) {
      vertex(width/2 + p.x*S, height/2 - p.y*S);
    }
    endShape();

    //for(PVector p: points) {
    //  ellipse(width/2 + p.x*S, height/2 - p.y*S, 50, 50);
    //}
  }
}