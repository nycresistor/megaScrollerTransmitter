class Bursts extends Routine {
  int NUMBER_OF_BURSTS = 16;
  Burst[] bursts;

  void setup(PApplet parent) {
    super.setup(parent);
    bursts = new Burst[NUMBER_OF_BURSTS];
    for (int i = 0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i] = new Burst();
    }
  }

  void reset() {
  }
  
  void draw()
  {
      background(0,0,20);
  
    for (int i=0; i<NUMBER_OF_BURSTS; i++) {
      bursts[i].draw();
    }
  
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}


class Burst {
  float x;
  float y;
  float xv;
  float yv;
  float d;
  float maxd;
  float speed;
  int intensity;
  float r;
  float g;
  float b;

  public Burst()
  {
    init();
  }

  public void reset()
  {
    r = random(128)+128;
    g = random(128)+128;
    b = random(128)+128;

    x = random(WIDTH);
    y = random(HEIGHT);

    float max_speed = 3;
    xv = random(max_speed) - max_speed/2;
    yv = random(max_speed) - max_speed/2;
    
    maxd = random(12);
    speed = random(5)/10 + 0.2;
    d = 0;
    intensity = 255;
  }

  public void init()
  {
    reset();
  }

  public void draw()
  {
    fill(color(r,g,b));
    stroke(color(r,g,b));
    ellipse(x, y, d*(1+3.0*y/HEIGHT), d*3);
    ellipse(x-WIDTH, y, d*(1+3.0*y/HEIGHT), d*3);
    ellipse(x+WIDTH, y, d*(1+3.0*y/HEIGHT), d*3);
    d+= speed;
    if (d > maxd)
      r -= 15;
      g -= 15;
      b -= 15;
      intensity -= 15;
      
    x +=xv;
    y +=yv;

    if (intensity <= 0) {
      reset();
    }
  }
}

