class FPlayer extends FGameObject {
  color playerColor = red;
  int frame;
  int direction;

  FPlayer() {
    super();
    direction = R;
    setPosition(300, 200);
    attachImage(jump[0]);
    setRotatable(false);
    setName("player");
  }

  void act() {
    animate();
    handleInput();

    if (isTouching("spike") && counter < 0) {
      setPosition(50, 50);
      counter = 200;
      lives--;
      bump.rewind();
      bump.play();
    }

    if (isTouching("lava") && counter < 0) {
      counter = 50;
      lives --;
      bump.rewind();
      bump.play();
    }

    if (isTouching("water") && counter < 0) {
      if (lives <= 2) {
        counter = 100;
        lives ++;
      }
    }

    if (isTouching("ltunnel")) {
      setPosition(2530, 330);
    }

    if (isTouching("rtunnel")) {
      setPosition(1000, 900);
    }

    if (isTouching("dtunnel")) {
      setPosition(810, 1400);
    }

    if (isTouching("utunnel")) {
      setPosition(130, 300);
    }


    if (isTouching("thowmp")) {
      lives = 0;
    }

    if (isTouching("hammer") && counter < 0) {
      lives --;
      counter = 50;
      bump.rewind();
      bump.play();
    }

    if (isTouching("treasure")) {
      mode = VICTORY;
    }

    println (lives);
  }

  void animate() {
    if (frame >= action.length) frame =0;
    if (frameCount % 5 == 0 ) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void handleInput() {
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (ifTouching(player)) {
      if (vy == 0) action = idle;
      if (akey) {
        setVelocity(-300, vy);
        direction = L;
      }
      if (dkey) {
        setVelocity(250, vy);
        direction = R;
      }
      if (wkey) setVelocity(vx, -250);
      if (skey) setVelocity(vx, 250);
      if (spacekey) setVelocity(vx, -350);
    }

    if (akey) setVelocity(-250, getVelocityY());
    if (dkey) setVelocity(250, getVelocityY());

    //display action

    if (abs(vy) < 0.1) action = idle;
    if (abs(vy) > 0.1) action = jump;

    if (akey) {
      action = run;
    }

    if (dkey) {
      action = run;
    }
  }

  boolean RPlayerContacts (FBox ground) {
    ArrayList <FContact> PcontactList = player.getContacts();
    int i = 0;
    while (i < PcontactList.size()) {
      FContact myContact = PcontactList.get(i);

      if (myContact.contains(ground)) return true;
      i++;
    }
    return false;
  }

  boolean ifTouching(FBox n) {
    ArrayList<FContact> PcontactList1 = n.getContacts();
    if (0 < PcontactList1.size()) return true;
    return false;
  }
}
