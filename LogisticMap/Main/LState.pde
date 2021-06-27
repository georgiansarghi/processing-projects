public class LState {

  public double minR;
  public double minX;
  public double maxR;
  public double maxX;
  public double iterations;
  
  
  public LState() {
  }
  
  
  public LState(LState m) {
    this.minR = m.minR;
    this.minX = m.minX;
    this.maxR = m.maxR;
    this.maxX = m.maxX;
    this.iterations = m.iterations;
  }
}