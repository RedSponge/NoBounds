final int BG_COLOR = 0x44AAFF;
boolean[] keys;
boolean[] lastKeys;
void setup() {
  size(500, 500);
  background(BG_COLOR);
  keys = new boolean[256];
  lastKeys = new boolean[256];
  init();
}

void init() {
  world = new World();
}

World world;

void draw() {
  world.tick();
  world.render();
  tickKeys();
}

void tickKeys() {
  for(int i = 0; i < keys.length; i++) {
    lastKeys[i] = keys[i];
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}
