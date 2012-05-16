class Wave {
  private float a;
  private float f;
  private float r;
  private int y;
  private boolean t;
  private float s;

  PGraphics g;

  color c;

  public Wave() {
    init();

    g = createGraphics(WIDTH, HEIGHT, P2D);
  }

  public void init() {
    r = random(TWO_PI);
    f = PI/32 + random(PI/32);
    a = HEIGHT/3 + random(HEIGHT/3);
    y = HEIGHT/8 + int(random(HEIGHT - HEIGHT/8));
    s = PI/128 + random(PI/64);

    if (random(10)<5) { 
      s = -s;
    }
    
    c = color(random(255), random(255), random(255));
  }

  public void draw() {
    float step;
    float h;

    r = r + s;
    if (r > TWO_PI) r = r - TWO_PI;

    step = r;

    g.beginDraw();
    g.background(0);
    g.stroke(c);

    for (int x=0; x<WIDTH; x++) {
      h = sin(step) * a;
      step = step + f;          
      g.line(x, y, x, y+h);
    }

    g.endDraw();

    blend(g, 0, 0, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT, SCREEN);
  }
}    
