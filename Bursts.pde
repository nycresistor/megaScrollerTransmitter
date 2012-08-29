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
    //r = random(128)+128;
    //g = random(128)+128;
    //b = random(128)+128;
    // naim hack (PORNJ Pink: RGB 252/23/218) 
    r = random(220,255);
    g = random(0,55);
    b = random(210,230);
    //r = random(128);
    //g = random(118);
    //b = random(128);
   
    x = random(WIDTH);
    y = random(HEIGHT);

    float max_speed = 2;
    xv = random(max_speed) - max_speed/2;
    yv = random(max_speed) - max_speed/2;
    
    maxd = random(12);
    speed = random(5)/10 + 0.4;
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
    ellipse(x, y,       d*(.5-.3*y/HEIGHT), d*3);
    ellipse(x-WIDTH, y, d*(.5-.3*y/HEIGHT), d*3);
    ellipse(x+WIDTH, y, d*(.5-.3*y/HEIGHT), d*3);
    d+= speed;
    if (d > maxd) {
      // day
      r -= 2;
      g -= 2;
      b -= 2;
      intensity -= 4;
      //night
//      r -= 1;
//      g -= 1;
//      b -= 1;
//      intensity -= 3;
    }
    
    x +=xv;
    y +=yv;

    if (intensity <= 0) {
      reset();
    }
  }
}

