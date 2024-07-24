LSystem lsys;
Turtle turtle;

boolean saving = false;
boolean generateAgain = true;

void setup() {
  size(1000, 1000);
  
  colorMode(HSB);
  Rule[] ruleset = new Rule[2];
  //ruleset[0] = new Rule('X', "-YF+XFX+FY-");
  //ruleset[1] = new Rule('Y', "+XF-YFY-FX+"); // hilbert
  
  //ruleset[0] = new Rule('F', "F+F-F-FFF+F+F-F");
  
  //ruleset[0] = new Rule('F', "F-F++F-F");
  
  //ruleset[0] = new Rule('X', "X+YF+");
  //ruleset[1] = new Rule('Y', "-FX-Y"); // dragon
  
  
  lsys = new LSystem("FX", ruleset);
  turtle = new Turtle(lsys.getSentence(), 1, radians(90));
 //strokeWeight(2);
  smooth(8);
}

void draw() {
  if(generateAgain) {
    background(0);
    fill(0);
    translate(width/2, height/2);
    rotate(-PI/2);
    turtle.render();
    generateAgain = false;
  }
  
  if(saving) {
    saving = false;
    save("lsys.png");
  }

}

void keyPressed() {
  if (key == ' ') {
    lsys.generate();
    turtle.setToDo(lsys.getSentence());
    turtle.changeLen(1);
    generateAgain = true;
  } if(key == 's') {
    saving = true;
  }
}
