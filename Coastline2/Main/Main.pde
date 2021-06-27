import controlP5.*;

ControlP5 cp5;

Island island;

float iOffset = 128;
int iSides = 4;
float iRadius = 300;
float iScale = .5;
boolean iMode = true;


boolean saving = false;

void setup() {
  //size(960, 960);
  fullScreen();
  
  noStroke();
  island = new Island(iSides, iRadius, iOffset, iScale, iMode);
  cp5 = new ControlP5(this);

  cp5.addSlider("changeOffset")
    .setLabel("offset")
    .setPosition(10, 10)
    .setSize(200, 20)
    .setRange(0, 256)
    .setValue(iOffset);

  cp5.addSlider("changeScaleFactor")
    .setLabel("scale factor")
    .setPosition(10, 50)
    .setSize(200, 20)
    .setRange(0, 1)
    .setValue(iScale);

  cp5.addSlider("changeSides")
    .setLabel("sides")
    .setPosition(10, 90)
    .setSize(200, 20)
    .setRange(3, 12)
    .setValue(iSides)
    .setNumberOfTickMarks(10);

  cp5.addSlider("changeRadius")
    .setLabel("radius")
    .setPosition(10, 130)
    .setSize(200, 20)
    .setRange(10, width/2)
    .setValue(iRadius);


  cp5.addButton("generateButton")
    .setLabel("generate")
    .setPosition(10, 170)
    .setSize(200, 20);

  cp5.addToggle("changeGenerationMode")
    .setLabel("generate all")
    .setPosition(width-70, 10)
    .setSize(60, 20)
    .setValue(iMode);
}



void draw() {
  background(255);
  island.display();
  
  if(saving) {
    saving = false;
    save((int)random(1000) + "island.png");
  }
}

void keyPressed() {
  if(key == 's') {
    saving = true;
  }
}


void changeOffset(float newOffset) {
  island.setOffset(newOffset);
}



void changeSides(float newSides) {
  island.setSides(int(newSides));
}



void changeScaleFactor(float newScaleFactor) {
  island.setScaleFactor(newScaleFactor);
}



void changeRadius(float newRadius) {
  island.setRadius(newRadius);
}



void changeGenerationMode(boolean newMode) {
  island.setGenerationMode(newMode);
}



void generateButton() {
  island.generate();
}