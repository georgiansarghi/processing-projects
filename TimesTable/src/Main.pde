import controlP5.*;
ControlP5 cp5;

TimesTable T;

float times = 0;
float modulo = 0;
float hue = 0;

float increment = 0.001;

boolean animate = false;

PGraphics frame;

void setup() {
  size(1350, 900, P2D);
  //fullScreen(P2D); 
  frameRate(60);
  noFill();
  colorMode(HSB);

  cp5 = new ControlP5(this);

  frame = createGraphics(width, height);
  T = new TimesTable(times, modulo, 350);
  reset();

  textFont(createFont("Monospaced", 15));

  cp5.addSlider("changeTimes")
    .setLabel("times")
    .setPosition(0, 0)
    .setSize(width-50, 15)
    .setRange(0, 10000)
    //.setNumberOfTickMarks((int)modulo+1)
    .setValue(times);
    
  cp5.addSlider("changeModulo")
    .setLabel("modulo")
    .setPosition(0, 20)
    .setSize(width-50, 15)
    .setRange(0, 10000)
    .setValue(modulo);
    //.setNumberOfTickMarks((int)modulo+1)
}

void draw() {
  background(0);




  T.times = times;
  T.modulo = modulo;
  T.displayTimesTable();

  if(animate)
    times += increment;


  hue += 0.2;
  if (hue > 255) {
    hue = 0;
  }

  text("t:" + times, 15, height - 50);
  text("m:" + modulo, 150, height - 50);
  text("fps:" + frameRate, width-150, height - 50);
}

void reset() {
  T.times = times;
  T.modulo = modulo;
}

void changeTimes(float newvalue) {
  times = (int)newvalue;
}


void changeModulo(float newvalue) {
  modulo = (int)newvalue;
}

void keyPressed() {
  if(key == ' ') {
    animate = !animate;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  T.radius -= e;
  //println(e);
}

void mouseReleased() {
  if(mouseX > width/2) {
    increment += 0.001;
  } else {
    increment -= 0.001;
  }
}
