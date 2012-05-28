class Seizure extends Routine {
  int count = 0;
  
  void draw() {
    /*  
    if (count == 0) {
      background(0,0,0);
    }
    else {
      background(255,255,255);
    }
    
    count = (count + 1) % 2;
    */
    
    // Four blinks per second.
    background(frameCount / (int(frameRate)/4) % 2 == 0 ? color(255,128,0) : color(255,64,64));
  }
}
