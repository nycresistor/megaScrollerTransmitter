class WarpSpeedMrSulu extends Routine {
  int NUM_STARS = 200;
  WarpStar[] warpstars;

  void setup(PApplet parent) {
    super.setup(parent);
    warpstars = new WarpStar[NUM_STARS];
    for (int i = 0; i<NUM_STARS; i++) {
      warpstars[i] = new WarpStar();
    }
  }
  
  void draw() {
    background(0);
    stroke(255);
    
    for (int i=0; i<NUM_STARS; i++) {
      warpstars[i].draw();
    }
   
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    } 
  }


}


class WarpStar {
  float x;
  float y;
  float len;
  float v;
  
  float r;
  float g;
  float b;

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
    //RGB 252/23/218 
    //r = int(map(y, 0, HEIGHT, 0, 255));
    //g = 0;
    //b = 0;
    //r = 252;
    //g = 23;
    //b = 218;
    r = random(232,255);
    g = random(03,43);
    b = random(198,238);

    stroke(r, g, b);
    point(x, y);

    for (int i=0; i<len; i++) {
      float intensity = 255 >> i / 2;
      
      fill(color(r,g,b));
      stroke(color(r,g,b));
      //stroke(intensity);
      point(x, y - i);
    }

    if (y > HEIGHT) this.reset();
  }
}

