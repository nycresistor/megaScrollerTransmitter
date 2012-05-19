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

