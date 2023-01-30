class FThwomp extends FGameObject {

  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x+gridSize/2, y+ gridSize/2);
    attachImage(thwomp1);
    setName("thowmp");
    setRotatable(false);
    setStatic(true);
  }

  void act() {
    if (player.getX() >= this.getX()-gridSize && player.getX() <= this.getX()+gridSize && player.getY() >= this.getY()-50) {
      setStatic(false);
      attachImage(thwomp2);
    }
  }
}
