PVector[] function;
PVector[] poly;

double S = 100;
int N = 1000;

int degree = 1;
int ord = 1;
int funcode = 1;

void setup() {
  size(900, 900, P2D);
  smooth(16);

  function = new PVector[N+1];
  poly = new PVector[N+1];
  textFont(createFont("Monospaced", 12));
}



void draw() {
  background(255);
  translate(width/2, height/2);
  scale(1, -1);

  evalPolynomial();
  evalFunction();
  displayAxis();
  displayGraph();
}


void evalFunction() {
  for (int i = 0; i < N+1; i++) {
    function[i] = new PVector();
    double x = i * width/S/N - width/S/2;
    double fx = function(x);
    function[i].x = (float)(x * S);
    function[i].y = (float)(fx * S);
  }
}


void evalPolynomial() {
  for (int i = 0; i < N+1; i++) {
    poly[i] = new PVector();
    double x = i * width/S/N - width/S/2;
    double fx = polynomial(x);
    poly[i].x = (float)(x * S);
    poly[i].y = (float)(fx * S);
  }
}



void displayGraph() {

  strokeWeight(1);
  for (int i = 0; i < N; i++) {
    if (abs(poly[i].y) < 1000) {
      stroke(0, 0, 255, 196);
      line(poly[i].x, poly[i].y, poly[i+1].x, poly[i+1].y);
    }
    if(abs(function[i].y) < 1000) {
      stroke(255, 0, 0, 128);
      line(function[i].x, function[i].y, function[i+1].x, function[i+1].y);
    }
  }
}



void displayAxis() {
  stroke(0, 128);
  strokeWeight(1);

  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);

  stroke(0, 32);

  for (int k = (int) (-width/S/2); k <= (int)(width/S/2); k++) {
    line(k*(float)S, -height/2, k*(float)S, height/2);
    line(-width/2, k*(float)S, width/2, k*(float)S);
  }

  fill(0, 128);
  scale(1, -1);
  for (int k = (int) (-width/S/2); k <= (int)(width/S/2); k++) {
    text(k, 5, -k*(float)S - 5);
    text(k, k*(float)S + (float)5, -5);
  }
  text("ord=" + ord, -width/2, -height/2 + 10);
  scale(1, -1);
}


double function(double x) {
  double res = 0;
  // log(1+x)
  if (funcode == 1) {
    ord = degree;
    return log(1+(float)x);
  }
  // sin(x)
  if (funcode == 2) {
    ord = 2*degree + 1;
    return sin((float)x);
  }
  // cos(x)
  if (funcode == 3) {
    ord = 2*degree;
    return cos((float)x);
  }
  // atan()    
  if (funcode == 4) {
    ord = 2*degree + 1;
    return atan((float)x);
  }
  // sinh()
  if (funcode == 5) {
    ord = 2*degree + 1;
    return (exp((float)x)-exp((float)-x))/2;
  }
  // cosh()
  if (funcode == 6) {
    ord = 2*degree;
    return (exp((float)x)+exp((float)-x))/2;
  }
  // exp()
  if (funcode == 0) {
    ord = degree;
    return exp((float)x);
  }

  return res;
}


double polynomial(double x) {
  double res = 0;
  // log(1+x)
  if (funcode == 1)
    for (int i = 1; i <= degree; i++)
      res += powd(-1, i-1)*powd(x, i)/i;
  // sin(x)
  if (funcode == 2)
    for (int i = 0; i <= degree; i++)
      res += powd(-1, i)*powd(x, 2*i+1)/factorial(2*i+1);
  // cos(x)
  if (funcode == 3)
    for (int i = 0; i <= degree; i++)
      res += powd(-1, i)*powd(x, 2*i)/factorial(2*i);
  // atan()    
  if (funcode == 4)
    for (int i = 0; i <= degree; i++)
      res += powd(-1, i)*powd(x, 2*i+1)/(2*i+1);
  // sinh()
  if (funcode == 5)
    for (int i = 0; i <= degree; i++)
      res += powd(x, 2*i+1)/factorial(2*i+1);
  // cosh()
  if (funcode == 6)
    for (int i = 0; i <= degree; i++)
      res += powd(x, 2*i)/factorial(2*i);   
  // exp()   
  if (funcode == 0)
    for (int i = 0; i <= degree; i++)
      res += powd(x, i)/factorial(i);      

  return res;
}

double factorial(int n) {
  if (n < 2) {
    return 1;
  } else {
    return n * factorial(n-1);
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    degree++;
  } else if (keyCode == LEFT) {
    degree--;
  } else if (key == '1') {
    funcode = 1;
  } else if (key == '2') {
    funcode = 2;
  } else if (key == '3') {
    funcode = 3;
  } else if (key == '4') {
    funcode = 4;
  } else if (key == '5') {
    funcode = 5;
  } else if (key == '6') {
    funcode = 6;
  } else if (key == '0') {
    funcode = 0;
  }
  degree = constrain(degree, 0, 30);
}


void mouseWheel(MouseEvent event) {
  double e = event.getCount();
  S -= e;
  S = constrain((int)S, 25, 1000);
}


double powd(double x, int e) {
  double res = 1;
  for(int i = 0; i < e; i++) {
    res *= x;
  }
  return res;
}