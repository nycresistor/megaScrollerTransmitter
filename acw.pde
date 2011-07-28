import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

int WIDTH = 15;
int HEIGHT = 16;
boolean VERTICAL = false;
int FONT_SIZE = HEIGHT;
int FRAMERATE = 30;
String hostname = "127.0.0.1"; //"192.168.1.130";
int TYPICAL_MODE_TIME = 30;

String[] enabledModes = new String[] {
    "drawGreetz",
    "drawBursts",
//    "drawFlash",
//    "drawLines",
//    "drawFader",
//    "drawCurtain",
//    "drawVertLine",
//    "drawSticks",
//    "drawLinesTheOtherWay",
      "drawSpin",
      "drawAnimation",
      "drawWaves"
};

String messages[] = new String[] {
  "DISORIENT",
//  "KOSTUME  KULT",
//  "BLACK  LIGHT  BALL"
  "COUNTRY  CLUB"
};  
String message = "DISORIENT";

String[] enabledAnimations = new String[] {
  "anim-heart"
};
Animation[] animations;
int currentAnimation = 0;

int w = 0;
int x = WIDTH;
PFont font;
int ZOOM = 1;
int NUMBER_OF_STARS = 30;
Star[] stars;

int NUMBER_OF_BURSTS = 4;
Burst[] bursts;

long modeFrameStart;
int mode = 0;
boolean burst_fill = false;

int direction = 1;
int position = 0;
Method currentModeMethod = null;

Dacwes dacwes;

int NUMBER_OF_WAVES = 4;
Wave[] waves;

PGraphics fadeLayer;
int fadeOutFrames = 0;
int fadeInFrames = 0;

void setup() {
  // Had to enable OPENGL for some reason new fonts don't work in JAVA2D.
  size(WIDTH,HEIGHT);
  
  font = loadFont("Disorient-" + FONT_SIZE + ".vlw");
  textFont(font,FONT_SIZE);
  textMode(MODEL);
  frameRate(FRAMERATE);
  
  stars = new Star[NUMBER_OF_STARS];
  for (int i=0; i<NUMBER_OF_STARS; i++) {
    stars[i] = new Star(i*1.0/NUMBER_OF_STARS*ZOOM);
  }
  
  bursts = new Burst[NUMBER_OF_BURSTS];
  for (int i = 0; i<NUMBER_OF_BURSTS; i++) {
    bursts[i] = new Burst();
  }

  dacwes = new Dacwes(this, WIDTH, HEIGHT);
  dacwes.setAddress(hostname);
  dacwes.setAddressingMode(Dacwes.ADDRESSING_VERTICAL_FLIPFLOP);  
 
  if (enabledAnimations.length > 0) {
    animations = new Animation[enabledAnimations.length];
    for (int i=0; i<enabledAnimations.length; i++) {
      animations[i] = new Animation(enabledAnimations[i],4);
    }
  }
  
  if (NUMBER_OF_WAVES > 0) {
    waves = new Wave[NUMBER_OF_WAVES];
    for (int i=0; i<NUMBER_OF_WAVES; i++) {
      waves[i] = new Wave();
    }
  }
  
  setMode(0);  
  
  
  smooth();
}

void setFadeLayer(int g) {
  fadeLayer = createGraphics(WIDTH,HEIGHT,P2D);
  fadeLayer.beginDraw();
  fadeLayer.stroke(g);
  fadeLayer.fill(g);
  fadeLayer.rect(0,0,WIDTH,HEIGHT);
  fadeLayer.endDraw();  
}

void setMode(int newMode) {
  String methodName = enabledModes[newMode];

  mode = newMode;
  modeFrameStart = frameCount;
  println("New mode " + methodName);

  try {
    currentModeMethod = this.getClass().getDeclaredMethod(methodName,new Class[] {});
  }
  catch (Exception e) { e.printStackTrace(); }
  
  // TODO Abstract this into init methods.
  if (methodName == "drawBursts") {
      burst_fill = boolean(int(random(1)+0.5));
  }
  else if (methodName == "drawAnimation") {
    currentAnimation = int(random(animations.length));
    println("Animation set to " + enabledAnimations[currentAnimation]);
  }
}

void newMode() {
  int newMode = mode;
  String methodName;
 
  fadeOutFrames = FRAMERATE;
  setFadeLayer(240);
  if (enabledModes.length > 1) {
    while (newMode == mode) {
      newMode = int(random(enabledModes.length));
    }
  }
  
  setMode(newMode);
}

void draw() {
  if (fadeOutFrames > 0) {
    fadeOutFrames--;
    blend(fadeLayer,0,0,WIDTH,HEIGHT,0,0,WIDTH,HEIGHT,MULTIPLY);
    
    if (fadeOutFrames == 0) {
      fadeInFrames = FRAMERATE;
    }
  }
  else if (currentModeMethod != null) {
    try {
      currentModeMethod.invoke(this);
    }
    catch (Exception e) { e.printStackTrace(); }
  }
  else {
    println("Current method is null");
  }

  if (fadeInFrames > 0) {
    setFadeLayer(240 - fadeInFrames*8);
    blend(fadeLayer,0,0,WIDTH,HEIGHT,0,0,WIDTH,HEIGHT,MULTIPLY);
    fadeInFrames--;
  }
  
  dacwes.sendData();
}

void drawGreetz() {
  background(0);
  fill(255);

  if (w == 0) {
     w = -int((message.length()-1) * (FONT_SIZE*1.35) + WIDTH);
  }
  
  text(message,x,FONT_SIZE);

  if (frameCount % 2 == 0) {
    x = x - 1;
  }
  
  if (x<w) {
    x = WIDTH;  
    message = messages[int(random(messages.length))];
    w = 0;
    newMode();
  }
}

void drawBursts()
{
//  background(0);
  
  for (int i=0; i<NUMBER_OF_BURSTS; i++) {
    bursts[i].draw(burst_fill);
  }

  if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
    newMode();
  }
}


void drawStars() {
  background(0);
  
  for (int i=0; i<NUMBER_OF_STARS; i++) {
    stars[i].draw();
  }
  
  if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
    newMode();
  }
}

void drawFlash() {
  long frame = frameCount - modeFrameStart;
  
  if (frame % (FRAMERATE/5) < 1) {
    background(255);
  }
  else {
    background(0);
  }
  
  if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
    newMode();
  }
}

void drawLines() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;
  int x = int(frame % 5);
  
  for (int i = -x; i<WIDTH; i+=5) {
    line(i,0,i+8,8);
  }
  
  if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
    newMode();
  }
}

void drawLinesTheOtherWay() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;
  int x = int(frame % 5);
  
  for (int i = x-5; i<WIDTH; i+=5) {
    line(i+8,0,i,8);
  }
  
  if (frame > FRAMERATE*5) {
    newMode();
  }
}

void drawVertLine() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;

  if (int(random(10)) == 0)
    direction = -direction;
    
  position += direction;
  if (position < 0)
  {
    direction = 1;
    position = 0;
  }
  if (position >= WIDTH)
  {
    direction = -1;
    position = WIDTH-1;
  }
  
  line(position,0,position,HEIGHT-1);
  
  if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
    newMode();
  }
}

void drawFader() {
  int frame = int(frameCount - modeFrameStart);

  if (frame < 30) {
    background(int(frame % 30 / 30.0 * 255));
  }
  else if (frame >= 30 && frame < 60) {
    int f = 30-(frame-30);
    background(int(f % 30 / 30.0 * 255));
  }
  else if (frame >= 60 && frame < 120) {
    int f = frame-60;
    background(int(f % 30 / 30.0 * 255));
  }      
  else {
    newMode();
  }
}

void drawSticks() 
{  
  int frame = int(frameCount - modeFrameStart);
  int step = frame % WIDTH;
  
  if ((frame / WIDTH) % 2 == 0)
  {
    background(0);
    stroke(255);
  }
  else
  {
    background(255);
    stroke(0);
  }
  
  for (int y = 0; y < HEIGHT; y+=2) {
    line(0,          y,   step,  y);
    line(WIDTH-step, y+1, WIDTH, y+1); 
  }
  
  if (frame >= WIDTH*6)
    newMode();
}

void drawCurtain()
{
  background(0);
  stroke(255);
  
  int frame = int(frameCount - modeFrameStart);
  int step = frame % (WIDTH/2);

  line(step,         0, step,         HEIGHT-1);
  line(WIDTH-step-1, 0, WIDTH-step-1, HEIGHT-1);
  
  if (frame > WIDTH*4) {
    newMode();
  }
}

void drawSpin() 
{  
  background(0);
  stroke(255);

  int frame = int(frameCount - modeFrameStart);
  int step = frame % (WIDTH+HEIGHT-2);
  
  if (step < WIDTH)
    line(step, 0, WIDTH-step-1, HEIGHT-1);
  else
    line(0, HEIGHT-(step-WIDTH+1)-1, WIDTH, step-WIDTH+1); 
  
  if (frame >= (WIDTH+HEIGHT-2)*10)
    newMode();
}

void drawAnimation() {
  boolean done = animations[currentAnimation].draw();
  
  if (done) { 
    newMode(); 
    background(0);
  }
}

void drawWaves() {
  background(0);
  for (int i=0; i<NUMBER_OF_WAVES; i++) {
    waves[i].draw();
  }
  
  long frame = frameCount - modeFrameStart;
  if (frame > frameRate*TYPICAL_MODE_TIME) {
    for (int i=0; i<NUMBER_OF_WAVES; i++) {
      waves[i].init();
    }
    
    newMode();
  }
}

/**
 *
 *
 * =================================================================================================================================
 * =================================================================================================================================
 * =================================================================================================================================
 *
 *
 **/

class Star {
  float x;
  float y;
  int z;
  float s;
  
  public Star(float s) {
    this.s = s;
    this.reset();
  }
  
  public void draw() {
    x = x + s;
    if (x>WIDTH*ZOOM)
      this.reset();
    
    noStroke();
    fill(z);
    rect(x,y,ZOOM,ZOOM);
  }
  
  public void reset() {
    x = -random(WIDTH*ZOOM);
    y = random(HEIGHT*ZOOM);
    //s = random(ZOOM)+1;
    z = int(s/ZOOM*255);
  }
}

class Burst {
  float x;
  float y;
  float d;
  float maxd;
  float speed;
  int intensity;
  
  public Burst()
  {
    init();
  }
  
  public void init()
  {
    x = random(WIDTH);
    y = random(HEIGHT);
    maxd = random(10);
    speed = random(5)/10 + 0.1;
    d = 0;
    intensity = 255;
  }
  
  public void draw(boolean fl)
  {
    if (fl)
      fill(0);
    else
      noFill();
    stroke(intensity);
    ellipse(x, y, d, d);
    d+= speed;
    if (d > maxd)
      intensity -= 15;
      
    if (intensity <= 0)
      init();
  }
}

class Animation {
  public PImage[] frames;
  public int frameNumber;
  int frameDivider;
  
  public Animation(String name, int frameDivider) {
    this.frameNumber = 0;
    this.frameDivider = frameDivider;
    this.load(name);
  }
  
  public void load(String name) {
    File dir = new File(savePath("data/" + name));
    String[] list = dir.list();
    
    frames = new PImage[list.length];
    for (int i=0; i<frames.length; i++) {
       println("Loading " + name + "/frame" + (i+1) + ".png");
       frames[i] = loadImage(name + "/frame" + (i+1) + ".png");
       frames[i].filter(INVERT);
    }
  }
  
  public boolean draw() {
    if (frameCount % frameDivider == 0) {
      frameNumber++;
      if (frameNumber >= frames.length) {
        
        frameNumber = 0;
        return true;
      }
      
      image(frames[frameNumber],0,0,WIDTH,HEIGHT);
    }
    
    return false;
  }
}

class Wave {
    private float a;
    private float f;
    private float r;
    private int y;
    private boolean t;
    private float s;
    
    PGraphics g;
    
    public Wave() {
      init();
      
      g = createGraphics(WIDTH,HEIGHT,P2D);
    }
    
    public void init() {
      r = random(TWO_PI);
      f = PI/32 + random(PI/32);
      a = HEIGHT/3 + random(HEIGHT/3);
      y = HEIGHT/8 + int(random(HEIGHT - HEIGHT/8));
      s = PI/128 + random(PI/64);
      
      if (random(10)<5) { s = -s; }
    }
    
    public void draw() {
      float step;
      float h;
      
      r = r + s;
      if (r > TWO_PI) r = r - TWO_PI;
      
      step = r;
      
      g.beginDraw();
      g.background(0);
      g.stroke(100);
      
      for (int x=0; x<WIDTH; x++) {
         h = sin(step) * a;
         step = step + f;          
         g.line(x,y,x,y+h);
      }
      
      g.endDraw();
      
      blend(g,0,0,WIDTH,HEIGHT,0,0,WIDTH,HEIGHT,SCREEN);
    }
}    
    
    
    
