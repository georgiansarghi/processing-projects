public class JState {

  public double minRe;
  public double minIm;
  public double maxRe;
  public double maxIm;
  public double iterations;
  public boolean hsb;
  
  
  public JState() {
  }
  
  
  public JState(JState m) {
    this.minRe = m.minRe;
    this.minIm = m.minIm;
    this.maxRe = m.maxRe;
    this.maxIm = m.maxIm;
    this.iterations = m.iterations;
    this.hsb = m.hsb;
  }
}