class Square {
  PVector v0, v1, v2, v3;
  int level;

  Square() {
  }

  Square(PVector p0, PVector p1, PVector p2, PVector p3) {
    v0 = p0;
    v1 = p1;
    v2 = p2;
    v3 = p3;
  }

  Square(PVector p0, PVector p1, PVector p2, PVector p3, int l_) {
    v0 = p0;
    v1 = p1;
    v2 = p2;
    v3 = p3;
    level = l_;
  }

  void display() {
    noStroke();
    fill(255);
    beginShape();
    vertex(v0.x, v0.y);
    vertex(v1.x, v1.y);
    vertex(v2.x, v2.y);
    vertex(v3.x, v3.y);
    endShape(CLOSE);
  }
}
