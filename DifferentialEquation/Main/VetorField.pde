class VectorField {
  float rows, columns;

  VectorField(float rows_, float columns_) {
    rows = rows_;
    columns = columns_;
  }

  void display() {
    float dr = width/rows;
    float dc = height/columns;
    
    
    stroke(0, 128);
    strokeWeight(2);
    
    for(int i = 0; i <= rows; i++) {
      for(int j = 0; j <= columns; j++) {
        point(i*dr, j*dc);
        displayArrow(i*dr, j*dc, f(convertX(i*dr), convertY(j*dc)));
      }
    }
  }
  
  void displayArrow(float x, float y, float s) {
    //line(x, y, x+5, y+5);
    //text(x+" "+y+" "+s, x, y);
    
    PVector p = new PVector(1, -s);
    p.normalize();
    p.mult(width/rows/3);
    
    line(x-p.x, y-p.y, x+p.x, y+p.y);
  }
}