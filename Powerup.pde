public class Powerup extends Entity {
  PowerupType type;
  public Powerup(int x, int y) {
    super(x, y, 20, 20);
    type = PowerupType.values()[(int) random(PowerupType.values().length)];
  }
  
  public void render(int camX, int camY) {
    noStroke();
    fill(type.r, type.g, type.b);
    ellipse(x - camX, y - camY, w, h);
  }
  
  void taken() {
    world.powerups.remove(this);
  }
}

public enum PowerupType {
  INFINIJUMP(255, 255, 0),
  NOCOL(0, 255, 255),
  PASSTHROUGH(255, 0, 255),
  
  ;
  private int r, g, b;
  private PowerupType(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
}
