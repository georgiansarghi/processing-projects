import controlP5.*;

ControlP5 cp5;

boolean zooming = false;

int x0, y0;
int x1, y1;

Julia M;

ArrayList<JState> states;
int index;

void setup() {
  size(960, 720);
  cp5 = new ControlP5(this);
  
  colorMode(HSB);
  textFont(createFont("Monospaced", 10));
  states = new ArrayList<JState>();

  cp5.addSlider("changeRe")
    .setLabel("real")
    .setPosition(10, 10)
    .setSize(200, 20)
    .setRange(-2, 2)
    .setValue(0);


  reset();
}


void draw() {
  stroke(255, 0, 0);
  fill(255, 0, 0);

  image(M.img, 0, 0);

  text(M.getDescriptionString(), 10, 20);
  text(M.numIterations + " iterations in " + M.updateTime + "s", 10, height-20);

  if (zooming) {
    noFill();
    rect(x0, y0, mouseX - x0, mouseY - y0);
  }
}



void mousePressed() {
  zooming = true;

  x0 = mouseX;
  y0 = mouseY;
}

void mouseReleased() {
  zooming = false;

  x1 = mouseX;
  y1 = mouseY;

  states.add(new JState(M.getState()));

  if (!M.pushState(x0, y0, x1, y1)) {
    print("Errore, intervallo troppo piccolo!\n");
    states.remove(index);
  } else {
    index++;
  }
}

void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (index > 0) {
      index--;
      M.setState(states.get(index));
      states.remove(index);
    }
  } else if (keyCode == UP) {
    M.changeIterations(true);
  } else if (keyCode == DOWN) {
    M.changeIterations(false);
  } else if(key == 'h') {
    M.flipHSB();
  } else if (key == ' ') {
    reset();
  }
}

void reset() {
  states.clear();
  index = 0;
  M = new Julia(-2, -2, 2, 2, 128);
}