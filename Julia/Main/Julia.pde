public class Julia {
  public JState state;
  public PImage img;

  public double updateTime;
  public int numIterations;

  public Julia(double r0, double i0, double r1, double i1, double it) {
    state = new JState();
  
    state.minRe = r0;
    state.minIm = i0;
    state.maxRe = r1;
    state.maxIm = i1;
    state.hsb = false;
    
    if(height/width > 1) {
      state.minIm *= (double)(height) / width;
      state.maxIm *= (double)(height) / width;
    } else {
      state.minRe *= (double)(width) / height;
      state.maxRe *= (double)(width) / height;
    }

    state.iterations = it;

    img = createImage(width, height, RGB);
    
    update();
  }

  public boolean pushState(double x0, double y0, double x1, double y1) {
    if ((x1-x0) == 0 || (y1-y0) == 0) {
      return false;
    }

    double t, offset;
    if (x0 < x1 && y0 > y1) {
      t = y0;
      y0 = y1;
      y1 = t;
    } else if (x0 > x1 && y0 < y1) {
      t = x0;
      x0 = x1;
      x1 = t;
    } else if (x0 > x1 && y0 > y1) {
      t = x0;
      x0 = x1;
      x1 = t;
      t = y0;
      y0 = y1;
      y1 = t;
    }

    if ((x1-x0)/(y1-y0) > width/height) {
      double tminRe = doubleMap(x0, 0, width, state.minRe, state.maxRe);
      state.maxRe = doubleMap(x1, 0, width, state.minRe, state.maxRe);
      state.minRe = tminRe;

      double imCenter = doubleMap((y1+y0)/2, 0, height, state.maxIm, state.minIm);
      offset = doubleMap((x1-x0) * height / width / 2, 0, height, 0, state.maxIm-state.minIm);

      state.minIm = imCenter - offset;
      state.maxIm = imCenter + offset;
    } else {
      double tminIm = doubleMap(y1, height, 0, state.minIm, state.maxIm);
      state.maxIm = doubleMap(y0, height, 0, state.minIm, state.maxIm);
      state.minIm = tminIm;

      double reCenter = doubleMap((x0+x1)/2, 0, width, state.minRe, state.maxRe);    
      offset = doubleMap((y1-y0) * width / height / 2, 0, width, 0, state.maxRe-state.minRe);

      state.minRe = reCenter - offset;
      state.maxRe = reCenter + offset;
    }

    update();

    return true;
  }
  
  public void setState(JState s) {
    state = s;
    update();
  }
  
  public JState getState() {
    return state;
  }

  public void update() {
    long startTime = System.nanoTime();
    numIterations = 0;
    
    img.loadPixels();

    for (double py = 0; py < height; py++) {
      for (double px = 0; px < width; px++) {
        double re = doubleMap(px, 0, width, state.minRe, state.maxRe);
        double im = doubleMap(py, height, 0, state.minIm, state.maxIm);

        double c = iterate(re, im, state.iterations);
        numIterations += c;
        if(c == state.iterations) {
          img.pixels[(int)(px + py * width)] = color(0, 0, 0);
        } else {
          if(state.hsb) {
            img.pixels[(int)(px + py * width)] = color(/*(int)doubleMap(c, 0, state.iterations, 255, 0)*/(int)c, 200, 255);
          } else {
            img.pixels[(int)(px + py * width)] = color((int)doubleMap(c, 0, state.iterations, 255, 0));
          }
        }
      }
    }

    img.updatePixels();
    long endTime = System.nanoTime();
    updateTime = (double)(endTime - startTime)/1000000000;
    
  }

  public double iterate(double re, double im, double it) {
    double tz;
    double zre = 0;
    double zim = 0;

    for (double i = 0; i < it; i++) {
      tz = zre;
      zre = zre*zre-zim*zim + re;
      zim = 2*tz*zim + im;

      if (zre*zre + zim*zim >= 4) {
        return i;
      }
    }

    return state.iterations;
  }

  public void changeIterations(boolean up) {
    if (up)
      state.iterations = (state.iterations * 1.33333);
    else
      state.iterations = (state.iterations * 0.66666);
      
   state.iterations = max((float)state.iterations, 1);
   update();
  }
  
  public void flipHSB() {
    state.hsb = !state.hsb;
    update();
  }

  public double doubleMap(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }

  public String getDescriptionString() {
    return "x0 = " + state.minRe + ", y0 = " + state.maxIm +
      "i\nx1 = " + state.maxRe + ", y1 = " + state.minIm + "i\n" +
      "iterations = " + (int)state.iterations;
  }
}