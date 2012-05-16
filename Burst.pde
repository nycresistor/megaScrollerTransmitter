class Burst {
  float x;
  float y;
  float d;
  float maxd;
  float speed;
  int intensity;

  public Burst()
  {
    init();
  }

  public void init()
  {
    x = random(WIDTH);
    y = random(HEIGHT);
    maxd = random(10);
    speed = random(5)/10 + 0.1;
    d = 0;
    intensity = 255;
  }

  public void draw(boolean fl)
  {
    if (fl)
      fill(0);
    else
      noFill();
    stroke(intensity);
    ellipse(x, y, d, d);
    d+= speed;
    if (d > maxd)
      intensity -= 15;

    if (intensity <= 0)
      init();
  }
}

