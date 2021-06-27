import controlP5.*;

ControlP5 cp5;
ArrayList<Group> controls;
ArrayList<Function> system;
int nf = 0;

int groupSize;
int n = 6;
float scale;

float sx, sy;

PGraphics ifsg;

int maxnpoints = 100000000;
int npoints;

int adjustX, adjustY;


void setup() {
  size(960, 720);
  ifsg = createGraphics(width, height);
  reset();

  adjustX = width/2;
  adjustY = height/2;

  cp5 = new ControlP5(this);
  groupSize = width/n;
  controls = new ArrayList<Group>();
  system = new ArrayList<Function>();

  for (int i = 0; i < n; i++) {
    system.add(new Function());
  }

  sx = random(width);
  sy = random(height);

  //cp5.addButton("addFunction")
  //  .setLabel("add function")
  //  .setPosition(0, height-20)
  //  .setSize(groupSize, 20);

  //cp5.addButton("removeFunction")
  //  .setLabel("remove last function")
  //  .setPosition(width-groupSize, height-20)
  //  .setSize(groupSize, 20);


  for (int i = 0; i < n; i++) {
    addFunction();
  }
  
  
  cp5.addSlider("zoom")
    .setLabelVisible(false)
    .setPosition(groupSize+10, height-20)
    .setRange(1, 1001)
    .setSize(width - 2*groupSize - 20, 20)
    .setValue(100);
}



void draw() {
  //sx = random(-1, 1);
  //sy = random(-1, 1);

  //ifsg.beginDraw();
  //ifsg.pushMatrix();

  //ifsg.translate(width/2, height/2);
  //ifsg.scale(1, -1);
  //ifsg.stroke(0);
  //ifsg.point(sx*100, sy*100);
  //ifsg.endDraw();
  //ifsg.popMatrix();

  image(ifsg, 0, 0);
  if (nf != 0 && npoints < maxnpoints) {
    iterate(250);
    npoints += 250;
  }


  // println(npoints, maxnpoints, nf, n, random(1));
}



void iterate(int it) {
  for (int i = 0; i < it; i++) {
    iterate();
  }
}



void iterate() {
  Function f = getFunction();

  if (f != null) { 
    float x1 = f.a*sx + f.b*sy + f.e;
    float y1 = f.c*sx + f.d*sy + f.f;

    ifsg.beginDraw();
    ifsg.pushMatrix();

    ifsg.translate(adjustX, adjustY);
    ifsg.scale(1, -1);
    ifsg.stroke(f.col);
    ifsg.point(x1*scale, y1*scale);
    ifsg.endDraw();
    ifsg.popMatrix();

    sx = x1;
    sy = y1;
  } else {
    println("Something wrong..");
  }
}



Function getFunction() {
  float tp = 0;

  for (Function f : system) {
    if (f.active) {
      tp += f.p;
    } else {
      break;
    }
  }

  float rp = random(tp);

  for (Function f : system) {
    if (f.active) {
      if (rp < f.p) {
        return f;
      }
      rp -= f.p;
    } else {
      break;
    }
  }

  return null;
}



void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    String name = theEvent.getController().getName();
    if (name.length() == 2) {
      float value = theEvent.getController().getValue();
      char letter = name.charAt(0);
      char number = name.charAt(1);

      switch(letter) {
      case 'a':
        system.get(number-49).setA(value);
        break;
      case 'b':
        system.get(number-49).setB(value);
        break;
      case 'c':
        system.get(number-49).setC(value);
        break;
      case 'd':
        system.get(number-49).setD(value);
        break;
      case 'e':
        system.get(number-49).setE(value);
        break;
      case 'f':
        system.get(number-49).setF(value);
        break;
      case 'p':
        system.get(number-49).setP(value);
        break;
      default:
        println("I sholdn't be here, LOL", letter);
      }

      reset();
    }
  }
}



void addFunction() {
  int ng = controls.size();
  if (ng < n) {
    Group g = cp5.addGroup("w" + (ng+1))
      .setPosition((ng) * groupSize, 10)
      .setBackgroundHeight(110)
      .setWidth(groupSize)
      .setBackgroundColor(color(128, 128))
      .activateEvent(true);


    cp5.addSlider("a" + (ng+1))
      .setLabel("a" + (ng+1))
      .setPosition(10, 5)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("b" + (ng+1))
      .setLabel("b" + (ng+1))
      .setPosition(10, 20)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("c" + (ng+1))
      .setLabel("c" + (ng+1))
      .setPosition(10, 35)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("d" + (ng+1))
      .setLabel("d" + (ng+1))
      .setPosition(10, 50)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("e" + (ng+1))
      .setLabel("e" + (ng+1))
      .setPosition(10, 65)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("f" + (ng+1))
      .setLabel("f" + (ng+1))
      .setPosition(10, 80)
      .setSize(groupSize-30, 10)
      .setRange(-1, 1)
      .setGroup(g);

    cp5.addSlider("p" + (ng+1))
      .setLabel("p" + (ng+1))
      .setPosition(10, 95)
      .setSize(groupSize-30, 10)
      .setRange(0, 1)
      .setValue(1)
      .setGroup(g);

    controls.add(g);
    system.get(nf++).setActive(true);
  }
}



//void removeFunction() {
//  if (!controls.isEmpty()) {
//    controls.get(controls.size()-1).remove();
//    controls.remove(controls.size()-1);
//    system.get(--nf).setActive(false);
//  }
//}


void keyPressed() {
  if (key == '1') {
    //cp5.saveProperties(("1.properties"));
  } else if (key == 'q') {
    cp5.loadProperties(("1.properties"));
  } else if (keyCode == UP) {
    adjustY -= 10;
    reset();
  } else if (keyCode == DOWN) {
    adjustY += 10;
    reset();
  } else if (keyCode == LEFT) {
    adjustX -= 10;
    reset();
  } else if (keyCode == RIGHT) {
    adjustX += 10;
    reset();
  }
}

void zoom(float zoomValue) {
  scale = zoomValue;
  reset();
}

void reset() {
  ifsg.beginDraw();
  ifsg.background(255);
  ifsg.endDraw();
  npoints = 0;
}