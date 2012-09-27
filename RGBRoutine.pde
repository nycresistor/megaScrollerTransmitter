class RGBRoutine extends Routine {
  int color_angle = 0;
  
  void draw() {
    background(0);
  
    for (int row = 0; row < displayHeight; row++) {
      for (int col = 0; col < displayWidth; col++) {
        float r = (((row)*2          + 100.0*col/displayWidth   + color_angle  +   0)%100)*(255.0/100);
        float g = (((row)*2          + 100.0*col/displayWidth   + color_angle  +  33)%100)*(255.0/100);
        float b = (((row)*2          + 100.0*col/displayWidth   + color_angle  +  66)%100)*(255.0/100);
        
        stroke(r,g,b);
        point(col,row);
      }
    }
    
    color_angle = (color_angle+1);//%255;


    long frame = frameCount - modeFrameStart;
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}
