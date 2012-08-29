class Seizure extends Routine {
  int count = 0;
  
  void draw() {  
    if (count < 2) {
      background(0,0,0);
    }
    else {
      //RGB 252/23/218
      //background(130,130,130);
      background(252,23,218);
    }
    
    count = (count + 1) % 4;

  }
}
