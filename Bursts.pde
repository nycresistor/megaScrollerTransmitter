class Bursts extends Routine {
  int NUMBER_OF_BURSTS = 4;
  Burst[] bursts;
  boolean burst_fill = false;

  void setup(PApplet parent, WiiController controller) {
    super.setup(parent);
    bursts = new Burst[NUMBER_OF_BURSTS];
    for (int i = 0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i] = new Burst();
    }
  }

  void reset() {
    burst_fill = boolean(int(random(1)+0.5));
  }
  
  void draw()
  {
    //  background(0);
  
    for (int i=0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i].draw(burst_fill);
    }
  
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}


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

