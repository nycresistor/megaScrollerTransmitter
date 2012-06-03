import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//import codeanticode.gsvideo.*;
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

int WIDTH = 24;
int HEIGHT = 160;
boolean VERTICAL = false;
int FRAMERATE = 100;
String hostname = "127.0.0.1"; //"192.168.1.130";
int TYPICAL_MODE_TIME = 300;
Routine drop = new Seizure();
Routine pong = new Pong();

Routine[] enabledRoutines = new Routine[] {
// new Warp(new WarpSpeedMrSulu(), false, true, 0.25, 0.25)
//  new Warp(null, true, false, 0.5, 0.5)
/*  new Bursts(),
  new Flash(),
  new Lines(),
  new OppositeLines(),
  new Waves(),
  new RadialStars(),
  new NightSky(),
  new TargetScanner(),
  new Waterfalls(),
  new RGBRoutine(),
  new FlashColors(),
  new FollowMouse()
  new Greetz()*/
  new Fire()
};

int w = 0;
int x = WIDTH;
PFont font;
int ZOOM = 1;

long modeFrameStart;
int mode = 0;

int direction = 1;
int position = 0;
Routine currentRoutine = null;

Sculpture sculpture;

PGraphics fadeLayer;
int fadeOutFrames = 0;
int fadeInFrames = 0;

WiiController controller;

void setup() {
  // Had to enable OPENGL for some reason new fonts don't work in JAVA2D.
  size(WIDTH,HEIGHT);

  frameRate(FRAMERATE);
  
  sculpture = new Sculpture(this, WIDTH, HEIGHT, true);
  sculpture.setAddress(hostname);
  sculpture.setAddressingMode(Sculpture.ADDRESSING_HORIZONTAL_NORMAL);  
  sculpture.setEnableGammaCorrection(true);

  setMode(0);  
    
  controller = new WiiController();
  
  for (Routine r : enabledRoutines) {
    r.setup(this);
  }  
}

void setFadeLayer(int g) {
  fadeLayer = createGraphics(WIDTH, HEIGHT, P2D);
  fadeLayer.beginDraw();
  fadeLayer.stroke(g);
  fadeLayer.fill(g);
  fadeLayer.rect(0, 0, WIDTH, HEIGHT);
  fadeLayer.endDraw();
}

void setMode(int newMode) {
  currentRoutine = enabledRoutines[newMode];

  mode = newMode;
  modeFrameStart = frameCount;
  println("New mode " + currentRoutine.getClass().getName());
  
  currentRoutine.reset();
}

void newMode() {
  int newMode = mode;
  String methodName;

  fadeOutFrames = FRAMERATE;
  setFadeLayer(240);
  if (enabledRoutines.length > 1) {
    while (newMode == mode) {
      newMode = int(random(enabledRoutines.length));
    }
  }

  setMode(newMode);
}

void draw() {
  if (((keyPressed && key == '1') || (controller.buttonOne && controller.buttonTwo)) && currentRoutine != pong) {
    currentRoutine = pong;
    pong.setup(this);
  }

  if (controller.buttonA || (keyPressed && key == 'a')) {
    drop.draw();
  }
  else {
  
    if (fadeOutFrames > 0) {
      fadeOutFrames--;
      blend(fadeLayer, 0, 0, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT, MULTIPLY);

      if (fadeOutFrames == 0) {
        fadeInFrames = FRAMERATE;
      }
    }
    else if (currentRoutine != null) {
      currentRoutine.predraw();
      currentRoutine.draw();
    }
    else {
      println("Current method is null");
    }

    if (fadeInFrames > 0) {
      setFadeLayer(240 - fadeInFrames*8);
      blend(fadeLayer, 0, 0, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT, MULTIPLY);
      fadeInFrames--;
    }

    if (currentRoutine.isDone) {
      currentRoutine.isDone = false;
      newMode();
    }
  }
  
//  }
  
//  println(frameRate);
  sculpture.sendData();  
}

