PImage reverseImage( PImage image ) {
  PImage reverse;
  reverse = createImage(image.width, image.height, ARGB );
  for ( int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      int xPixel, yPixel;
      xPixel = image.width - 1 - i;
      yPixel = j;
      reverse.pixels[yPixel*image.width+xPixel]=image.pixels[j*image.width+i] ;
    }
  }
  return reverse;
}

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (key == ' ') spacekey = false;

  if (keyCode == UP) upkey = false;
  if (keyCode == DOWN) downkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
}

void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == ' ') spacekey = true;
  if (keyCode == UP) upkey = true;
  if (keyCode == DOWN) downkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;
}

void click() {
  mouseReleased = false;
  if (mousePressed) wasPressed = true;
  if (wasPressed && mousePressed == false) {
    mouseReleased = true;
    wasPressed = false;
  }
}

void makeButtons() {
  start = new Button("START", width/2, height/2, 300, 100, white, red); //start button
  gameover = new Button("gameover", width/2, height/2, 300, 100, white, red); //start button
  gg = new Button("la fin", width/2, height/2, 300, 100, white, red); //start button
}

void reset() {
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  size (800, 800);
  Fisica.init (this);
  loadImages();
  loadWorld(map);
  loadPlayer();
  lives = 3;
}

void coords() {
  textSize (50);
  fill (255);
  text (mouseX + " , " + mouseY, mouseX, mouseY-20);
}

void font() {
  f1 = createFont ("font.ttf", 50);
}
