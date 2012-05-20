class WarpStar {
  float x;
  float y;
  float len;
  float v;

  public WarpStar() {
    this.reset();
  }

  public void reset() {
    x = int(random(0, WIDTH));
    y = int(random(0, -100));

    v = random(0, 1);
    len = v * 5;
  }

  public void draw() {
    y = y + v; 

    int r = int(map(y, 0, HEIGHT, 0, 255));
    int g = 0;
    int b = 0;

    stroke(r, g, b);
    point(x, y);

    for (int i=0; i<len; i++) {
      stroke(255 >> i / 2);
      point(x, y - i);
    }

    if (y > HEIGHT) this.reset();
  }
}

