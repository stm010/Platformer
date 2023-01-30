class FGoomba extends FGameObject {
  int direction = R;
  int frame = 0;
  int speed = 100;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setRotatable(false);
    setRestitution(0);
    setName("goomba");
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (frame >= goomba.length) frame =0;
    if (frameCount % 20 == 0 ) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }

  void collide() {
    if (isTouching("mdirt")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
      // println (direction);
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize+10) {
        world.remove(this);
        enemies.remove(this);
        coin.rewind();
        coin.play();
      } else {
        lives--;
        bump.rewind();
        bump.play();
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
