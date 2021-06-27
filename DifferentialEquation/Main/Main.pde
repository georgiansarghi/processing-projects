float S = 500;

VectorField v = new VectorField(50, 50);
ArrayList<IntegralCurve> curves;


void setup() {
  size(1000, 1000);

  curves = new ArrayList<IntegralCurve>();

  //for(int i = 0; i < 100; i++) {
  //  curves.add(new IntegralCurve(convertX(0), convertY(i * height/100)));
  //}
}


void draw() {
  background(255);


  strokeWeight(1);
  displayAxis();
  v.display();


  for (IntegralCurve c : curves) {
    c.display();
  }

  println(frameRate);
}



void displayAxis() {
  stroke(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  fill(0);
  for (int i = 1; i <= 30; i++) {
    text(i, S*i + width/2 + 2, height/2 - 2);
    text(i, width/2 + 2, -S*i + height/2 - 2);
    text(-i, -S*i + width/2 + 2, height/2 - 2);
    text(-i, width/2 + 2, S*i + height/2 - 2);
  }

  //noFill();


  //for (int i = 1; i <= 30; i++) {
  //  stroke(0, 16);
  //  ellipse(width/2, height/2, S*2*i, S*2*i);

  //  stroke(0, 64);
  //  line(width/2 + S*i, 0, width/2 + S*i, height);
  //  line(width/2 - S*i, 0, width/2 - S*i, height);
  //  line(0, height/2 + S*i, width, height/2 + S*i);
  //  line(0, height/2 - S*i, width, height/2 - S*i);
  //}
}



void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  S -= e;
  S = constrain(S, 24, width/2-30);
  //println(e, S);
}



void mousePressed() {
  println(convertX(mouseX), convertY(mouseY));
  curves.add(new IntegralCurve(convertX(mouseX), convertY(mouseY)));
}



float convertX(float mx) {
  return (mx - width/2)/S;
}



float convertY(float my) {
  return (-my + height/2)/S;
}



float f(float x, float y) {
  //if(y == 0 && x > 0) y = 0.0001;
  //return -x/y;
  if (x == y) {
    if(x>0) return 1000;
    if(x<0) return -1000;
  }
  return (x+y)/(x-y);
}