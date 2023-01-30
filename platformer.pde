//To-Do:
// - fix intro, gameover screens
// - add gif
// additional features:
// - water
// - fonts
        // - gifwdaopjio
// - music
// - tunnels
// - gamemode (gameover screen, intro, play)

import fisica.*;
FWorld world;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//sv
Minim minim;
AudioPlayer theme, coin, bump, go;

//font
PFont f1;

//colors
color green = #22b14c; //leaves
color greeen = #22b14d;
color brown = #9c5a3c; //trunk
color black = #000000; //dirt
color grey = #b4b4b4;//stone
color yellow = #fff200;//trampoline
color orange = #ff7e00;//spike
color lblue = #00b7ef; //bridge
color blue = #4d6df3; //ice
color red = #ed1c24; //lava
color white = #ffffff;
color navy = #2f3699; //transparent wall
color lorange = #ffc20e; //hammer
color lgreen = #a8e61d; //goomba
color pink = #ffa3b1; //thwomp
color purple = #6f3198; //water
color r = #7cb342;
color l = #8bc34a;
color u = #9ccc65;
color d = #aed581;
color t = #990030;

//resources
PImage map, bg1, nlive, flive;
//earth terrain
PImage ice, stone, trunk, leaves, mleaves, lleaves, rleaves, dirt, mdirt, ldirt, l2dirt, rdirt, r2dirt,
  lava1, lava2, lava3, lava4, lava5, lava6, water1, water2, water3, water4;
//structure terrain
PImage trampoline, spike, bridge, ltunnel, rtunnel, dtunnel, utunnel, treasure;
//misc
PImage thwomp1, thwomp2, goomba1, goomba2, hammerbro1, hammerbro2, hammer;
PImage [] lava;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] hammerbro;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

float zoom = 1.5; //adjust zoom
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, spacekey;
FPlayer player;

Button gameover, start, gg;

int n, f, mode;
int gridSize = 31;
//spike counter
int counter = 100;
//lives
int lives = 3000;

final int INTRO    = 0;
final int PLAY     = 1;
final int GAMEOVER = 2;
final int VICTORY = 3;

//-------------------------------------------------------------------------

void setup () {
  mode = INTRO;
  makeButtons();
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  size (800, 800);
  Fisica.init (this);
  loadImages();
  loadWorld(map);
  loadPlayer();
  minim();
  //font();
  f1 = createFont ("font.ttf", 50);
}


void draw() {
  click();
  if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == VICTORY) {
    victory();
  } else {
    println ("Mode error: " + mode);
  }
}

void loadImages() {
  //resources
  map = loadImage("map.png");
  bg1 = loadImage ("bg1.png");
  bg1.resize (width, height);

  //earth terrain
  ice = loadImage ("ice.png");
  trunk = loadImage ("trunk.png");
  leaves = loadImage ("leaves.png");
  lleaves = loadImage ("lleaves.png");
  mleaves = loadImage ("mleaves.png");
  rleaves = loadImage ("rleaves.png");
  leaves = loadImage ("leaves.png");
  ice.resize(32, 32);
  stone = loadImage ("stone.png");
  dirt = loadImage ("dirt.png");
  mdirt = loadImage ("mdirt.png");
  ldirt = loadImage ("ldirt.png");
  l2dirt = loadImage ("l2dirt.png");
  rdirt = loadImage ("rdirt.png");
  r2dirt = loadImage ("r2dirt.png");

  //structure terrain
  bridge = loadImage ("bridge.png");
  spike = loadImage ("spike.png");
  trampoline = loadImage ("trampoline.png");
  ltunnel = loadImage ("ltunnel.png");
  ltunnel.resize (gridSize, gridSize);
  rtunnel = loadImage ("rtunnel.png");
  rtunnel.resize (gridSize, gridSize);
  dtunnel = loadImage ("dtunnel.png");
  dtunnel.resize (gridSize, gridSize);
  utunnel = loadImage ("utunnel.png");
  utunnel.resize (gridSize, gridSize);
  treasure = loadImage ("treasure.png");
  treasure.resize (gridSize*2, gridSize*2);

  //character
  nlive = loadImage ("nlive.png");
  flive = loadImage ("flive.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump.png");

  idle = new PImage[2];
  idle[0] = loadImage("idle1.png");
  idle[1] = loadImage("idle2.png");

  run = new PImage[3];
  run[0] = loadImage("runright1.png");
  run[1] = loadImage("runright2.png");
  run[2] = loadImage("runright3.png");

  action = idle;

  //mobs
  thwomp1 = loadImage("thwomp1.png");
  thwomp2 = loadImage("thwomp2.png");

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba1.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba2.png");
  goomba[1].resize(gridSize, gridSize);

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro1.png");
  hammerbro[0].resize(gridSize+5, gridSize+5);
  hammerbro[1] = loadImage("hammerbro2.png");
  hammerbro[1].resize(gridSize+5, gridSize+5);
  hammer = loadImage ("hammer.png");
}

void loadWorld (PImage img) {
  world  = new FWorld (-3000, -3000, 3000, 3000);
  world.setGravity (0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //currennt pixel color
      color s = img.get(x, y+1); //south pixel color
      color w = img.get(x-1, y); //west pixel color
      color e = img.get(x+1, y); //east pixel color
      color n = img.get(x, y-1); //north pixel color

      FBox b = new FBox (gridSize, gridSize);
      b.setPosition (x*gridSize, y*gridSize);
      b.setStatic (true);

      //terrain --------------------------------------

      if (c == blue) { //ice
        b.attachImage(ice);
        b.setFriction(0);
        b.setName ("ice");
        world.add(b);
      }

      if (c == orange) { //spike
        b.attachImage (spike);
        b.setName ("spike");
        world.add(b);
      }

      if (c == black && n!=black) { //dirt
        b.attachImage(dirt);
        b.setFriction(10);
        b.setName ("dirt");
        world.add(b);
      }

      if (c == black && n == black  ) { //mdirt
        b.attachImage(mdirt);
        b.setFriction(4);
        b.setName ("mdirt");
        world.add(b);
      }

      if (c == black && w != black  && n!=black) { //ldirt
        b.attachImage(ldirt);
        b.setFriction(4);
        b.setName ("ldirt");
        world.add(b);
      }


      if (c == black && w != black  && n==black && e!=black && s!=black) { //l2dirt
        b.attachImage(l2dirt);
        b.setFriction(4);
        b.setName ("l2dirt");
        world.add(b);
      }

      if (c == black && e!= black  && n!=black) { //rdirt
        b.attachImage(rdirt);
        b.setFriction(4);
        b.setName ("rdirt");
        world.add(b);
      }

      if (c == black && e!= black  && n==black && w!=black && s!=black) { //r2dirt
        b.attachImage(r2dirt);
        b.setFriction(4);
        b.setName ("r2dirt");
        world.add(b);
      }

      if (c == grey) { //stone
        b.attachImage(stone);
        b.setFriction(10);
        b.setName("stone");
        world.add(b);
      }

      if (c == green && s == brown || c == greeen && s == brown) { //trunk w leaves
        b.attachImage(leaves);
        b.setName ("leaves");
        world.add(b);
      }

      if (c == green &&  w != green || c == greeen &&  w != greeen) { //west (=! not)
        b.attachImage(lleaves);
        b.setName ("leaves");
        world.add(b);
      }

      if (c == green &&  e != green || c == greeen &&  e != greeen) { //east
        b.attachImage(rleaves);
        b.setName ("leaves");
        world.add(b);
      }

      if (c == green &&  e == green && w == green && s != brown || c == greeen &&  e == greeen && w == greeen && s != brown) { //middle
        b.attachImage(mleaves);
        b.setName ("leaves");
        world.add(b);
      }

      if (c == brown) { //trunk
        b.attachImage(trunk);
        b.setSensor (true);
        b.setName ("trunk1");
        world.add(b);
      }

      if (c == yellow) { //trampoline
        b.attachImage (trampoline);
        b.setRestitution (1.3);
        b.setFriction (2);
        b.setName ("trampoline");
        world.add(b);
      }

      if (c == u) { //utunnel
        b.attachImage (utunnel);
        b.setName ("utunnel");
        world.add(b);
      }
      if (c == d) { //dtunnel
        b.attachImage (dtunnel);
        b.setName ("dtunnel");
        world.add(b);
      }
      if (c == l) { //ltunnel
        b.attachImage (ltunnel);
        b.setName ("ltunnel");
        world.add(b);
      }
      if (c == r) { //rtunnel
        b.attachImage (rtunnel);
        b.setName ("rtunnel");
        world.add(b);
      }

      if (c == t) { //treasure
        b.attachImage (treasure);
        b.setName ("treasure");
        world.add(b);
      }

      //special terrain

      if (c == red) { //lava
        FLava lava = new FLava(x*gridSize, y*gridSize);
        lava.setName ("lava");
        terrain.add(lava);
        world.add(lava);
      }

      if (c == purple) { //water
        FWater water = new FWater(x*gridSize, y*gridSize);
        water.setName ("water");
        terrain.add(water);
        world.add(water);
      }

      if (c == lblue) { //bridge
        FBridge bridge = new FBridge(x*gridSize, y*gridSize);
        bridge.setFriction (0);
        terrain.add(bridge);
        world.add(bridge);
      }

      //mobs
      if (c==pink) {
        FThwomp thwomp = new FThwomp (x*gridSize, y*gridSize);
        enemies.add(thwomp);
        world.add(thwomp);
      }
      if (c==lgreen) {
        FGoomba goomba = new FGoomba (x*gridSize, y*gridSize);
        enemies.add(goomba);
        world.add(goomba);
      }
      if (c== lorange) {
        FHammerBro hammerbro = new FHammerBro (x*gridSize, y*gridSize);
        enemies.add(hammerbro);
        world.add(hammerbro);
      }
    }
  }
}

void loadPlayer() {
  player=new FPlayer();
  world.add(player);
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
  counter--;
}

void actWorld() {
  player.act();
  for (int i=0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i =0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void lives() {
  if (lives == 3) {
    image (flive, 10, 10, 50, 50);
    image (flive, 60, 10, 50, 50);
    image (flive, 110, 10, 50, 50);
  }
  if (lives == 2) {
    image (flive, 10, 10, 50, 50);
    image (flive, 60, 10, 50, 50);
    image (nlive, 114, 15, 40, 40);
  }
  if (lives == 1) {
    image (flive, 10, 10, 50, 50);
    image (nlive, 65, 15, 40, 40);
    image (nlive, 118, 15, 40, 40);
  }
  if (lives < 1) {
    image (nlive, 15, 15, 40, 40);
    image (nlive, 65, 15, 40, 40);
    image (nlive, 118, 15, 40, 40);
  }
}

void minim () {
  minim = new Minim (this);
  theme = minim.loadFile ("mario bros theme.mp3");
  coin = minim.loadFile ("coin.wav");
  bump = minim.loadFile ("bump.wav");
  go = minim.loadFile ("gameover.wav");
}
