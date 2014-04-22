class Pong extends Routine {
  float ballX;
  float ballY;
  float ballAngle;
  float ballSpeed;
  int paddleY;
  int paddleX;
  int paddleSize;
  long flashUntilFrame;
  long ballFlashUntilFrame;
  boolean deathLeft;
  int lives;

  void setup(PApplet parent) {
    ballY = 0;
    ballX = 0;
    ballAngle = radians(45);
    deathLeft = false;
    ballSpeed = 0.125;
    lives = 3;

    paddleX = displayWidth/2;
    paddleY = 0;
    paddleSize = displayHeight/8;
    ballFlashUntilFrame = frameCount + (long)frameRate * 3;
  }

  void draw() {
    if (frameCount < flashUntilFrame) {
      background(millis() % 255, (millis() % 255)/2, 0);
    }
    else if (lives > 0) {
      drawGameplay();
    }
    else {
      newMode();
    }
  }

  void drawGameplay() {
    background(0);

    if (frameCount > ballFlashUntilFrame) {
      moveBall();
    }
    movePaddle();

    drawBall();
    drawPaddle();
  }

  void drawBall() {
    if (frameCount < ballFlashUntilFrame) {
      stroke(millis() % 255, (millis() % 255)/2, 0);
    }
    else {
      stroke(255);
    }
    point(ballX, ballY);
  }

  void drawPaddle() {
    for (int i=0; i<paddleSize; i++) {

      stroke(255, 64, 64);
      point(paddleX, paddleY+i);
    }
  }

  void movePaddle() {
    if ((keyPressed && keyCode == UP) || controller.buttonUp) {
      paddleY--;
    }
    else if ((keyPressed && keyCode == DOWN) || controller.buttonDown) {
      paddleY++;
    }

    if (paddleY > displayHeight - paddleSize) {
      paddleY = displayHeight - paddleSize;
    }
    else if (paddleY < 0) {
      paddleY = 0;
    }
  }

  void moveBall() {
    float xVec = ballSpeed * cos(ballAngle);
    float yVec = ballSpeed * sin(ballAngle);

    if (abs(xVec) > 1) {
      println("Ball is moving too fast.  "+xVec);
    }

    ballX += xVec;
    ballY += yVec;

    if (ballY >= displayHeight) {
      ballY = displayHeight - 1;
      bounceY();
    }
    else if (ballY < 0) {
      ballY = 0;
      bounceY();
    }

    if (ballX >= displayWidth) {
      ballX = ballX - displayWidth;

      if (!deathLeft) {
        playerDied();
      }
      else {
        deathLeft = false;
      }
    }
    else if (ballX < 0) {
      ballX = displayWidth + ballX;

      if (deathLeft) {
        playerDied();
      }
      else {
        deathLeft = true;
      }
    }

    if (int(ballX) == paddleX && ballY >= paddleY && ballY <= paddleY+paddleSize) {
      bounceX((paddleY+paddleSize-ballY-paddleSize/2)/(paddleSize/2.0));

      if (deathLeft) {
        ballX++;
      }
      else {
        ballX--;
      }
    }
  }

  void playerDied() {
    ballY = paddleY;
    ballX = 2;
    ballAngle = radians(45);
    deathLeft = false;
    flashUntilFrame = frameCount + (long) frameRate * 3;
    ballFlashUntilFrame = flashUntilFrame + (long) frameRate * 3;

    lives--;
  }

  void bounceX(float spin) {
    ballAngle = radians(180 - degrees(ballAngle) - spin * 10);
  }

  void bounceY() {
    ballAngle = radians(360 - degrees(ballAngle) + (random(40) - 20));
  }
}

