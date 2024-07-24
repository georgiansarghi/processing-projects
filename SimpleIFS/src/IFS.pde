class IFS {
  ArrayList<Function> system;
  float cx, cy;
  color colors[];
  int colorindex = 0;

  IFS(float x, float y) {
    cx = x;
    cy = y;
    system = new ArrayList<Function>();
    colors = new color[20];
    resetColors();
  }

  void addFunction(Function f) {
    system.add(f);
  }

  void iterate() {
    Function f = getFunction();

    float x1 = f.a*cx + f.b*cy + f.tx;
    float y1 = f.c*cx + f.d*cy + f.ty;
    stroke(colors[colorindex]);
    point(x1 * 5*90, y1 * 5 * 90);
    
    cx = x1;
    cy = y1;
  }

  Function getFunction() {
    //return system.get(int(random(3)));

    float r = random(1);
    int index = 0;
    for (Function f : system) {
      if (r < f.weight) {
        colorindex = index;
        return f;
      }
      index++;
      r -= f.weight;
    }

    return null;
  }






  void resetColors() {
    for (int i = 0; i < 20; i++) {
      colors[i] = color(random(256), random(256), random(256), 64);
    }
  }
}
