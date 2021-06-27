int beginX, beginY;
boolean zoomRectActive = false;

Mandelbrot M;

void setup() {
  background(255);
  size(512, 512);
  
  M = new Mandelbrot();
  M.updateMandelbrot();
  
}

void draw() {
  
  //M.updateMandelbrot();
  image(M.getImage(), 0, 0);
  
  if(zoomRectActive) {
    noFill();
    rect(beginX, beginY, mouseX-beginX, mouseY-beginY);
  }
 
}

void mousePressed() {
  zoomRectActive = true;
  beginX = mouseX;
  beginY = mouseY;
}

void mouseReleased() {
  zoomRectActive = false;
  M.updateComplexBounds(beginX, beginY, mouseX, mouseY);
}