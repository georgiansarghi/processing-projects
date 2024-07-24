public class NState {

  public double minRe;
  public double minIm;
  public double maxRe;
  public double maxIm;
  public double iterations;
  
  
  public NState() {
  }
  
  
  public NState(NState m) {
    this.minRe = m.minRe;
    this.minIm = m.minIm;
    this.maxRe = m.maxRe;
    this.maxIm = m.maxIm;
    this.iterations = m.iterations;
  }
}