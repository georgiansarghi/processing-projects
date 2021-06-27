import java.math.*;

class Mandelbrot {
  PGraphics mandelbrotImage;
  BigDecimal c;
  float iterations = 256;
  
  float minRe, maxRe;
  float minIm, maxIm;
  float tMinRe, tMaxRe;
  float tMinIm, tMaxIm;
  
  Mandelbrot() {
    minRe = -2;
    maxRe = 2;
    minIm = -2;
    maxIm = 2;
    
    mandelbrotImage = createGraphics(width, height);
  }
  
  void updateComplexBounds(float x0, float y0, float x1, float y1) {
    print("updateComplexBounds()\n");
    print("\t\t(" + x0 + "; " + y0 + ")\n\t\t(" + x1 + "; " + y1 + ")\n\n");
    
    float pw = abs(x1-x0);
    float ph = abs(y1-y0);
    
    if(pw/ph > width/height) {
      print("Its wider: " + pw/ph + " " + width/height + "\n");
      
      tMinRe = map(x0, 0, width, minRe, maxRe);
      tMaxRe = map(x1, 0, width, minRe, maxRe);
      
      float f = map((y1+y0)/2, 0, height, maxIm, minIm);
      
      print("minRe = " + tMinRe + "\n");
      print("maxRe = " + tMaxRe + "\n");
      
      tMinIm = f;
      tMaxIm = f;
      float diff = map((x1-x0) * height / width / 2, 0, height, 0, maxIm-minIm);
      
      //print("Im = " + tMinIm + "\n");
      print("diff = " + diff + "\n");
      
      tMinIm = f - diff;
      tMaxIm = f + diff;
      
      print("minIm = " + tMinIm + "\n");
      print("maxIm = " + tMaxIm + "\n");
    } else {
      print("Its taller: " + pw/ph + " " + width/height + "\n");
      
      tMinIm = map(y1, 0, height, minIm, maxIm);
      tMaxIm = map(y0, 0, height, minIm, maxIm);
      
      float f = map((x0+x1)/2, 0, width, minRe, maxRe);
      
      print("minIm = " + tMinIm + "\n");
      print("maxIm = " + tMaxIm + "\n");
      
      tMinRe = f;
      tMaxRe = f;
      float diff = map((y1-y0) * width / height / 2, 0, width, 0, maxRe-minRe);
      
      //print("Re = " + tMinRe + "\n");
      print("diff = " + diff + "\n");
      
      tMinRe = f - diff;
      tMaxRe = f + diff;
      
      print("minRe = " + tMinRe + "\n");
      print("maxRe = " + tMaxRe + "\n");
    }
    
    minRe = tMinRe;
    maxRe = tMaxRe;
    minIm = tMinIm;
    maxIm = tMaxIm;
    
    updateMandelbrot();
    
  }

  void updateMandelbrot() {
    print("\t\t{" + minRe + "; " + maxRe + ")\n\t\t(" + minIm + "; " + maxIm + "}\n\n");
    //print("updateMandelbrot()\n");
    mandelbrotImage.beginDraw();
    mandelbrotImage.loadPixels();
    
    // render ur mandelbrot man
    for(float pixelY = 0; pixelY < mandelbrotImage.height; pixelY++) {
      for(float pixelX = 0; pixelX < mandelbrotImage.width; pixelX++) {
        int c = blows(map(pixelX, 0, width, minRe, maxRe), map(pixelY, height, 0, minIm, maxIm));
        
      }
    }
    
    mandelbrotImage.updatePixels();
    mandelbrotImage.endDraw();
    print ("**");
  }
  
  int blows(float re, float im) {
    float tz;
    float zre = 0;
    float zim = 0;
    
    for(int i = 0; i < iterations; i++) {
     tz = zre;
     zre = zre*zre-zim*zim + re;
     zim = 2*tz*zim + im;
      
     if(zre*zre + zim*zim >= 4) {
       return 255 - i;
     }
    }
    return 0;
    
    
    //if((re < tMaxRe && re > tMinRe) && (im < tMaxIm && im > tMinIm)) {
    //  return 0;
    //}
    
    //return 255;
  }
  
  PGraphics getImage() {
    return mandelbrotImage;
  }
}