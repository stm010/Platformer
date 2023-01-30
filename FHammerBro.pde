class FHammerBro extends FGoomba {

  FHammerBro(float x, float y) {
    super(x, y);
    setPosition(x, y);
    setName("hammerbro");
  }


  void act() {
    collide();
    move();
    animate();
    hammer();
  }

  void hammer() {
    FBox h = new FBox(20, 20);
    h.setPosition(this.getX(), this.getY());
    h.attachImage(hammer);
    h.setName ("hammer");
    h.setVelocity(random(-300, 300), -300);
    h.setAngularVelocity(12);
    h.setSensor(true);

    if (frameCount % 130 == 0 ) {
      frame++;
      world.add(h);
    }
  }


  void animate() {
    if (frame >= hammerbro.length) frame = 0;
    if (frameCount % 5 == 0 ) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }
}
