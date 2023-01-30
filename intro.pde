void intro() {
  go.pause();
  theme.play();
  background (0);
  rectMode (CENTER);
  reset();
  start.show(); //start button
  if (start.clicked) {
    mode=PLAY;
  }
}
