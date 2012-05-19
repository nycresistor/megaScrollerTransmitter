class Greetz extends Routine {
  int FONT_SIZE = 16;
  PFont font;
  PImage imgCopy;
  String messages[] = new String[] {
    "N Y C R"//, 
    //  "KOSTUME  KULT",
    //  "BLACK  LIGHT  BALL"
  //  "COUNTRY  CLUB"
  };  
  String message = "N Y C R";

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
    text(message, x, FONT_SIZE);
  
    if (height/2 > FONT_SIZE) {
      
      image(get(0,0,width,FONT_SIZE),0,20,width,height/2);
      fill(0);
      rect(0,0,width,FONT_SIZE);
      //copy(0,0,width,FONT_SIZE,0,FONT_SIZE,width,FONT_SIZE/2);
      //imgCopy = copy(0,0,width,FONT_SIZE);
      //image(imgCopy,0,0,width,height);
    }
    
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
