class WarpSpeedMrSulu extends Routine {
  int NUM_STARS = 500;
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
