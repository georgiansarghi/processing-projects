class LinearTransformation {
  float a = 1, c = 0,
        b = 0, d = 1;
  
  
  PVector getTransformed(PVector in) {
    PVector out = new PVector(a * in.x + c * in.y, b * in.x + d * in.y);
    return out;
  }
}