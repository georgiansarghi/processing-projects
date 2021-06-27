ComplexPoint input;

PVector prev;
float S = 400;

int opc = 0;
int pow = 1;

void setup() {
  size(1000, 1000, P2D);
  prev = new PVector();
  input = new ComplexPoint(random(width/2)/S, random(height/2)/S, 5);

  input.text = "w";

  textFont(createFont("Monospaced", 12));
  smooth(8);
}



void draw() {
  background(255);

  displayAxis();

  scale(1, -1);
  translate(0, -height);
  translate(width/2, height/2);

  input.display();

  float r = log(abs(input.re));
  float h = input.angle();

  for (int k = -10; k < 10; k += 1) {
    ComplexPoint cp = new ComplexPoint(r, h + 2*k*PI);
    cp.display();
  }

  /*
  float h = input.angle()/pow;
   float m = pow(input.magnitude(), 1./pow);
   for(int i = 0; i < pow; i++) {
   ComplexPoint cp = new ComplexPoint(cos(h)*m, sin(h)*m);
   h += PI*2 / pow;
   cp.display();
   }*/
}

void displayAxis() {
  stroke(0, 64);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  fill(0, 128);
  for (int i = 1; i <= 30; i++) {
    text(i, S*i + width/2 + 2, height/2 - 2);
    text(i, width/2 + 2, -S*i + height/2 - 2);
    text(-i, -S*i + width/2 + 2, height/2 - 2);
    text(-i, width/2 + 2, S*i + height/2 - 2);
  }

  noFill();
  stroke(0, 32);

  for (int i = 1; i <= 30; i++) {
    ellipse(width/2, height/2, S*2*i, S*2*i);
  }
}




void mouseDragged() {
  if (input.grabbed) {
    input.re = input.re - (prev.x-mouseX(mouseX));
    input.im = input.im - (prev.y-mouseY(mouseY));
  }

  prev.x = mouseX(mouseX);
  prev.y = mouseY(mouseY);
}




float distSq(float a, float b, float c, float d) {
  return (a-b)*(a-b) + (c-d)*(c-d);
}



float mouseX(int mx) {
  mx -= width/2;
  return (float)mx/S;
}



float mouseY(int my) {
  my -= height/2;
  return -(float)my/S;
}



void mouseReleased() {
  if (input.grabbed) {
    input.grabbed = false;
  }

  prev.x = 0;
  prev.y = 0;
}



void mouseClicked() {
  println(mouseX(mouseX), mouseY(mouseY));
}



void mousePressed() {
  if (distSq(mouseX(mouseX), input.re, mouseY(mouseY), input.im) < input.radius*input.radius/S/S) {
    input.grabbed = true;
  }

  prev.x = mouseX(mouseX);
  prev.y = mouseY(mouseY);
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  S -= e;
  S = constrain(S, 24, width/2-30);
  println(e, S);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    pow += 1;
  }
  if (keyCode == LEFT) {
    pow -= 1;
  }

  pow = constrain(pow, 1, 100);
}