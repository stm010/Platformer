void play() {
  
  background (bg1);
  drawWorld();
  player.act();
  actWorld();
    lives();
  //coords();
  if (lives <=0) {
    mode= GAMEOVER;
  }
}
