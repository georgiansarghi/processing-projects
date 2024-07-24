class LandscapeLine {
  public PVector start;
  public PVector end;
  public float offset;
  public float scale;

  public LandscapeLine(PVector a, PVector b, float o, float s) {
    start = a.copy();
    end = b.copy();
    offset = o;
    scale = s;
  }

  public ArrayList<LandscapeLine> getNext() {
    ArrayList<LandscapeLine> next = new ArrayList<LandscapeLine>();
    PVector p = new PVector();

    p.x = (start.x + end.x) / 2;
    p.y = (start.y + end.y) / 2 + (random(2) * offset - offset);

    next.add(new LandscapeLine(start, p, offset*scale, scale));
    next.add(new LandscapeLine(p, end, offset*scale, scale));

    return next;
  }

  public void display() {
    line(start.x, start.y, end.x, end.y);
  }
}