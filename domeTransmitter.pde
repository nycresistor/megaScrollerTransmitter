import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

// This should be 127.0.0.1, 58802
String transmit_address = "127.0.0.1";
int transmit_port       = 58082;


// Display configuration
int displayWidth = 40;
int displayHeight = 160;

boolean VERTICAL = false;
int FRAMERATE = 25;
int TYPICAL_MODE_TIME = 300;

float bright = .1;  // Global brightness modifier

Routine drop = new Seizure();
Routine pong = new Pong();
Routine backupRoutine = null;

Routine[] enabledRoutines = new Routine[] {
  //  new Animator("anim-nyancat",10,.2,0,0,-10),
  new Bursts(), 
  //  new Chase(),
  new ColorDrop(), 
  //  new DropTheBomb(),
  new FFTDemo(), 
  //  new Fire(),
  //  new Greetz(),
  new RGBRoutine(), 
  new RainbowColors(), 
  new Warp(null, true, false, 0.5, 0.5), 
  new Warp(new WarpSpeedMrSulu(), false, true, 0.5, 0.5), 
  new Waves(),
};

int w = 0;
int x = displayWidth;
PFont font;
int ZOOM = 1;

long modeFrameStart;
int mode = 0;


int direction = 1;
int position = 0;
Routine currentRoutine = null;

LEDDisplay sign;

PGraphics fadeLayer;
int fadeOutFrames = 0;
int fadeInFrames = 0;

WiiController controller;

void setup() {
  size(displayWidth, displayHeight);

  frameRate(FRAMERATE);

  sign = new LEDDisplay(this, displayWidth, displayHeight, true, transmit_address, transmit_port);
  sign.setAddressingMode(LEDDisplay.ADDRESSING_HORIZONTAL_NORMAL);  
  sign.setEnableGammaCorrection(true);

  setMode(0);  

  controller = new WiiController();

  for (Routine r : enabledRoutines) {
    r.setup(this);
  }  

  drop.setup(this);
}

void setFadeLayer(int g) {
  fadeLayer = createGraphics(displayWidth, displayHeight, P2D);
  fadeLayer.beginDraw();
  fadeLayer.stroke(g);
  fadeLayer.fill(g);
  fadeLayer.rect(0, 0, displayWidth, displayHeight);
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

boolean switching_mode = false; // if true, we already switched modes, so don't do it again this frame (don't freeze the display if someone holds the b button)
int seizure_count = 0;  // Only let seizure mode work for a short time.

void draw() {
  if (!controller.buttonB) {
    switching_mode = false;
  }

  if (controller.buttonA) {
    seizure_count += 1;
  }
  else {
    seizure_count = 0;
  }


  // Jump into seizure mode
  if ((controller.buttonA || (keyPressed && key == 'a')) && currentRoutine != drop && seizure_count == 1) {
    //drop.draw();
    backupRoutine = currentRoutine;
    currentRoutine = drop;
    drop.reset();
  }
  // Drop out of seizure mode
  else if (!controller.buttonA && currentRoutine == drop) {
    currentRoutine = backupRoutine;
  }
  else if (seizure_count > 10 && currentRoutine == drop) {
    currentRoutine = backupRoutine;
  }
  else if ((controller.buttonB || (keyPressed && key == 'c')) && !switching_mode) {
    newMode();
    switching_mode = true;
  }
  else {
    if (fadeOutFrames > 0) {
      fadeOutFrames--;
      blend(fadeLayer, 0, 0, displayWidth, displayHeight, 0, 0, displayWidth, displayHeight, MULTIPLY);

      if (fadeOutFrames == 0) {
        fadeInFrames = FRAMERATE;
      }
    }
    else if (currentRoutine != null) {
      currentRoutine.draw();
    }
    else {
      println("Current method is null");
    }

    if (fadeInFrames > 0) {
      setFadeLayer(240 - fadeInFrames * (240 / FRAMERATE));
      blend(fadeLayer, 0, 0, displayWidth, displayHeight, 0, 0, displayWidth, displayHeight, MULTIPLY);
      fadeInFrames--;
    }

    if (currentRoutine.isDone) {
      currentRoutine.isDone = false;
      newMode();
    }
  }

  sign.sendData();
}

