class FWater extends FGameObject {

  int counter = 0;
  PImage[] frames = new PImage[4];
  int gifSpeed = 15; //lower # -> faster speed
  int currentFrame;
  int totalFrames;

  FWater(float x, float y ) {
    super();
    water1 = loadImage("water1.png");
    water2 = loadImage("water2.png");
    water3 = loadImage("water3.png");
    water4 = loadImage("water4.png");

    setPosition(x, y);
    setName("water");
    attachImage(water1);
    setSensor(true);
    setStatic(true);
    frames[0] = water1;
    frames[1] = water2;
    frames[2] = water3;
    frames[3] = water4;

    totalFrames = 4;
  }

  void act() {
    int x = (int)random(1, 4);
    if (currentFrame == totalFrames) currentFrame =x;
    attachImage(frames[currentFrame]);
    if (frameCount % gifSpeed == 0) currentFrame++;
  }
}
