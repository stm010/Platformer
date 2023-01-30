void victory() {
  //coin.play();
   rectMode (CENTER);
  background (255);
  theme.play();
  go.pause ();
  gg.show();
  if (gg.clicked) {
    mode=INTRO;
  }
}
