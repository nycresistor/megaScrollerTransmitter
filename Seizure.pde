class Seizure extends Routine {
  int count = 0;
  
  void draw() {  
    if (count < 2) {
      background(0,0,0);
    }
    else {
      background(255,255,255);
    }
    
    count = (count + 1) % 4;

  }
}
