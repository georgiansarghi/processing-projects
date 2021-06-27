class Mandelbrot {
  PGraphics mandelbrotImage;
  int iterations = 512;
  double minRe, maxRe;
  double minIm, maxIm;
  
  
  
  Mandelbrot() {
    double ratio = width/height;
    
    minRe = -2;
    maxRe = 0.5;
    minIm = -1.25;
    maxIm = 1.25;
    
    mandelbrotImage = createGraphics(width, height);
    updateMandelbrot();
  }
  
  
  
  void updateComplexBounds(int x0, int y0, int x1, int y1) {
    if(x0 < x1 && y0 > y1) {
      int t;
      t = y0;
      y0 = y1;
      y1 = t;
    } else if(x0 > x1 && y0 < y1) {
      int t;
      t = x0;
      x0 = x1;
      x1 = t;
    } else if(x0 > x1 && y0 > y1) {
      int t;
      t = x0;
      x0 = x1;
      x1 = t;
      t = y0;
      y0 = y1;
      y1 = t;
    }
    
    if((x1-x0)/(y1-y0) > width/height) {
      double tMinRe = doubleMap(x0, 0, width, minRe, maxRe);
      maxRe = doubleMap(x1, 0, width, minRe, maxRe);
      minRe = tMinRe;
      
      double imCenter = doubleMap((y1+y0)/2, 0, height, maxIm, minIm);
      double offset = doubleMap((x1-x0) * height / width / 2, 0, height, 0, maxIm-minIm);
     
      minIm = imCenter - offset;
      maxIm = imCenter + offset;
    } else {
      double tMinIm = doubleMap(y1, height, 0, minIm, maxIm);
      maxIm = doubleMap(y0, height, 0, minIm, maxIm);
      minIm = tMinIm;
      
      double reCenter = doubleMap((x0+x1)/2, 0, width, minRe, maxRe);    
      double offset = doubleMap((y1-y0) * width / height / 2, 0, width, 0, maxRe-minRe);
  
      minRe = reCenter - offset;
      maxRe = reCenter + offset;
    }
    
    M.updateMandelbrot();
  }



  void updateMandelbrot() {
    mandelbrotImage.beginDraw();
    mandelbrotImage.loadPixels();
    
    for(double pixelY = 0; pixelY < mandelbrotImage.height; pixelY++) {
      for(double pixelX = 0; pixelX < mandelbrotImage.width; pixelX++) {
        double re = doubleMap(pixelX, 0, width, minRe, maxRe);
        double im = doubleMap(pixelY, height, 0, minIm, maxIm);
        int c = iterate(re, im);
        
        if(c == -1) {
          mandelbrotImage.pixels[(int)(pixelY * width + pixelX)] = color(0);
        } else {
          mandelbrotImage.pixels[(int)(pixelY * width + pixelX)] = color((int)intMap(c, 0, iterations, 255, 0));
        }
        
      }
    }
    
    mandelbrotImage.updatePixels();
    mandelbrotImage.endDraw();
  }
  
  
  
  int iterate(double re, double im) {
    double tz;
    double zre = 0;
    double zim = 0;
    
    for(int i = 0; i < iterations; i++) {
     tz = zre;
     zre = zre*zre-zim*zim + re;
     zim = 2*tz*zim + im;
      
     if(zre*zre + zim*zim >= 4) {
       return i;
     }
    }
    
    return -1;
  }
  
  
  
  PGraphics getImage() {
    return mandelbrotImage;
  }
  
  
  
  public double doubleMap(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }
  
  public double intMap(int value, int start1, int stop1, int start2, int stop2) {
    return start2 + (double)(stop2 - start2) * (double)((value - start1) / (double)(stop1 - start1));
  }
  
  public String getBoundsString() {
    return "x0 = " + minRe + ", y0 = " + maxIm + "i\nx1 = " + maxRe + ", y1 = " + minIm + "i";
  }
}