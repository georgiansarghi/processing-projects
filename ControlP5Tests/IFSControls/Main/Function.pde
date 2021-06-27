class Function {
  float a, b, c, d, e, f, p;
  color col;
  boolean active;

  Function() {
    active = false;
    col = color(int(random(0, 128)), int(random(128, 196)), int(random(196, 256)));
  }

  void setA(float a_) {
    a = a_;
  }

  void setB(float b_) {
    b = b_;
  }
  
  void setC(float c_) {
    c = c_;
  }
  
  void setD(float d_) {
    d = d_;
  }
  
  void setE(float e_) {
    e = e_;
  }
  
  void setF(float f_) {
    f = f_;
  }
  
  void setP(float p_) {
    p = p_;
  }
  
  void setActive(boolean active_) {
    active = active_;
  }
}