class Waterfalls extends Routine {
  int NUMBER_OF_WATERFALLS = 20;
  Waterfall[] waterfalls;

  void setup(PApplet parent) {
    super.setup(parent);
    waterfalls = new Waterfall[NUMBER_OF_WATERFALLS];
    for (int i = 0; i<NUMBER_OF_WATERFALLS; i++) {
      waterfalls[i] = new Waterfall();
    }
  }
  
  void draw() {
    background(0);
    stroke(255);
    
    for (int i=0; i<NUMBER_OF_WATERFALLS; i++) {
      waterfalls[i].draw();
    }
   
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    } 
  }


}
