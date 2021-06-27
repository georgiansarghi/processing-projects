public class NewtonFractal {

  public NState state;
  public PImage img;
  ArrayList<Complex> solutions;

  public double updateTime;
  public int numIterations;

  float shade;

  public NewtonFractal(double r0, double i0, double r1, double i1, double it) {
    state = new NState();

    state.minRe = r0;
    state.minIm = i0;
    state.maxRe = r1;
    state.maxIm = i1;
    state.iterations = it;

    if (height/width > 1) {
      state.minIm *= (double)(height) / width;
      state.maxIm *= (double)(height) / width;
    } else {
      state.minRe *= (double)(width) / height;
      state.maxRe *= (double)(width) / height;
    }
    solutions = new ArrayList<Complex>();

    solutions.add(new Complex(1, 0));
    solutions.add(new Complex(-.5, sqrt(3)/2));
    solutions.add(new Complex(-.5, -sqrt(3)/2));

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
      double tminRe = dmap(x0, 0, width, state.minRe, state.maxRe);
      state.maxRe = dmap(x1, 0, width, state.minRe, state.maxRe);
      state.minRe = tminRe;

      double imCenter = dmap((y1+y0)/2, 0, height, state.maxIm, state.minIm);
      offset = dmap((x1-x0) * height / width / 2, 0, height, 0, state.maxIm-state.minIm);

      state.minIm = imCenter - offset;
      state.maxIm = imCenter + offset;
    } else {
      double tminIm = dmap(y1, height, 0, state.minIm, state.maxIm);
      state.maxIm = dmap(y0, height, 0, state.minIm, state.maxIm);
      state.minIm = tminIm;

      double reCenter = dmap((x0+x1)/2, 0, width, state.minRe, state.maxRe);    
      offset = dmap((y1-y0) * width / height / 2, 0, width, 0, state.maxRe-state.minRe);

      state.minRe = reCenter - offset;
      state.maxRe = reCenter + offset;
    }

    update();

    return true;
  }



  public void setState(NState s) {
    state = s;
    update();
  }



  public NState getState() {
    return state;
  }




  public void update() {
    long startTime = System.nanoTime();
    numIterations = 0;

    img.loadPixels();

    for (double py = 0; py < height; py++) {
      for (double px = 0; px < width; px++) {
        double re = dmap(px, 0, width, state.minRe, state.maxRe);
        double im = dmap(py, height, 0, state.minIm, state.maxIm);

        int c = iterate(new Complex(re, im), state.iterations);
        numIterations += c;

        if (c == 0) {

          img.pixels[(int)(px + py * width)] = color(shade, 0, 0);
          //break;
        } else if (c == 1) {
          img.pixels[(int)(px + py * width)] = color(0, shade, 0);
        } else if (c == 2) {
          img.pixels[(int)(px + py * width)] = color(0, 0, shade);
        }
      }
      //break;
    }

    img.updatePixels();

    long endTime = System.nanoTime();
    updateTime = (double)(endTime - startTime)/1000000000;
  }




  public int iterate(Complex z, double it) {
    shade = (float)it;
    double d;
    boolean exit = false;
    for (int i = 0; i < it; i++) {
      z = z.minus(popp(z));


      for (Complex s : solutions) {
        d = z.distance(s);
        if (d < 0.001) {
          shade = map(i, 0, (float)it, 255, 0);
          exit = true;
          break;
        }
      }

      if (exit) {
        break;
      }
    }

    double d1 = z.distance(solutions.get(0));
    double d2 = z.distance(solutions.get(1));
    double d3 = z.distance(solutions.get(2));

    if (d1 < d2 && d1 < d3) {
      return 0;
    } else if (d2 < d1 && d2 < d3) {
      return 1;
    } else if (d3 < d1 && d3 < d2) {
      return 2;
    }

    println(d1, d2, d3);
    return 0;
  }


  //p over p'
  Complex popp(Complex z) {
    Complex r = z.power(3).minus(1).divide(z.power(2).times(3)).times(1);
    //println("\t\t", r.re, r.im);
    return r;
  }


  public void changeIterations(boolean up) {
    if (up)
      state.iterations = (state.iterations * 1.33333);
    else
      state.iterations = (state.iterations * 0.66666);

    state.iterations = max((float)state.iterations, 1);
    update();
  }

  public double dmap(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }



  public String getDescriptionString() {
    return "x0 = " + state.minRe + ", y0 = " + state.maxIm +
      "i\nx1 = " + state.maxRe + ", y1 = " + state.minIm + "i\n" +
      "iterations = " + (int)state.iterations;
  }
}