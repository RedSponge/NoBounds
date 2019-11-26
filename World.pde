class World {
  private ArrayList<Platform> platforms;
  private ArrayList<Powerup> powerups;
  
  private Player player;
  private int camX, camY;
  private int camMover;
  
  
  public World() {
    player = new Player();
    platforms = new ArrayList<Platform>();
    powerups = new ArrayList<Powerup>();
    camX = width / 2;
    camY = height / 2;
    
    for(int i = height; i > -6000; i -= 60) {
      int x = (int) random(width);
      int w = (int) random(50, 100);
      platforms.add(new Platform(x, i, w, 10));
    }
    
    for(int i = -500; i > -6000; i -= 500) {
      int x = (int) random(width);
      powerups.add(new Powerup(x, i));
    }
  }
  
  public void tick() {
    for(Platform p : platforms) {
      p.tick();
    }
    for(Powerup p : powerups) {
      p.tick();
    }
    player.tick();
    camMover++;
    if(camMover % 5 == 0) camY--;
    if(player.y < camY + height / 2) {
      camY = player.y - height / 2;
    }
    
    if(player.y > camY + height + 30) {
      println("DEAD");
      try {
      Thread.sleep(500);
      } catch(Exception e) {}
      init();
    }
  }
  
  public void render() {
    background(BG_COLOR);
    noStroke();
    fill(0);
    rect(0, height - camY, width, height);
    camX = 0;
    for(Platform p : platforms) {
      p.render(camX, camY);
    }
    for(Powerup p : powerups) {
      p.render(camX, camY);
    }
    player.render(camX, camY);
  }
}
