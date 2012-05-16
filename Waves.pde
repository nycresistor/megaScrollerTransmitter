class Waves extends Routine {
  
  int NUMBER_OF_WAVES = 4;
  Wave[] waves;

  void setup(PApplet parent) {
    super.setup(parent);
    if (NUMBER_OF_WAVES > 0) {
      waves = new Wave[NUMBER_OF_WAVES];
      for (int i=0; i<NUMBER_OF_WAVES; i++) {
        waves[i] = new Wave();
      }
    }
  }
  
  void draw() {
    background(0);
    for (int i=0; i<NUMBER_OF_WAVES; i++) {
      waves[i].draw();
    }
  
    long frame = frameCount - modeFrameStart;
    if (frame > frameRate*TYPICAL_MODE_TIME) {
      for (int i=0; i<NUMBER_OF_WAVES; i++) {
        waves[i].init();
      }
  
      newMode();
    }
  }
}

