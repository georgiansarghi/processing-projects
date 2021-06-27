import java.text.*;

boolean zooming = false;

int x0, y0;
int x1, y1;

Mandelbrot M;

ArrayList<MState> states;
int index;

boolean saving = false;
boolean changing = false;

NumberFormat formatter = new DecimalFormat("#0.000");   

void setup() {
  //size(1080, 720);
  fullScreen();

  colorMode(HSB);
  textFont(createFont("Monospaced", 10));
  states = new ArrayList<MState>();

  reset();
  frameRate(30);
}


void draw() {
  stroke(255, 0, 0);
  fill(255, 0, 0);

  image(M.img, 0, 0);
  
  if (saving) {
    saving = false;
    //M.img.save(formatter.format(M.state.minRe) + "_" + formatter.format(M.state.maxIm) + "man.png");
    M.img.save(M.state.minRe + "_" + M.state.maxIm + "man.png");
  }
  
  
  text(M.getDescriptionString(), 10, 20);
  text(M.numIterations + " iterations in " + M.updateTime + "s", 10, height-20);

  if (zooming) {
    noFill();
    rect(x0, y0, mouseX - x0, mouseY - y0);
  }


  if (changing) {
    M.updateColors();
  }
  
  println((4/(M.state.maxRe-M.state.minRe))/100000);
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

  states.add(new MState(M.getState()));

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
  } else if (key == 'h') {
    M.flipHSB();
  } else if (key == ' ') {
    reset();
  } else if (key == 's') {
    saving = true;
  } else if (key == 'c') {
    M.colorShift = random(255);
    M.update();
  } else if (key == 't') {
    changing = !changing;
  }
}

void reset() {
  states.clear();
  index = 0;
  M = new Mandelbrot(-2, -2, 2, 2, 256);
}