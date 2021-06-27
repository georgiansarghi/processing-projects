class ComplexPoint {
  float re, im;
  float radius;
  boolean grabbed = false;
  color clr;
  String text = "";
  boolean visible = false;

  ComplexPoint(float x_, float y_, float r_) {
    re = x_;
    im = y_;
    radius = r_;
    clr = color(random(255), random(255), random(255), 128);
  }

  ComplexPoint(float x_, float y_) {
    re = x_;
    im = y_;
    radius = 5;
    clr = color(random(255), random(255), random(255), 128);
  }

  ComplexPoint() {
    re = 0;
    im = 0;
    radius = 5;
    clr = color(random(255), random(255), random(255), 128);
  }




  void display() {
    fill(clr, 128);
    stroke(clr);
    ellipse(re*S, im*S, radius*2, radius*2);


    line(re*S, im*S, 0, 0);
    
    fill(0);
    scale(1, -1);
    text(text, re*S + 5, -im*S - 5);
    scale(1, -1);
    
    
    fill(clr, 64);
    randomSeed(clr);
    float wh = random(0.2, 0.5)*S*2;

    float a = angle();
    if (a < 0) {
      arc(0, 0, wh, wh, 0, PI);
      arc(0, 0, wh, wh, -PI, a);
    } else {
      arc(0, 0, wh, wh, 0, a);
    }
  }



  float angle() {
    return new PVector(re, im).heading();
  }




  ComplexPoint power(int exp) {
    ComplexPoint r = new ComplexPoint(re, im);

    for (int i = 1; i < exp; i++) {
      r = r.times(this);
      //println("**", r.re, r.im);
    }

    return r;
  }



  ComplexPoint plus(ComplexPoint z) {
    return new ComplexPoint(re + z.re, im + z.im);
  }

  ComplexPoint plus(int n) {
    return new ComplexPoint(re + n, im);
  }


  ComplexPoint minus(ComplexPoint z) {
    return new ComplexPoint(re - z.re, im - z.im);
  }


  ComplexPoint minus(int n) {
    return new ComplexPoint(re - n, im);
  }

  double distance(ComplexPoint z) {
    double dr = z.re - re;
    double di = z.im - im;

    //return sqrt(dr*dr + di*di);
    return dr*dr + di*di;
  }


  ComplexPoint divide(ComplexPoint z) {
    float a = re, b = im;
    float c = z.re, d = z.im;

    return new ComplexPoint((a*c + b*d)/(c*c + d*d), 
      (b*c - a*d)/(c*c + d*d));
  }

  ComplexPoint times(ComplexPoint z) {
    return new ComplexPoint(re*z.re - im*z.im, re*z.im + im*z.re);
  }

  ComplexPoint times(float n) {
    return new ComplexPoint(re*n, im*n);
  }

  float magnitude() {
    return sqrt(re*re + im*im);
  }

  float getRe() {
    return re;
  }


  float getIm() {
    return im;
  }
}