class Routine {
  PApplet parent;  
  public boolean isDone = false;
  boolean aDown = false;
  boolean bDown = false;
  
  void setup(PApplet parent) {
     this.parent = parent;
  }
  
  void predraw() {
    if (controller.buttonB) {
      bDown = true;
    }
    else if (bDown) {
      bDown = false;
      buttonBPressed();
    }
    
    if (controller.buttonA) {
        aDown = true;
    }
    else if (aDown) {
        aDown = false;
        buttonAPressed();
    } 
  }
  
  void buttonBPressed() {
    newMode();
  }
  
  void buttonAPressed() {
  }
  
  void reset() {}
  void draw() {}
  void newmode() {
    isDone = true;
  }
}

