class Island {
  ArrayList<PVector> points;
  PShape islandShape;

  int sides;
  float radius;
  float offset;
  float restoreOffset;
  float scaleFactor;
  boolean genarateAll;



  public Island(int sides_, float radius_, float offset_, float scaleFactor_, boolean gMode) {
    sides = sides_;
    radius = radius_;
    restoreOffset = offset_;
    offset = restoreOffset;
    scaleFactor = scaleFactor_;
    genarateAll = gMode;

    generateInitialPoints();
    updateShape();
  }



  public void generateInitialPoints() {
    points = new ArrayList<PVector>();
    float angle = TWO_PI / sides;

    for (int i = 0; i < sides; i++) {
      float x0 = radius * cos(angle * i) + width/2;
      float y0 = radius * sin(angle * i) + height/2;
      points.add(new PVector(x0, y0));
    }

    points.add(new PVector(radius + width/2, height/2));
  }



  public void generate() {
    int n;
    if (genarateAll) {
      generateInitialPoints();
      offset = restoreOffset;
      n = 13;
    } else {
      n = 1;
    }
    
    for (int i = 0; i < n; i++) {
      ArrayList<PVector> next = new ArrayList<PVector>();

      for (int j = 0; j < points.size()-1; j++) {
        PVector p1 = points.get(j);
        PVector p2 = points.get(j+1);
        float newx = (p1.x+p2.x)/2 + (random(2) * offset - offset);
        float newy = (p1.y+p2.y)/2 + (random(2) * offset - offset);
        PVector pc = new PVector(newx, newy);
        next.add(p1);
        next.add(pc);
      }

      next.add(new PVector(radius + width/2, height/2));
      points = next;

      offset *= scaleFactor;
    }
    updateShape();
  }



  public void updateShape() {
    islandShape = createShape();
    islandShape.beginShape();
    islandShape.fill(0);

    for (PVector p : points) {
      islandShape.vertex(p.x, p.y);
    }

    islandShape.endShape(CLOSE);
  }



  public void setSides(int sides_) {
    sides = sides_;
    offset = restoreOffset;

    generateInitialPoints();
    updateShape();
  }



  public void setOffset(float offset_) {
    restoreOffset = offset_;
    offset = restoreOffset;
    generateInitialPoints();
    updateShape();
  }



  public void setScaleFactor(float scaleFactor_) {
    scaleFactor = scaleFactor_;
    offset = restoreOffset;
    generateInitialPoints();
    updateShape();
  }
  

  public void setRadius(float radius_) {
    radius = radius_;
    offset = restoreOffset;
    generateInitialPoints();
    updateShape();
  }
  
  

  public void setGenerationMode(boolean gMode) {
    genarateAll = gMode;
    offset = restoreOffset;
    generateInitialPoints();
    updateShape();
  }



  public void display() {
    shape(islandShape);
  }
}