class CoastlineLine {
  public PVector start;
  public PVector end;
  public float offset;
  public float scale;

  public CoastlineLine(PVector a, PVector b, float o, float s) {
    start = a.copy();
    end = b.copy();
    offset = o;
    scale = s;
  }

  public ArrayList<CoastlineLine> getNext() {
    ArrayList<CoastlineLine> next = new ArrayList<CoastlineLine>();
    PVector p = new PVector();

    p.x = (start.x + end.x) / 2 + (random(2) * offset - offset);
    p.y = (start.y + end.y) / 2 + (random(2) * offset - offset);

    next.add(new CoastlineLine(start, p, offset*scale, scale));
    next.add(new CoastlineLine(p, end, offset*scale, scale));

    return next;
  }

  public void display() {
    line(start.x, start.y, end.x, end.y);
  }
}