import java.text.*; //<>//

int iterations = 128;
float maxy = 2;
float miny = -2;
float maxx = 2;
float minx = -2;

boolean saving = false;

float sre, sim;
float osre, osim;

PImage mandelbrot;
PImage julia;

// formattazione text(s, x, y)
NumberFormat formatter = new DecimalFormat("#0.000");

void setup() {
  size(1680, 840);

  textFont(createFont("Monospaced", 10));
  
  noStroke();
  fill(255, 0, 0);

  mandelbrot = createImage(width/2, height, RGB);
  drawMandelbrot();

  julia = createImage(width/2, height, RGB);
}

void draw() {
  osre = sre;
  osim = sim;

  sre = map(mouseX, width/2, width, minx, maxx);
  sim = map(mouseY, 0, height, maxy, miny);

  

  if (osre != sre || osim != sim) {
    drawJulia();
    image(julia, 0, 0);
    image(mandelbrot, width/2, 0);
    text(formatter.format(sre), 0, height);
    text(formatter.format(sim) + " i", 50, height);
  }
  
  fill(255, 0, 0);
  noStroke();
  ellipse(mouseX, mouseY, 5, 5);
  noFill();
  stroke(255, 0, 0);
  ellipse(mouseX, mouseY, 35, 35);

  if (saving) {
    saveFrame("julia_" + (int)(sre*1000) + "_" + (int)(sim*1000) + ".png");
    saving = false;
  }

  println(frameRate);
}



void drawJulia() {
  julia.loadPixels();
  for (float i = 0; i < width/2; i++) {
    for (float j = 0; j < height; j++) {
      float re = map(i, 0, width/2, minx, maxx);
      float im = map(j, 0, height, miny, maxy);

      float c = blows(re, im, iterations);

      if (c == 0)
        julia.pixels[(int)(i + j*width/2)] = color(0);
      else {
        julia.pixels[(int)(i + j*width/2)] = color((c*c) * 256);
      }
    }
  }
  julia.updatePixels();
}



float blows(float re, float im, int it) {
  float tz;
  float zre = re;
  float zim = im;

  for (int i = 0; i < it; i++) {
    tz = zre;
    zre = zre*zre-zim*zim + sre;
    zim = 2*tz*zim + sim;

    if (zre*zre + zim*zim >= 4) {
      return map(i, 0, it, 1, 0);
    }
  }

  return 0;
}


void drawMandelbrot() {
  mandelbrot.loadPixels();
  for (float i = 0; i < width/2; i++) {
    for (float j = 0; j < height; j++) {
      float re = map(i, 0, width/2, minx, maxx);
      float im = map(j, 0, height, miny, maxy);

      float c = blows2(re, im, iterations);

      if (c == 0)
        mandelbrot.pixels[(int)(i + j*width/2)] = color(0);
      else {
        mandelbrot.pixels[(int)(i + j*width/2)] = color(c * 256);
      }
    }
  }
  mandelbrot.updatePixels();
}


float blows2(float re, float im, int it) {
  float tz;
  float zre = 0;
  float zim = 0;

  for (int i = 0; i < it; i++) {
    tz = zre;
    zre = zre*zre-zim*zim + re;
    zim = 2*tz*zim + im;

    if (zre*zre + zim*zim >= 4) {
      return map(i, 0, it, 1, 0);
    }
  }

  return 0;
}


void keyPressed() {
  if (key == 's') {
    saving = true;
  }
}
