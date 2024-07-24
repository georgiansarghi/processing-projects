IFS ifs;
boolean saving = false;
void setup() {
  //size(1080, 1600);
  fullScreen();
  background(0);
  stroke(0);



  float x1 = random(1);
  float y1 = random(1);
  ifs = new IFS(x1, y1);

  //ifs.addFunction(new Function(0.85, 0.04, -0.04, 0.85, 0, 1.60, 0.85));//  Successively smaller leaflets
  //ifs.addFunction(new Function(0.20, -0.26, 0.23, 0.22, 0, 1.60, 0.07));//  Largest left-hand leaflet
  //ifs.addFunction(new Function(-0.15, 0.28, 0.26, 0.24, 0, 0.44, 0.07));//  Largest right-hand leaflet
  //ifs.addFunction(new Function(0, 0, 0, 0.16, 0, 0, 0.01));// Stem
  
  //ifs.addFunction(new Function(0.85, 0.04, -0.04, 0.85, 0, 1.60, 0.25));//  Successively smaller leaflets
  //ifs.addFunction(new Function(0.20, -0.26, 0.23, 0.22, 0, 1.60, 0.25));//  Largest left-hand leaflet
  //ifs.addFunction(new Function(-0.15, 0.28, 0.26, 0.24, 0, 0.44, 0.25));//  Largest right-hand leaflet
  //ifs.addFunction(new Function(0, 0, 0, 0.16, 0, 0, 0.25));// Stem

  ifs.addFunction(new Function(0.05, 0, 0, 0.6, 0, 0, 0.17));
  ifs.addFunction(new Function(0.05, 0, 0, -0.5, 0, 1, 0.17));
  ifs.addFunction(new Function(0.46, -0.321, 0.386, 0.383, 0, 0.6, 0.17));
  ifs.addFunction(new Function(0.47, -0.154, 0.171, 0.423, 0, 1.1, 0.17));
  ifs.addFunction(new Function(0.433, 0.275, -0.25, 0.476, 0, 1, 0.16));
  ifs.addFunction(new Function(0.421, 0.257, -0.353, 0.306, 0, 0.7, 0.16));


  //ifs.addFunction(new Function(0.5, 0, 0, 0.5, 0.1, 0.1, .333));
  //ifs.addFunction(new Function(0.5, 0, 0, 0.5, 0.1, 0.5, .333));
  //ifs.addFunction(new Function(0.5, 0, 0, 0.5, 0.5, 0.5, .333));
  
  
  
  //ifs.addFunction(new Function(0.1400, 0.0100, 0.0000, 0.5100, -0.0800, -1.3100, 0.25));
  //ifs.addFunction(new Function(0.4300, 0.5200, -0.4500, 0.5000, 1.4900, -0.7500, 0.25));
  //ifs.addFunction(new Function(0.4500, -0.4900, 0.4700, 0.4700, -1.6200, -0.7400, 0.25));
  //ifs.addFunction(new Function(0.4900 , 0.0000 , 0.0000 , 0.5100 , 0.0200 , 1.6200, 0.25));
  
  
  //ifs.addFunction(new Function(0.824074, 0.281428, -0.212346, 0.864198, -1.882290, -0.110607, 0.8));
  //ifs.addFunction(new Function(0.088272, 0.520988, -0.463889, -0.377778, 0.785360, 8.095795, 0.2));

}

void draw() {
  
  scale(1, -1);
  translate(width/2, -height + 50);
  for (int i = 0; i < 1000; i++) {
    ifs.iterate();
  }
  
  println(frameCount * 10000);
  
  //if(frameCount * 100 == 300000) {
  //  save("stocasticfern.png");
  //}
  
  if(saving) {
    saving = false;
    save("ifs" + (int)random(1000) + ".png");
  }
}

void keyPressed() {
  if(key == 's') {
    saving = true;
  } else if(key == ' ') {
    ifs.resetColors();
    background(255);
    frameCount = 0;
  }
}
