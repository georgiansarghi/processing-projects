import peasy.*;

PeasyCam cam;

int N = 129;
int sidepx = 2048;
PVector[][] S;

void setup() {
  size(800, 800, P3D);
  colorMode(HSB);

  cam = new PeasyCam(this, width);

  S = new PVector[N][N];

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      float ii = (float)i/(N-1) * sidepx - sidepx/2;
      float jj = (float)j/(N-1) * sidepx - sidepx/2;
      S[i][j] = new PVector(ii, jj, 0);
      println(ii, jj);
    }
  }
}

float d = 0.001;
float o = 10000;
float t = 0;

void draw() {
  background(0);
  stroke(255);
  noStroke();
  strokeWeight(1);
  fill(0, 0, 255, 128);


  for (int i = 0; i < N-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < N; j++) {
      //fill(map(noise(S[i][j].x * d + o, S[i][j].y * d + o, t), 0, 1, 64, 255), 255, 255);
      //vertex(S[i][j].x, S[i][j].y, 600 * noise(S[i][j].x * d + o, S[i][j].y * d + o, t) - 300);
      //fill(map(noise(S[i+1][j].x * d + o, S[i+1][j].y * d + o, t), 0, 1, 64, 255), 255, 255);
      //vertex(S[i+1][j].x, S[i+1][j].y, 600 * noise(S[i+1][j].x * d + o, S[i+1][j].y * d + o, t) - 300);

      fill(map(noise(S[i][j].x * d + t, S[i][j].y * d + t), 0, 1, 64, 255), 255, 255);
      vertex(S[i][j].x, S[i][j].y, 600 * noise(S[i][j].x * d + t, S[i][j].y * d + t) - 300);
      fill(map(noise(S[i+1][j].x * d + t, S[i+1][j].y * d + t), 0, 1, 64, 255), 255, 255);
      vertex(S[i+1][j].x, S[i+1][j].y, 600 * noise(S[i+1][j].x * d + t, S[i+1][j].y * d + t) - 300);
    }
    endShape();
  }

  t += 0.005;
  
  println(frameRate);
}