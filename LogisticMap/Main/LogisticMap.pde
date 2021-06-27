public class LogisticMap {

  public LState state;
  public PImage img;

  public double updateTime;
  public int numIterations;
  public double spoint = .5;

  public LogisticMap(double r0, double r1, double x0, double x1, double it) {
    state = new LState();

    state.minR = r0;
    state.minX = x0;
    state.maxR = r1;
    state.maxX = x1;
    state.iterations = it;

    img = createImage(width, height, RGB);

    update();
  }

  public boolean pushState(double r0, double r1, double x0, double x1) {
    if ((x1-x0) == 0 || (r1-r0) == 0) {
      return false;
    }

    double tminR = doubleMap(r0, 0, width, state.minR, state.maxR);
    double tmaxR = doubleMap(r1, 0, width, state.minR, state.maxR);
    double tmaxX = doubleMap(x0, height, 0, state.minX, state.maxX);
    double tminX = doubleMap(x1, height, 0, state.minX, state.maxX);

    state.minX = tminX;
    state.maxX = tmaxX;
    state.minR = tminR;
    state.maxR = tmaxR;

    update();

    return true;
  }

  public void setState(LState s) {
    state = s;
    update();
  }

  public LState getState() {
    return state;
  }

  public void update() {
    long startTime = System.nanoTime();
    numIterations = 0;

    img.loadPixels();

    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        img.pixels[w + h * width] = color(240, 240, 240);
      }
    }

    for (int i = 0; i < width; i++) {
      double r = doubleMap(i, 0, width, state.minR, state.maxR);
      double x = spoint;

      for (double j = 0; j < state.iterations; j++) {
        x = iterate(r, x);
      }

      for (double k = 0; k < state.iterations; k++) {
        x = iterate(r, x);

        if (x > state.minX && x < state.maxX) {
          int l = (int)doubleMap(x, state.minX, state.maxX, 0, height);
          img.pixels[i + width * (height-l-1) ] = color(0, 0, 0, 128);
        }
      }
    }

    img.updatePixels();
    long endTime = System.nanoTime();
    updateTime = (double)(endTime - startTime)/1000000000;
  }

  public double iterate(double r, double x) {
    return r * x * (1 - x);
  }

  public void changeIterations(boolean up) {
    if (up)
      state.iterations = (state.iterations * 1.33333);
    else
      state.iterations = (state.iterations * 0.66666);

    state.iterations = max((float)state.iterations, 1);
    update();
  }

  public double doubleMap(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }

  public String getDescriptionString() {
    return "r0 = " + state.minR + ", x0 = " + state.maxX +
      "i\nr1 = " + state.maxR + ", x1 = " + state.minX + "i\n" +
      "iterations = " + (int)state.iterations;
  }
}