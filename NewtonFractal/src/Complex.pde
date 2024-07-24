class Complex {
  double re, im;

  Complex() {
    re = 0;
    im = 0;
  }

  Complex(double re_, double im_) {
    re = re_;
    im = im_;
  }


  Complex power(int exp) {
    Complex r = new Complex(re, im);
    
    for (int i = 1; i < exp; i++) {
      r = r.times(this);
      
      //println("**", r.re, r.im);
    }

    return r;
  }



  Complex plus(Complex z) {
    return new Complex(re + z.re, im + z.im);
  }

  Complex plus(int n) {
    return new Complex(re + n, im);
  }


  Complex minus(Complex z) {
    return new Complex(re - z.re, im - z.im);
  }


  Complex minus(int n) {
    return new Complex(re - n, im);
  }

  double distance(Complex z) {
    double dr = z.re - re;
    double di = z.im - im;

    //return sqrt(dr*dr + di*di);
    return dr*dr + di*di;
  }


  Complex divide(Complex z) {
    double a = re, b = im;
    double c = z.re, d = z.im;

    return new Complex((a*c + b*d)/(c*c + d*d), 
      (b*c - a*d)/(c*c + d*d));
  }
  
  Complex times(Complex z) {
    return new Complex(re*z.re - im*z.im, (re + im) * (z.re + z.im) - re*z.re - im*z.im);
  }

  Complex times(double n) {
    return new Complex(re*n, im*n);
  }


  //double getRe() {
  //  return re;
  //}


  //double getIm() {
  //  return im;
  //}
}