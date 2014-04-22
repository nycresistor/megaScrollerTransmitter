class ColorDrop extends Routine {
  void draw() {
    background(0);

    float frame_mult = 3;  // speed adjustment

    // lets add some jitter
    modeFrameStart = modeFrameStart - min(0,int(random(-5,12)));

    long frame = frameCount - modeFrameStart;


    for(int row = 0; row < displayHeight; row++) {
      float phase =
        sin((float)((row + frame * frame_mult) % displayHeight) /
          displayHeight * 3.146 + random(0, .6)
        );

      float r = 0;
      float g = 0;
      float b = 0;


      if ((row + frame * frame_mult) % (3 * displayHeight) < displayHeight) {
        r = 255 * phase;
        g = 0;
        b = 0;
      }
      else if((row + frame * frame_mult) % (3 * displayHeight) < displayHeight * 2) {
        r = 0;
        g = 255 * phase;
        b = 0;
      }
      else {
        r = 0;
        g = 0;
        b = 255 * phase;
      }

      stroke(r, g, b);
      line(0, row, displayWidth, row);
    }

    if (frame > FRAMERATE * TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}
