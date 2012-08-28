class ColorDrop extends Routine {
  void draw() {
    background(0);
  
    float frame_mult = 3;  // speed adjustment
  
    long frame = frameCount - modeFrameStart;
    
    for(int row = 0; row < height; row++) {
      float phase = sin((float)((row+frame*frame_mult)%height)/height*3.146);
      
      float r = 0;
      float g = 0;
      float b = 0;
      
      
      if((row+frame*frame_mult)%(3*height) < height) {
        r = 255*phase;
        g = 0;
        b = 0;
      }
      else if((row+frame*frame_mult)%(3*height) < height*2) {
        r = 0;
        g = 255*phase;
        b = 0;
      }
      else {
        r = 0;
        g = 0;
        b = 255*phase;
      }
      
      stroke(r,g,b);
      line(0, row, width, row);
    }
    
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
