class Greetz extends Routine {
  int FONT_SIZE = 16;
  PFont font;
  String messages[] = new String[] {
    "DISORIENT"//, 
    //  "KOSTUME  KULT",
    //  "BLACK  LIGHT  BALL"
  //  "COUNTRY  CLUB"
  };  
  String message = "DISORIENT";

  void setup(PApplet parent) {
    super.setup(parent);
    font = loadFont("Disorient-" + FONT_SIZE + ".vlw");
    textFont(font, FONT_SIZE);
    textMode(MODEL);
  }
 
  void draw() {
    background(0);
    fill(255);
  
    if (w == 0) {
      w = -int((message.length()-1) * (FONT_SIZE*1.35) + WIDTH);
    }
    
    fill(255,128,64);
    pushMatrix();
      rotate(HALF_PI);
      text(message, x, 0);
    popMatrix();
    
    PImage i = get(0,40-FONT_SIZE,WIDTH,FONT_SIZE);
    i.resize(WIDTH,FONT_SIZE*6);
    image(i,0,40-FONT_SIZE);
  
    if (frameCount % 2 == 0) {
      x = x - 1;
    }
  
    if (x<w) {
      x = HEIGHT;  
      message = messages[int(random(messages.length))];
      w = 0;
      newMode();
    }
  }
}
