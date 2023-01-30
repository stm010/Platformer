class FLava extends FGameObject {

  PImage[] frames = new PImage[6];
  int gifSpeed = 17; //lower # -> faster speed
  int currentFrame;
  int totalFrames;
  int counter = 0;

  FLava(float x, float y ) {
    super();
    lava1 = loadImage("lava1.png");
    lava2 = loadImage("lava2.png");
    lava3 = loadImage("lava3.png");
    lava4 = loadImage("lava4.png");
    lava5 = loadImage("lava5.png");
    lava6 = loadImage("lava6.png");
    attachImage(lava1);
    setPosition(x, y);
    setName("lava");
    setSensor(true);
    setStatic(true);
    frames[0] = lava1;
    frames[1] = lava2;
    frames[2] = lava3;
    frames[3] = lava4;
    frames[4] = lava5;
    frames[5] = lava6;
    totalFrames = 6;
  }

  void act() {
    int x = (int) random(1, 6);
    if (currentFrame == totalFrames) currentFrame = x;
    attachImage(frames[currentFrame]);
    if (frameCount % gifSpeed == 0) currentFrame++;
  }
}
