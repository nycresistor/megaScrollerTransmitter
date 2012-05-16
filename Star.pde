class Star {
  float x;
  float y;
  int z;
  float s;

  public Star(float s) {
    this.s = s;
    this.reset();
  }

  public void draw() {
    x = x + s;
    if (x>WIDTH*ZOOM)
      this.reset();

    noStroke();
    fill(z);
    rect(x, y, ZOOM, ZOOM);
  }

  public void reset() {
    x = -random(WIDTH*ZOOM);
    y = random(HEIGHT*ZOOM);
    //s = random(ZOOM)+1;
    z = int(s/ZOOM*255);
  }
}

