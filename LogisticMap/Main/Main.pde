boolean zooming = false;

int r0, x0;
int r1, x1;

LogisticMap L;

ArrayList<LState> states;

int index;

void setup() {
  size(960, 720);

  textFont(createFont("Monospaced", 10));
  states = new ArrayList<LState>();
  
  reset();
}


void draw() {
  stroke(255, 0, 0);
  fill(255, 0, 0);
  
  image(L.img, 0, 0);
  
  text(L.getDescriptionString(), 10, 20);

  if (zooming) {
    noFill();
    rect(r0, x0, mouseX - r0, mouseY - x0);
  }
}



void mousePressed() {
  zooming = true;

  r0 = mouseX;
  x0 = mouseY;
}

void mouseReleased() {
  zooming = false;

  r1 = mouseX;
  x1 = mouseY;

  states.add(new LState(L.getState()));
  
  if (!L.pushState(r0, r1, x0, x1)) {
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
      L.setState(states.get(index));
      states.remove(index);
    }
  } else if (keyCode == UP) {
    L.changeIterations(true);
  } else if (keyCode == DOWN) {
    L.changeIterations(false);
  } else if(key == ' ') {
    reset();
  }
}

void reset() {
  states.clear();
  index = 0;
  L = new LogisticMap(3, 4, 0, 1, 128);
}