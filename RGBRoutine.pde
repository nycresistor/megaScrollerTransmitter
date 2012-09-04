//class RGBRoutine extends Routine {
//  int color_angle = 0;
//  
//  void draw() {
//    background(0);
//  
//    for (int row = 0; row < height; row++) {
//      for (int col = 0; col < width; col++) {
//        float r = (((row)*2          + 100.0*col/WIDTH   + color_angle  +   0)%100)*(255.0/100);
//        float g = (((row)*2          + 100.0*col/WIDTH   + color_angle  +  33)%100)*(255.0/100);
//        float b = (((row)*2          + 100.0*col/WIDTH   + color_angle  +  66)%100)*(255.0/100);
//        
//        stroke((r*2+g)/(b/ran),(g*2+b)/(r*r),(b*2+r)/(g/20)));
//        point(col,row);
//      }
//    }
//    
//    color_angle = (color_angle+1);//%255;
//
//
//    long frame = frameCount - modeFrameStart;
//    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
//      newMode();
//    }
//  }
//}
