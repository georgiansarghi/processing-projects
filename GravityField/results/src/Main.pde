import controlP5.*; //<>// //<>//

ControlP5 cp5;

int iterations = 128;
//
float maxy = 1.5;
float miny = -1.5;
float maxx = 1.5;
float minx = -1.5;
// pls, try having the same ratios


float sbre, sbim;


boolean saving = false;

void setup() {

  size(720, 720);
//fullScreen();
textFont(createFont("Monospaced", 10));

  //colorMode(HSB);

  cp5 = new ControlP5(this);

  cp5.addSlider("changeReal")
    .setLabel("")
    //.setLabelVisible(false)
    .setSize(width-20, 20)
    .setPosition(10, 10)
    .setRange(minx, maxx);

  cp5.addSlider("changeImaginary")
  .setLabel("")
    //.setLabelVisible(false)
    .setSize(width-20, 20)
    .setPosition(10, 35)
    .setRange(miny, maxy);
}

void draw() {
  loadPixels();

  for (float i = 0; i < width; i++) {
    for (float j = 0; j < height; j++) {

      float re = map(i, 0, width, minx, maxx);
      float im = map(j, 0, height, miny, maxy);

      float c = blows(re, im, iterations);
      //if (c == 0) {
      //  pixels[(int)(i + j*width)] = color(0);
      //} else {
        if(c == 0)
          pixels[(int)(i + j*width)] = color(0);
        else {
          pixels[(int)(i + j*width)] = color((c*c*c*c) * 256);
        }
          
      //}
    }
  }


  updatePixels();
  
  
  //fill(0);
  //text((float)((int)(sbre*1000))/1000. + " + " + (float)((int)(sbim*1000))/1000. + " i", 0, 10);
  
  if(saving) {
    saveFrame("julia_" + (int)(sbre*1000) + "_" + (int)(sbim*1000) + ".png");
    saving = false;
  }
}

float blows(float re, float im, int it) {
  float tz;
  float zre = re;
  float zim = im;

  for (int i = 0; i < it; i++) {
    tz = zre;
    zre = zre*zre-zim*zim + sbre;
    zim = 2*tz*zim + sbim;

    if (zre*zre + zim*zim >= 4) {
      return map(i, 0, it, 1, 0);
    }
  }
  return 0;
}

void changeReal(float value) {
  sbre = value;
}

void changeImaginary(float value) {
  sbim = value;
}

void keyPressed() {
  if(key == 's') {
    saving = true;
  }
} 