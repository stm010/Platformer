void gameOver() {
   rectMode (CENTER);
  background (0);
  go.play();
  theme.pause ();
  gameover.show();
  if (gameover.clicked) {
    mode=INTRO;
  }
}
