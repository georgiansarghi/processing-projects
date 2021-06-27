int beginX, beginY;
boolean zoomRectActive = false;

Mandelbrot M;

void setup() {
  size(768, 768);
  
  stroke(255, 0, 0);
  noFill();
  
  M = new Mandelbrot();
  
  textFont(createFont("Monospaced", 15));
  updateScreen();
}

void draw() {
  if (zoomRectActive) {
    updateScreen();
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
  updateScreen();
}

void updateScreen() {
  image(M.getImage(), 0, 0);
  fill(255, 70, 0);
  text(M.getBoundsString(), 10, 20);
  noFill();
}