boolean zooming = false;

int y0, x0;
int y1, x1;

NewtonFractal L;

ArrayList<NState> states;

int index;

boolean saving = false;

void setup() {
  size(1080, 1080);
//fullScreen();
  textFont(createFont("Monospaced", 10));
  states = new ArrayList<NState>();
  
  reset();
}


void draw() {

  
  image(L.img, 0, 0);
  
  if(saving) {
    save("newton.png");
  }
  stroke(255);
  fill(0, 0, 0);
  text(L.getDescriptionString(), 10, 20);

  if (zooming) {
    noFill();
    rect(x0, y0, mouseX - x0, mouseY - y0);
  }
  
  //noLoop();
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

  states.add(new NState(L.getState()));
  
  if (!L.pushState(x0, y0, x1, y1)) {
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
  } else if(key == 's') {
    saving = true;
  }
}

void reset() {
  states.clear();
  index = 0;
  L = new NewtonFractal(-2, -2, 2, 2, 40);
}