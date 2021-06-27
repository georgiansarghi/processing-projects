class Simple2DTransform {
  float a, b, c, d, e, f;
  float angle, sx, sy, tx, ty;

  Simple2DTransform(float angle_, float sx_, float sy_, float tx_, float ty_) {
    angle = angle_;
    sx = sx_;
    sy = sy_;
    tx = tx_;
    ty = ty_;
  }

  PVector transform(PVector p0) {
    PVector p1 = new PVector();

    p1.x = p0.x * sx * cos(angle) - p0.y * sy * sin(angle) + tx;
    p1.y = p0.x * sx * sin(angle) + p0.y * sy * cos(angle) + ty;

    return p1;
  }

  void setAngle(float angle_) {
    angle = angle_;
  }

  void setTx(float tx_) {
    tx = tx_;
  }
  
  void setTy(float ty_) {
    ty = ty_;
  }
  
  void setSx(float sx_) {
    sx = sx_;
  }
  
  void setSy(float sy_) {
    sy = sy_;
  }
}