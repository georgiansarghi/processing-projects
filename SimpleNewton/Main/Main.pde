float a = 1;
int iterations;

float minRe = -2, maxRe = 2, minIm = -2, maxIm = 2;

void setup() {
  size(500, 500);
  loadPixels();
  for (float py = 0; py < height; py++) {
    for (float px = 0; px < width; px++) {
      float re = floatMap(px, 0, width, minRe, maxRe);
      float im = floatMap(py, height, 0, minIm, maxIm);

      float c = iterate(re, im, iterations);
      if (c == iterations) {
        pixels[(int)(px + py * width)] = color(0, 0, 0);
      } else {
        pixels[(int)(px + py * width)] = color((int)floatMap(c, 0, iterations, 255, 0));
      }
    }
  }
  updatePixels();

  noLoop();
}


void draw() {
}

int iterate(float re, float im, int it) {

}

float ratio(float z) {
  return a * (z*z*z - 2*z + z) / (3*z*z - 2);
}


public float floatMap(float value, float start1, float stop1, float start2, float stop2) {
  return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
}