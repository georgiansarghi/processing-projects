int order = 1;
int maxSize = 6;

int[][] curve;

float cellSize;

void setup() {
  size(512, 512);
  cellSize = width/maxSize;
  curve = new int[maxSize][maxSize];
}

void draw() {
  stroke(255, 0, 0);
  for(int i = 0; i < maxSize; i++) {
    for(int j = 0; j < maxSize; j++) {
      if(curve[i][j] == 0) {
        fill(0);
      } else {
        fill(255);
      }
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }  
}