class DropTheBomb extends Routine {
  float bombX;
  float bombY;
  float bombSpeed;
  float flashSpeed;
  float flashBrightness;
  float blastRadius;
  float blastSpeed;
  
  void setup(PApplet parent) {
    super.setup(parent);
    bombSpeed = height / (frameRate*3);
    flashSpeed = 255 / (frameRate*1);   
    blastSpeed = max(width,height) / (frameRate*5);
  }    
    
  void reset() {
    bombX = random(width);
    bombY = 0;
    flashBrightness = 255;    
    blastRadius = 0;
  }
  
  void draw() {
    if (bombY < height) {
      drawBomb();
      bombY += bombSpeed;
    }
    else if (flashBrightness > 0) {
      drawFlash();
      flashBrightness -= flashSpeed;
    }
    else if (blastRadius/2 < width || blastRadius/2 < height) {
      drawBlast();
      blastRadius += blastSpeed;
    }
    else {
      newMode();
    }
  }
  
  void drawBomb() {
    int c = 255;
    background(0);
    
    for (int i=0; i<5; i++) {
      stroke(c);
      point(bombX,bombY-i);
      c = c - 32;
    }
  }
  
  void drawFlash() {
    colorMode(HSB);
    background(0, 255 - flashBrightness, flashBrightness);
    colorMode(RGB);
  }
  
  void drawBlast() {
    noStroke();
    rectMode(CENTER);
    background(0);
    for (int i=0; i<5; i++) {    
      fill(255-(i*16),64-(i*4),32-(i*2));
      ellipseMode(CENTER);
      rect(0,height,width*2,blastRadius/(i+1));
    }
  }
}
